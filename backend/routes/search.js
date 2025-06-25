const express = require('express');
const router = express.Router();
const pool = require('../db');

// Search suggestions endpoint - returns book titles that start with the query
router.get('/suggestions', async (req, res) => {
  try {
    const { q } = req.query;
    
    if (!q || q.trim().length === 0) {
      return res.json([]);
    }

    const query = `
      SELECT DISTINCT b.title, b.id, b.cover_image
      FROM books b
      WHERE LOWER(b.title) LIKE LOWER($1)
      ORDER BY b.title
      LIMIT 10
    `;
    
    const result = await pool.query(query, [`${q.trim()}%`]);
    res.json(result.rows);
  } catch (error) {
    console.error('Search suggestions error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Get filter options (genres, languages, publication years)
router.get('/filters', async (req, res) => {
  try {
    // Get genres
    const genresQuery = 'SELECT DISTINCT id, name FROM genres ORDER BY name';
    const genresResult = await pool.query(genresQuery);

    // Get languages
    const languagesQuery = 'SELECT DISTINCT id, name FROM languages ORDER BY name';
    const languagesResult = await pool.query(languagesQuery);

    // Get publication years
    const yearsQuery = `
      SELECT DISTINCT EXTRACT(YEAR FROM publication_date) as year 
      FROM books 
      WHERE publication_date IS NOT NULL 
      ORDER BY year DESC
    `;
    const yearsResult = await pool.query(yearsQuery);

    // Get authors for author filter
    const authorsQuery = 'SELECT DISTINCT id, name FROM authors ORDER BY name';
    const authorsResult = await pool.query(authorsQuery);

    res.json({
      genres: genresResult.rows,
      languages: languagesResult.rows,
      years: yearsResult.rows.map(row => row.year),
      authors: authorsResult.rows
    });
  } catch (error) {
    console.error('Filter options error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Advanced search endpoint with filters
router.get('/books', async (req, res) => {
  try {
    const { 
      q = '', 
      genre, 
      language, 
      year, 
      author, 
      page = 1, 
      limit = 12,
      sortBy = 'title',
      sortOrder = 'ASC'
    } = req.query;

    const offset = (page - 1) * limit;
    let whereConditions = [];
    let queryParams = [];
    let paramIndex = 1;

    // Base query with joins
    let baseQuery = `
      FROM books b
      LEFT JOIN book_authors ba ON b.id = ba.book_id
      LEFT JOIN authors a ON ba.author_id = a.id
      LEFT JOIN genres g ON b.genre_id = g.id
      LEFT JOIN languages l ON b.language_id = l.id
    `;

    // Add search conditions
    if (q && q.trim().length > 0) {
      whereConditions.push(`(
        LOWER(b.title) LIKE LOWER($${paramIndex}) OR 
        LOWER(b.description) LIKE LOWER($${paramIndex}) OR
        LOWER(a.name) LIKE LOWER($${paramIndex})
      )`);
      queryParams.push(`%${q.trim()}%`);
      paramIndex++;
    }

    if (genre) {
      whereConditions.push(`b.genre_id = $${paramIndex}`);
      queryParams.push(genre);
      paramIndex++;
    }

    if (language) {
      whereConditions.push(`b.language_id = $${paramIndex}`);
      queryParams.push(language);
      paramIndex++;
    }

    if (year) {
      whereConditions.push(`EXTRACT(YEAR FROM b.publication_date) = $${paramIndex}`);
      queryParams.push(year);
      paramIndex++;
    }

    if (author) {
      whereConditions.push(`a.id = $${paramIndex}`);
      queryParams.push(author);
      paramIndex++;
    }

    // Build WHERE clause
    const whereClause = whereConditions.length > 0 ? `WHERE ${whereConditions.join(' AND ')}` : '';

    // Count total results
    const countQuery = `
      SELECT COUNT(DISTINCT b.id) as total
      ${baseQuery}
      ${whereClause}
    `;
    const countResult = await pool.query(countQuery, queryParams);
    const totalBooks = parseInt(countResult.rows[0].total);

    // Main search query
    const searchQuery = `
      SELECT DISTINCT
        b.id,
        b.title,
        b.description,
        b.cover_image,
        b.publication_date,
        g.name,
        l.name,
        STRING_AGG(DISTINCT a.name, ', ') as authors
      ${baseQuery}
      ${whereClause}
      GROUP BY b.id, b.title, b.description, b.cover_image, b.publication_date, g.name, l.name
      ORDER BY ${sortBy === 'title' ? 'b.title' : sortBy === 'date' ? 'b.publication_date' : 'b.title'} ${sortOrder}
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;

    queryParams.push(limit, offset);
    const searchResult = await pool.query(searchQuery, queryParams);

    res.json({
      books: searchResult.rows,
      pagination: {
        currentPage: parseInt(page),
        totalPages: Math.ceil(totalBooks / limit),
        totalBooks: totalBooks,
        hasNext: offset + limit < totalBooks,
        hasPrev: page > 1
      }
    });

  } catch (error) {
    console.error('Search books error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;