// backend/routes/userBooks.js - FIXED VERSION
const express = require('express');
const { body, validationResult } = require('express-validator');
const pool = require('../db');

const router = express.Router();

// Middleware to verify JWT token
const jwt = require('jsonwebtoken');
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key-here';

const verifyToken = (req, res, next) => {
  const token = req.header('Authorization')?.replace('Bearer ', '');
  
  if (!token) {
    return res.status(401).json({
      success: false,
      message: 'Access denied. No token provided.'
    });
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    res.status(400).json({
      success: false,
      message: 'Invalid token'
    });
  }
};

// Get user's books with filtering and sorting
router.get('/books', verifyToken, async (req, res) => {
  try {
    const userId = req.user.id;
    const { 
      shelf = 'all', 
      sort = 'date_added', 
      order = 'desc', 
      page = 1, 
      limit = 20 
    } = req.query;

    const offset = (page - 1) * limit;
    
    // Build the query based on shelf filter - FIXED to use correct table/column names
    let query = `
      SELECT 
        b.id,
        b.title,
        (SELECT a.name FROM authors a 
         JOIN book_authors ba ON a.id = ba.author_id 
         WHERE ba.book_id = b.id 
         ORDER BY a.id ASC LIMIT 1) as author,
        b.cover_image as cover_url,
        COALESCE(b.average_rating, 0)::float as avg_rating,
        ub.shelf,
        ub.date_added,
        ub.date_read,
        ub.review_id,
        r.body as review,
        (SELECT g.name FROM genres g 
         JOIN book_genres bg ON g.id = bg.genre_id 
         WHERE bg.book_id = b.id 
         ORDER BY g.id ASC LIMIT 1) as genre,
        l.name as language,
        rt.value as user_rating
      FROM books b
      INNER JOIN user_books ub ON b.id = ub.book_id
      LEFT JOIN reviews r ON ub.review_id = r.id
      LEFT JOIN languages l ON b.language_id = l.id
      LEFT JOIN ratings rt ON b.id = rt.book_id AND rt.user_id = ub.user_id
      WHERE ub.user_id = $1
    `;
    
    const queryParams = [userId];
    let paramCount = 1;

    // Add shelf filter
    if (shelf !== 'all') {
      paramCount++;
      query += ` AND ub.shelf = $${paramCount}`;
      queryParams.push(shelf);
    }

    // Add sorting - FIXED to use correct column names
    const validSortFields = ['date_added', 'date_read', 'title', 'author', 'rating'];
    const sortField = validSortFields.includes(sort) ? sort : 'date_added';
    const sortOrder = order === 'asc' ? 'ASC' : 'DESC';
    
    if (sortField === 'rating') {
      query += ` ORDER BY b.average_rating ${sortOrder}`;
    } else if (sortField === 'title') {
      query += ` ORDER BY b.title ${sortOrder}`;
    } else if (sortField === 'author') {
      query += ` ORDER BY a.name ${sortOrder}`;
    } else {
      query += ` ORDER BY ub.${sortField} ${sortOrder}`;
    }

    // Add pagination
    paramCount++;
    query += ` LIMIT $${paramCount}`;
    queryParams.push(parseInt(limit));
    
    paramCount++;
    query += ` OFFSET $${paramCount}`;
    queryParams.push(offset);

    const books = await pool.query(query, queryParams);

    // Get total count for pagination
    let countQuery = `
      SELECT COUNT(*) as total
      FROM user_books ub
      WHERE ub.user_id = $1
    `;
    
    const countParams = [userId];
    
    if (shelf !== 'all') {
      countQuery += ' AND ub.shelf = $2';
      countParams.push(shelf);
    }

    const countResult = await pool.query(countQuery, countParams);
    const totalBooks = parseInt(countResult.rows[0].total);

    res.json({
      success: true,
      books: books.rows,
      totalBooks,
      currentPage: parseInt(page),
      totalPages: Math.ceil(totalBooks / limit),
      hasNextPage: page * limit < totalBooks,
      hasPrevPage: page > 1
    });

  } catch (error) {
    console.error('Error fetching user books:', error);
    res.status(500).json({ 
      success: false,
      message: 'Server error while fetching books' 
    });
  }
});

// Get user's shelves with book counts
router.get('/shelves', verifyToken, async (req, res) => {
  try {
    const userId = req.user.id;
    
    const query = `
      SELECT 
        shelf as name,
        COUNT(*) as count
      FROM user_books 
      WHERE user_id = $1
      GROUP BY shelf
      ORDER BY 
        CASE shelf 
          WHEN 'want-to-read' THEN 1
          WHEN 'currently-reading' THEN 2
          WHEN 'read' THEN 3
          ELSE 4
        END
    `;

    const shelves = await pool.query(query, [userId]);

    res.json({ 
      success: true,
      shelves: shelves.rows 
    });

  } catch (error) {
    console.error('Error fetching user shelves:', error);
    res.status(500).json({ 
      success: false,
      message: 'Server error while fetching shelves' 
    });
  }
});

