const express = require('express');
const router = express.Router();
const pool = require('../db');

// GET / - Homepage data with multiple book sections
router.get('/', async (req, res) => {
  try {
    // Query 1: Top 10 books after 2020 based on average rating
    const top2020sQuery = `
      SELECT
        b.id, b.title, b.description, b.publication_date, b.cover_image, b.original_country,
        b.language_id, b.genre_id, b.publication_house_id, b.pdf_url, b.average_rating,
        b.created_at, b.added_by, a.name as "author_name"
      FROM books b
        JOIN book_authors ba ON b.id = ba.book_id
        JOIN authors a ON ba.author_id = a.id
      WHERE EXTRACT(YEAR FROM b.publication_date) >= 2020
      ORDER BY b.average_rating DESC, b.id ASC
      LIMIT 10;
    `;

    // Query 2: Top 10 books of all time based on average rating
    const allTimeQuery = `
      SELECT
        b.id, b.title, b.description, b.publication_date, b.cover_image, b.original_country,
        b.language_id, b.genre_id, b.publication_house_id, b.pdf_url, b.average_rating,
        b.created_at, b.added_by, a.name as "author_name"
      FROM books b
        JOIN book_authors ba ON b.id = ba.book_id
        JOIN authors a ON ba.author_id = a.id
      ORDER BY b.average_rating DESC, b.id ASC
      LIMIT 10;
    `;

    // Query 3: Trending books (recently added books with good ratings)
    const trendingQuery = `
      SELECT
        b.id, b.title, b.description, b.publication_date, b.cover_image, b.original_country,
        b.language_id, b.genre_id, b.publication_house_id, b.pdf_url, b.average_rating,
        b.created_at, b.added_by, a.name as "author_name"
      FROM books b
        JOIN book_authors ba ON b.id = ba.book_id
        JOIN authors a ON ba.author_id = a.id
        WHERE b.created_at >= NOW() - INTERVAL '30 days' 
        AND b.average_rating >= 3.0
      ORDER BY b.created_at DESC, b.average_rating DESC
      LIMIT 10;
    `;

    // Query 4: Classic books (published before 2002)
    const classicQuery = `
      SELECT
        b.id, b.title, b.description, b.publication_date, b.cover_image, b.original_country,
        b.language_id, b.genre_id, b.publication_house_id, b.pdf_url, b.average_rating,
        b.created_at, b.added_by, a.name as "author_name"
      FROM books b
        JOIN book_authors ba ON b.id = ba.book_id
        JOIN authors a ON ba.author_id = a.id
      WHERE EXTRACT(YEAR FROM b.publication_date) < 2002
      ORDER BY b.average_rating DESC, b.publication_date ASC
      LIMIT 10;
    `;

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