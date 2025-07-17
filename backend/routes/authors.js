const express = require('express');
const router = express.Router();
const pool = require('../db');
const jwt = require('jsonwebtoken');
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key-here';

// GET /authors/:id - Get author details with their books
router.get('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    
    // Check if user is authenticated (optional for public author pages)
    let userId = null;
    const token = req.header('Authorization')?.replace('Bearer ', '');
    
    if (token) {
      try {
        const decoded = jwt.verify(token, JWT_SECRET);
        userId = decoded.id;
      } catch (error) {
        // Token invalid, but we'll continue without user data
        console.log('Invalid token provided, continuing without user data');
      }
    }

    // Get author details
    const authorQuery = `
      SELECT 
        id,
        name,
        bio,
        author_image
      FROM authors 
      WHERE id = $1
    `;
    
    const authorResult = await pool.query(authorQuery, [id]);
    
    if (authorResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Author not found'
      });
    }

    const author = authorResult.rows[0];

    // Get all books by this author with user data if authenticated
    const userSelect = userId ? `, ub.shelf, rt.value as user_rating` : `, null as shelf, null as user_rating`;
    const userJoin = userId ? `LEFT JOIN user_books ub ON b.id = ub.book_id AND ub.user_id = ${userId}` : '';
    const ratingJoin = userId ? `LEFT JOIN ratings rt ON b.id = rt.book_id AND rt.user_id = ${userId}` : '';
    
    const booksQuery = `
      SELECT 
        b.id,
        b.title,
        b.description,
        b.publication_date,
        b.cover_image,
        b.original_country,
        b.average_rating,
        b.isbn,
        b.page as pages,
        l.name as language_name,
        ph.name as publisher_name,
        (SELECT g.name FROM genres g 
         JOIN book_genres bg ON g.id = bg.genre_id 
         WHERE bg.book_id = b.id 
         ORDER BY g.id ASC LIMIT 1) as genre
        ${userSelect}
      FROM books b
      JOIN book_authors ba ON b.id = ba.book_id
      LEFT JOIN languages l ON b.language_id = l.id
      LEFT JOIN publication_houses ph ON b.publication_house_id = ph.id
      ${userJoin}
      ${ratingJoin}
      WHERE ba.author_id = $1
      ORDER BY b.publication_date DESC, b.title ASC
    `;

    const booksResult = await pool.query(booksQuery, [id]);

    // Get co-authors for books where this author has collaborations
    const coAuthorsQuery = `
      SELECT 
        ba.book_id,
        a.id as author_id,
        a.name as author_name
      FROM book_authors ba
      JOIN authors a ON ba.author_id = a.id
      WHERE ba.book_id IN (
        SELECT book_id FROM book_authors WHERE author_id = $1
      )
      AND ba.author_id != $1
      ORDER BY ba.book_id, a.name
    `;

    const coAuthorsResult = await pool.query(coAuthorsQuery, [id]);

    // Group co-authors by book
    const coAuthorsByBook = {};
    coAuthorsResult.rows.forEach(row => {
      if (!coAuthorsByBook[row.book_id]) {
        coAuthorsByBook[row.book_id] = [];
      }
      coAuthorsByBook[row.book_id].push({
        id: row.author_id,
        name: row.author_name
      });
    });

    // Add co-authors to books
    const booksWithCoAuthors = booksResult.rows.map(book => ({
      ...book,
      co_authors: coAuthorsByBook[book.id] || []
    }));

    res.json({
      success: true,
      data: {
        author,
        books: booksWithCoAuthors,
        total_books: booksWithCoAuthors.length
      }
    });

  } catch (error) {
    console.error('Error fetching author details:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while fetching author details',
      error: error.message
    });
  }
});

// GET /authors - Get all authors (for search/browse functionality)
router.get('/', async (req, res) => {
  try {
    const { search, limit = 50, offset = 0 } = req.query;
    
    let query = `
      SELECT 
        a.id,
        a.name,
        a.bio,
        a.author_image,
        COUNT(ba.book_id) as book_count
      FROM authors a
      LEFT JOIN book_authors ba ON a.id = ba.author_id
    `;
    
    const queryParams = [];
    let paramCount = 0;

    if (search) {
      paramCount++;
      query += ` WHERE a.name ILIKE $${paramCount}`;
      queryParams.push(`%${search}%`);
    }

    query += ` GROUP BY a.id, a.name, a.bio, a.author_image`;
    query += ` ORDER BY a.name ASC`;
    
    paramCount++;
    query += ` LIMIT $${paramCount}`;
    queryParams.push(parseInt(limit));
    
    paramCount++;
    query += ` OFFSET $${paramCount}`;
    queryParams.push(parseInt(offset));

    const result = await pool.query(query, queryParams);

    res.json({
      success: true,
      data: {
        authors: result.rows,
        total: result.rows.length
      }
    });

  } catch (error) {
    console.error('Error fetching authors:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while fetching authors',
      error: error.message
    });
  }
});

module.exports = router;