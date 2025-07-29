const express = require('express');
const router = express.Router();
const pool = require('../db');
const jwt = require('jsonwebtoken');
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key-here';

// GET / - Homepage data with multiple book sections
router.get('/', async (req, res) => {
  try {
    // Check if user is authenticated (optional)
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

    // Use a subquery approach to get first author and avoid duplicates
    const buildQuery = (whereClause = '', orderClause = '') => {
      const userSelect = userId ? `, ub.shelf, rt.value as user_rating` : `, null as shelf, null as user_rating`;
      const userJoin = userId ? `LEFT JOIN user_books ub ON b.id = ub.book_id AND ub.user_id = ${userId}` : '';
      const ratingJoin = userId ? `LEFT JOIN ratings rt ON b.id = rt.book_id AND rt.user_id = ${userId}` : '';
      
      return `
        SELECT 
          b.id, b.title, b.description, b.publication_date, b.cover_image, b.original_country,
          b.language_id, b.publication_house_id, b.average_rating,
          b.created_at, b.added_by,
          (SELECT a.name FROM authors a 
           JOIN book_authors ba ON a.id = ba.author_id 
           WHERE ba.book_id = b.id 
           ORDER BY a.id ASC LIMIT 1) as author_name,
          (SELECT a.id FROM authors a 
           JOIN book_authors ba ON a.id = ba.author_id 
           WHERE ba.book_id = b.id 
           ORDER BY a.id ASC LIMIT 1) as author_id,
          (
            SELECT array_agg(DISTINCT g.name ORDER BY g.name)
            FROM genres g
            JOIN book_genres bg ON g.id = bg.genre_id
            WHERE bg.book_id = b.id
          ) as genres
          ${userSelect}
        FROM books b
        ${userJoin}
        ${ratingJoin}
        ${whereClause}
        ${orderClause}
        LIMIT 10;
      `;
    };

    // Query 1: Top 10 books after 2020 based on average rating
    const top2020sQuery = buildQuery(
      `WHERE EXTRACT(YEAR FROM b.publication_date) >= 2020`,
      `ORDER BY b.average_rating DESC, b.id ASC`
    );

    // Query 2: Top 10 books of all time based on average rating
    const allTimeQuery = buildQuery(
      ``,
      `ORDER BY b.average_rating DESC, b.id ASC`
    );

    // Query 3: Trending books (recently added books with good ratings)
    const trendingQuery = buildQuery(
      `WHERE b.created_at >= NOW() - INTERVAL '30 days' AND b.average_rating >= 3.0`,
      `ORDER BY b.created_at DESC, b.average_rating DESC`
    );

    // Query 4: Classic books (published before 2002)
    const classicQuery = buildQuery(
      `WHERE EXTRACT(YEAR FROM b.publication_date) < 2002`,
      `ORDER BY b.average_rating DESC, b.publication_date ASC`
    );

    // Execute all queries concurrently
    const [top2020sResult, allTimeResult, trendingResult, classicResult] = await Promise.all([
      pool.query(top2020sQuery),
      pool.query(allTimeQuery),
      pool.query(trendingQuery),
      pool.query(classicQuery)
    ]);

    // Prepare response data
    const responseData = {
      success: true,
      message: 'Homepage data fetched successfully',
      data: {
        topBooks2020s: {
          title: 'Best Books Since 2020',
          books: top2020sResult.rows,
          count: top2020sResult.rows.length
        },
        allTimeFavorites: {
          title: 'All-Time Favorites',
          books: allTimeResult.rows,
          count: allTimeResult.rows.length
        },
        trending: {
          title: 'Trending This Month',
          books: trendingResult.rows,
          count: trendingResult.rows.length
        },
        classics: {
          title: 'Timeless Classics',
          books: classicResult.rows,
          count: classicResult.rows.length
        }
      }
    };

    res.json(responseData);

  } catch (error) {
    console.error('Error fetching homepage data:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch homepage data',
      error: error.message
    });
  }
});

module.exports = router;