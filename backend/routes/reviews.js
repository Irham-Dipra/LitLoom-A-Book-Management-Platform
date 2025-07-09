const express = require('express');
const router = express.Router();
const pool = require('../db');

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
        u.username as user_name
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