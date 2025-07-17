const express = require('express');
const jwt = require('jsonwebtoken');
const pool = require('../db');

const router = express.Router();
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key-here';

// Middleware to verify JWT token
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

// POST /wishlist - Add book to wishlist
router.post('/', verifyToken, async (req, res) => {
  const client = await pool.connect();
  
  try {
    const { book_id } = req.body;
    const user_id = req.user.id;

    if (!book_id) {
      return res.status(400).json({
        success: false,
        message: 'Book ID is required'
      });
    }

    // Start transaction
    await client.query('BEGIN');

    // Check if book exists
    const bookExists = await client.query(
      'SELECT id FROM books WHERE id = $1',
      [book_id]
    );

    if (bookExists.rows.length === 0) {
      await client.query('ROLLBACK');
      return res.status(404).json({
        success: false,
        message: 'Book not found'
      });
    }

    // Check if book is already in user library
    const existingEntry = await client.query(
      'SELECT * FROM user_books WHERE user_id = $1 AND book_id = $2',
      [user_id, book_id]
    );

    if (existingEntry.rows.length > 0) {
      await client.query('ROLLBACK');
      return res.status(400).json({
        success: false,
        message: 'Book is already in your library'
      });
    }

    // Add to wishlist (want-to-read shelf)
    const newWish = await client.query(
      'INSERT INTO user_books (user_id, book_id, shelf, date_added) VALUES ($1, $2, $3, CURRENT_TIMESTAMP) RETURNING *',
      [user_id, book_id, 'want-to-read']
    );

    // Commit transaction
    await client.query('COMMIT');

    res.status(201).json({
      success: true,
      message: 'Book added to wishlist successfully',
      wishlist_item: newWish.rows[0]
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Add to wishlist error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while adding to wishlist'
    });
  } finally {
    client.release();
  }
});

// GET /wishlist - Get user's wishlist
router.get('/', verifyToken, async (req, res) => {
  try {
    const user_id = req.user.id;

    const wishlist = await pool.query(
      `SELECT ub.*, b.* 
       FROM user_books ub 
       JOIN books b ON ub.book_id = b.id 
       WHERE ub.user_id = $1 AND ub.shelf = $2`,
      [user_id, 'want-to-read']
    );

    res.json({
      success: true,
      message: 'Wishlist fetched successfully',
      wishlist: wishlist.rows,
      count: wishlist.rows.length
    });

  } catch (error) {
    console.error('Get wishlist error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while fetching wishlist'
    });
  }
});

// DELETE /wishlist/:book_id - Remove book from wishlist
router.delete('/:book_id', verifyToken, async (req, res) => {
  const client = await pool.connect();
  
  try {
    const { book_id } = req.params;
    const user_id = req.user.id;

    // Start transaction
    await client.query('BEGIN');

    // Check if book exists in wishlist
    const existingWish = await client.query(
      'SELECT * FROM user_books WHERE user_id = $1 AND book_id = $2 AND shelf = $3',
      [user_id, book_id, 'want-to-read']
    );

    if (existingWish.rows.length === 0) {
      await client.query('ROLLBACK');
      return res.status(404).json({
        success: false,
        message: 'Book not found in your wishlist'
      });
    }

    // Remove from wishlist
    const result = await client.query(
      'DELETE FROM user_books WHERE user_id = $1 AND book_id = $2 AND shelf = $3 RETURNING *',
      [user_id, book_id, 'want-to-read']
    );

    // Commit transaction
    await client.query('COMMIT');

    res.json({
      success: true,
      message: 'Book removed from wishlist successfully',
      removed_item: result.rows[0]
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Remove from wishlist error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while removing from wishlist'
    });
  } finally {
    client.release();
  }
});

module.exports = router;