// Add a book to user's library
router.post('/books', [
  body('bookId').isInt().withMessage('Book ID must be an integer'),
  body('shelf').optional().isIn(['want-to-read', 'currently-reading', 'read']).withMessage('Invalid shelf value')
], verifyToken, async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        success: false,
        message: 'Validation failed',
        errors: errors.array()
      });
    }

    const userId = req.user.id;
    const { bookId, shelf } = req.body;

    // Check if book exists
    const bookExists = await pool.query('SELECT id FROM books WHERE id = $1', [bookId]);
    if (bookExists.rows.length === 0) {
      return res.status(404).json({ 
        success: false,
        message: 'Book not found' 
      });
    }

    // Check if book is already in user's library
    const existingEntry = await pool.query(
      'SELECT id FROM user_books WHERE user_id = $1 AND book_id = $2',
      [userId, bookId]
    );

    if (existingEntry.rows.length > 0) {
      return res.status(400).json({ 
        success: false,
        message: 'Book already in library' 
      });
    }

    // Add book to user's library
    const insertQuery = `
      INSERT INTO user_books (user_id, book_id, shelf, date_added)
      VALUES ($1, $2, $3, CURRENT_TIMESTAMP)
      RETURNING id
    `;

    const result = await pool.query(insertQuery, [userId, bookId, shelf || null]);

    res.json({ 
      success: true,
      message: 'Book added to library successfully',
      userBookId: result.rows[0].id
    });

  } catch (error) {
    console.error('Error adding book to library:', error);
    res.status(500).json({ 
      success: false,
      message: 'Server error while adding book to library' 
    });
  }
});

