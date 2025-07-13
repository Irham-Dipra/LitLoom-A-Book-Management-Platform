const express = require('express');
const router = express.Router();
const usersController = require('../controllers/usersController');
const jwt = require('jsonwebtoken');
const pool = require('../db');
const { body, validationResult } = require('express-validator');

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

router.get('/', usersController.getAllUsers);

// PUT /users/profile - Update user profile
router.put('/profile', [
  body('first_name').optional().isString().trim().isLength({ max: 50 }).withMessage('First name must be a string with max 50 characters'),
  body('last_name').optional().isString().trim().isLength({ max: 50 }).withMessage('Last name must be a string with max 50 characters'),
  body('bio').optional().isString().trim().isLength({ max: 500 }).withMessage('Bio must be a string with max 500 characters'),
  body('profile_picture_url').optional().isURL().withMessage('Profile picture must be a valid URL')
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
    const { first_name, last_name, bio, profile_picture_url } = req.body;

    // Build update query dynamically based on provided fields
    let updateQuery = 'UPDATE users SET ';
    const updateParams = [];
    const updates = [];
    let paramCount = 0;

    if (first_name !== undefined) {
      paramCount++;
      updates.push(`first_name = $${paramCount}`);
      updateParams.push(first_name);
    }

    if (last_name !== undefined) {
      paramCount++;
      updates.push(`last_name = $${paramCount}`);
      updateParams.push(last_name);
    }

    if (bio !== undefined) {
      paramCount++;
      updates.push(`bio = $${paramCount}`);
      updateParams.push(bio);
    }

    if (profile_picture_url !== undefined) {
      paramCount++;
      updates.push(`profile_picture_url = $${paramCount}`);
      updateParams.push(profile_picture_url);
    }

    if (updates.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'No valid fields provided for update'
      });
    }

    updateQuery += updates.join(', ');
    updateQuery += ` WHERE id = $${paramCount + 1} RETURNING id, username, email, first_name, last_name, bio, profile_picture_url, created_at`;
    updateParams.push(userId);

    const result = await pool.query(updateQuery, updateParams);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'User not found'
      });
    }

    res.json({
      success: true,
      message: 'Profile updated successfully',
      user: result.rows[0]
    });

  } catch (error) {
    console.error('Error updating profile:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while updating profile'
    });
  }
});

module.exports = router;
