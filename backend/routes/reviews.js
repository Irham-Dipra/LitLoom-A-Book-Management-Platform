const express = require('express');
const router = express.Router();
const pool = require('../db');
const jwt = require('jsonwebtoken');

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

// POST /reviews
router.post('/', async (req, res) => {
  const { user_id, book_id, title, body } = req.body;

  // Temporary static rating (can update to accept from frontend later)
  const rating = 4;

  if (!user_id || !book_id || !title || !body) {
    return res.status(400).json({ message: 'Missing required fields' });
  }

  try {
    const result = await pool.query(
      `INSERT INTO reviews (user_id, book_id, title, body, rating, created_at, updated_at)
       VALUES ($1, $2, $3, $4, $5, NOW(), NOW())
       RETURNING *`,
      [user_id, book_id, title, body, rating]
    );

    res.status(201).json({
      message: '✅ Review added successfully',
      review: result.rows[0],
    });
  } catch (err) {
    console.error('❌ Error inserting review:', err.message);
    res.status(500).json({ message: 'Server error' });
  }
});

// GET /reviews/user - Get all reviews by the authenticated user
router.get('/user', verifyToken, async (req, res) => {
  try {
    const userId = req.user.id;

    const result = await pool.query(
      `SELECT 
        r.id, 
        r.book_id, 
        r.user_id, 
        r.title as review_title, 
        r.body, 
        r.rating, 
        r.created_at, 
        r.updated_at,
        b.title as book_title,
        b.cover_image,
        a.name as author_name
      FROM reviews r
      JOIN books b ON r.book_id = b.id
      JOIN book_authors ba ON b.id = ba.book_id
      JOIN authors a ON ba.author_id = a.id
      WHERE r.user_id = $1
      ORDER BY r.created_at DESC`,
      [userId]
    );

    res.json({
      success: true,
      reviews: result.rows
    });
  } catch (err) {
    console.error('Error fetching user reviews:', err);
    res.status(500).json({ 
      success: false,
      message: 'Server error while fetching reviews',
      error: err.message 
    });
  }
});

// GET /reviews/book/:bookId - Get all reviews for a specific book
router.get('/book/:bookId', async (req, res) => {
  const { bookId } = req.params;

  console.log('📖 Fetching reviews for book ID:', bookId);

  try {
    const result = await pool.query(
      `SELECT 
        r.id, 
        r.book_id, 
        r.user_id, 
        r.title, 
        r.body, 
        r.rating, 
        r.created_at, 
        r.updated_at,
        u.username as user_name,
        u.first_name,
        u.last_name,
        u.profile_picture_url
      FROM reviews r
      JOIN users u ON r.user_id = u.id
      WHERE r.book_id = $1
      ORDER BY r.created_at DESC`,
      [bookId]
    );

    console.log('✅ Reviews fetched successfully:', result.rows.length, 'reviews found');
    res.json(result.rows);
  } catch (err) {
    console.error('❌ Error fetching reviews:', err);
    console.error('❌ Error details:', {
      message: err.message,
      code: err.code,
      detail: err.detail,
      hint: err.hint,
      position: err.position,
      routine: err.routine
    });
    res.status(500).json({ message: 'Server error', error: err.message });
  }
});

module.exports = router;