// Update book shelf or rating
router.put('/books/:bookId', verifyToken, async (req, res) => {
  const client = await pool.connect();
  
  try {
    // Manual validation since express-validator has issues with null values
    const { shelf, rating, dateRead, notes } = req.body;
    
    if (shelf !== undefined && shelf !== null && !['want-to-read', 'currently-reading', 'read'].includes(shelf)) {
      await client.query('ROLLBACK');
      return res.status(400).json({
        success: false,
        message: 'Invalid shelf value'
      });
    }
    
    if (rating !== undefined && (rating < 1 || rating > 5 || !Number.isInteger(rating))) {
      await client.query('ROLLBACK');
      return res.status(400).json({
        success: false,
        message: 'Rating must be between 1 and 5'
      });
    }

    const userId = req.user.id;
    const { bookId } = req.params;

    // Start transaction
    await client.query('BEGIN');

    // Check if book is in user's library
    const existingEntry = await client.query(
      'SELECT id, shelf FROM user_books WHERE user_id = $1 AND book_id = $2',
      [userId, bookId]
    );

    if (existingEntry.rows.length === 0) {
      await client.query('ROLLBACK');
      return res.status(404).json({ 
        success: false,
        message: 'Book not found in library' 
      });
    }

    // Special case: if unmarking as read (shelf is null), remove from library entirely
    if (shelf === null) {
      await client.query(
        'DELETE FROM user_books WHERE user_id = $1 AND book_id = $2',
        [userId, bookId]
      );

      // Commit transaction
      await client.query('COMMIT');

      return res.json({ 
        success: true,
        message: 'Book removed from library (unmarked as read)' 
      });
    }

    // Build update query for other cases
    let updateQuery = 'UPDATE user_books SET ';
    const updateParams = [];
    const updates = [];
    let paramCount = 0;

    if (shelf !== undefined) {
      paramCount++;
      updates.push(`shelf = $${paramCount}`);
      updateParams.push(shelf);
    }

    // Handle date_read logic
    let dateReadValue = dateRead;
    if (shelf === 'read' && dateRead === undefined) {
      // If marking as read and no specific date provided, use current date
      dateReadValue = new Date();
    }

    if (dateReadValue !== undefined) {
      paramCount++;
      updates.push(`date_read = $${paramCount}`);
      updateParams.push(dateReadValue);
    }

    if (notes !== undefined) {
      paramCount++;
      updates.push(`notes = $${paramCount}`);
      updateParams.push(notes);
    }

    if (updates.length === 0) {
      await client.query('ROLLBACK');
      return res.status(400).json({ 
        success: false,
        message: 'No updates provided' 
      });
    }

    updateQuery += updates.join(', ');
    updateQuery += ` WHERE user_id = $${paramCount + 1} AND book_id = $${paramCount + 2}`;
    updateParams.push(userId, bookId);

    console.log('Update query:', updateQuery);
    console.log('Update params:', updateParams);

    await client.query(updateQuery, updateParams);

    // If rating was updated, also save to ratings table
    if (rating !== undefined) {
      try {
        // Check if rating already exists in ratings table
        const existingRating = await client.query(
          'SELECT id FROM ratings WHERE user_id = $1 AND book_id = $2',
          [userId, bookId]
        );

        if (existingRating.rows.length > 0) {
          // Update existing rating
          await client.query(
            'UPDATE ratings SET value = $1, created_at = CURRENT_TIMESTAMP WHERE user_id = $2 AND book_id = $3',
            [rating, userId, bookId]
          );
        } else {
          // Insert new rating
          await client.query(
            'INSERT INTO ratings (user_id, book_id, value, created_at) VALUES ($1, $2, $3, CURRENT_TIMESTAMP)',
            [userId, bookId, rating]
          );
        }
      } catch (ratingError) {
        console.error('Error updating ratings table:', ratingError);
        await client.query('ROLLBACK');
        throw ratingError;
      }
    }

    // Commit transaction
    await client.query('COMMIT');

    res.json({ 
      success: true,
      message: 'Book updated successfully' 
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error updating book:', error);
    console.error('Stack trace:', error.stack);
    console.error('Error details:', {
      message: error.message,
      code: error.code,
      detail: error.detail,
      hint: error.hint
    });
    res.status(500).json({ 
      success: false,
      message: 'Server error while updating book',
      error: error.message
    });
  } finally {
    client.release();
  }
});

// Remove book from user's library
router.delete('/books/:bookId', verifyToken, async (req, res) => {
  try {
    const userId = req.user.id;
    const { bookId } = req.params;

    const deleteQuery = 'DELETE FROM user_books WHERE user_id = $1 AND book_id = $2';
    const result = await pool.query(deleteQuery, [userId, bookId]);

    if (result.rowCount === 0) {
      return res.status(404).json({ 
        success: false,
        message: 'Book not found in library' 
      });
    }

    res.json({ 
      success: true,
      message: 'Book removed from library successfully' 
    });

  } catch (error) {
    console.error('Error removing book from library:', error);
    res.status(500).json({ 
      success: false,
      message: 'Server error while removing book from library' 
    });
  }
});

// Get reading statistics
router.get('/stats', verifyToken, async (req, res) => {
  try {
    const userId = req.user.id;

    const statsQuery = `
      SELECT 
        COUNT(*) as total_books,
        COUNT(CASE WHEN shelf = 'read' THEN 1 END) as books_read,
        COUNT(CASE WHEN shelf = 'currently-reading' THEN 1 END) as currently_reading,
        COUNT(CASE WHEN shelf = 'want-to-read' THEN 1 END) as want_to_read,
        NULL as avg_rating,
        0 as rated_books
      FROM user_books 
      WHERE user_id = $1
    `;

    const stats = await pool.query(statsQuery, [userId]);

    // Get reading activity by month (last 12 months)
    const monthlyQuery = `
      SELECT 
        TO_CHAR(date_read, 'YYYY-MM') as month,
        COUNT(*) as books_read
      FROM user_books 
      WHERE user_id = $1 AND date_read IS NOT NULL 
        AND date_read >= NOW() - INTERVAL '12 months'
      GROUP BY TO_CHAR(date_read, 'YYYY-MM')
      ORDER BY month DESC
    `;

    const monthlyStats = await pool.query(monthlyQuery, [userId]);

    res.json({
      success: true,
      stats: stats.rows[0],
      monthlyStats: monthlyStats.rows
    });

  } catch (error) {
    console.error('Error fetching reading stats:', error);
    res.status(500).json({ 
      success: false,
      message: 'Server error while fetching reading statistics' 
    });
  }
});

// Rate a book (separate endpoint for ratings table)
router.post('/books/:bookId/rate', verifyToken, async (req, res) => {
  const client = await pool.connect();
  
  try {
    const { rating } = req.body;
    const userId = req.user.id;
    const { bookId } = req.params;

    // Validate rating
    if (!rating || rating < 1 || rating > 5 || !Number.isInteger(rating)) {
      return res.status(400).json({
        success: false,
        message: 'Rating must be an integer between 1 and 5'
      });
    }

    // Start transaction
    await client.query('BEGIN');

    // Check if book exists
    const bookExists = await client.query(
      'SELECT id FROM books WHERE id = $1',
      [bookId]
    );

    if (bookExists.rows.length === 0) {
      await client.query('ROLLBACK');
      return res.status(404).json({
        success: false,
        message: 'Book not found'
      });
    }

    // Check if rating already exists
    const existingRating = await client.query(
      'SELECT id FROM ratings WHERE user_id = $1 AND book_id = $2',
      [userId, bookId]
    );

    if (existingRating.rows.length > 0) {
      // Update existing rating
      await client.query(
        'UPDATE ratings SET value = $1, created_at = CURRENT_TIMESTAMP WHERE user_id = $2 AND book_id = $3',
        [rating, userId, bookId]
      );
    } else {
      // Insert new rating
      await client.query(
        'INSERT INTO ratings (user_id, book_id, value, created_at) VALUES ($1, $2, $3, CURRENT_TIMESTAMP)',
        [userId, bookId, rating]
      );
    }

    // Commit transaction
    await client.query('COMMIT');

    res.json({
      success: true,
      message: 'Rating saved successfully',
      rating: rating
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error saving rating:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while saving rating',
      error: error.message
    });
  } finally {
    client.release();
  }
});

module.exports = router;