const express = require('express');
const router = express.Router();
const pool = require('../db');

// GET /filter-options - Fetch all available filter options
router.get('/', async (req, res) => {
  try {
    const data = {};

    // Get all languages that have books
    const languagesQuery = `
      SELECT DISTINCT l.id as value, l.name as label
      FROM languages l
      INNER JOIN books b ON l.id = b.language_id
      ORDER BY l.name;
    `;
    const languagesResult = await pool.query(languagesQuery);
    data.languages = languagesResult.rows;

    // Get all genres that have books
    const genresQuery = `
      SELECT DISTINCT g.id as value, g.name as label
      FROM genres g
      INNER JOIN books b ON g.id = b.genre_id
      ORDER BY g.name;
    `;
    const genresResult = await pool.query(genresQuery);
    data.genres = genresResult.rows;

    // Get all authors that have books
    const authorsQuery = `
      SELECT DISTINCT a.id as value, a.name as label
      FROM authors a
      INNER JOIN book_authors ba ON a.id = ba.author_id
      INNER JOIN books b ON ba.book_id = b.id
      ORDER BY a.name;
    `;
    const authorsResult = await pool.query(authorsQuery);
    data.authors = authorsResult.rows;

    // Get all publishers that have books
    const publishersQuery = `
      SELECT DISTINCT ph.id as value, ph.name as label
      FROM publication_houses ph
      INNER JOIN books b ON ph.id = b.publication_house_id
      ORDER BY ph.name;
    `;
    const publishersResult = await pool.query(publishersQuery);
    data.publishers = publishersResult.rows;

    // Get all countries that have books
    const countriesQuery = `
      SELECT DISTINCT b.original_country as value, b.original_country as label
      FROM books b
      WHERE b.original_country IS NOT NULL 
        AND b.original_country != ''
        AND TRIM(b.original_country) != ''
      ORDER BY b.original_country;
    `;
    const countriesResult = await pool.query(countriesQuery);
    data.countries = countriesResult.rows;

    // Get publication date range
    const dateRangeQuery = `
      SELECT 
        MIN(EXTRACT(YEAR FROM b.publication_date)) as min_year,
        MAX(EXTRACT(YEAR FROM b.publication_date)) as max_year
      FROM books b
      WHERE b.publication_date IS NOT NULL;
    `;
    const dateRangeResult = await pool.query(dateRangeQuery);
    data.dateRange = {
      min: dateRangeResult.rows[0]?.min_year || 1800,
      max: dateRangeResult.rows[0]?.max_year || 2025
    };

    // Get rating range
    const ratingRangeQuery = `
      SELECT 
        MIN(b.average_rating) as min_rating,
        MAX(b.average_rating) as max_rating
      FROM books b
      WHERE b.average_rating IS NOT NULL;
    `;
    const ratingRangeResult = await pool.query(ratingRangeQuery);
    data.ratingRange = {
      min: Math.floor((ratingRangeResult.rows[0]?.min_rating || 0) * 10) / 10,
      max: Math.ceil((ratingRangeResult.rows[0]?.max_rating || 5) * 10) / 10
    };

    res.json({
      success: true,
      message: 'Filter options fetched successfully',
      data
    });

  } catch (err) {
    console.error('Error in /filter-options:', err);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch filter options',
      error: err.message
    });
  }
});

module.exports = router;