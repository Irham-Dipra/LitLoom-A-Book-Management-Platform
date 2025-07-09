// backend/routes/addBook.js
const express = require('express');
const pool = require('../db'); 
const router = express.Router();

// === GENRES ===
router.get('/genres', async (req, res) => {
  try {
    const result = await pool.query('SELECT id, name FROM genres ORDER BY name');
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ success: false, message: 'Server error while fetching genres' });
  }
});

router.post('/genres', async (req, res) => {
  const { name } = req.body;
  if (!name) return res.status(400).json({ success: false, message: 'Genre name required' });
  try {
    const result = await pool.query('INSERT INTO genres (name) VALUES ($1) RETURNING id, name', [name.trim()]);
    res.status(201).json({ success: true, genre: result.rows[0] });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error adding genre' });
  }
});

// === LANGUAGES ===
router.get('/languages', async (req, res) => {
  try {
    const result = await pool.query('SELECT id, name, iso_code FROM languages ORDER BY name');
    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ success: false, message: 'Server error while fetching languages' });
  }
});

router.post('/languages', async (req, res) => {
  const { name, iso_code } = req.body;
  if (!name || !iso_code) return res.status(400).json({ success: false, message: 'Name and ISO code required' });
  try {
    const result = await pool.query('INSERT INTO languages (name, iso_code) VALUES ($1, $2) RETURNING id, name, iso_code', [name.trim(), iso_code.trim()]);
    res.status(201).json({ success: true, language: result.rows[0] });
  } catch (error) {
    res.status(500).json({ success: false, message: 'Error adding language' });
  }
});

// === PUBLICATION HOUSES ===
router.get('/publication_houses', async (req, res) => {
  try {
    const result = await pool.query('SELECT id, name FROM publication_houses ORDER BY name');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching publication houses:', error);
    res.status(500).json({ success: false, message: 'Error fetching publication houses' });
  }
});

router.post('/publication_houses', async (req, res) => {
  const { name, address, country, contact_email } = req.body;
  if (!name || !address || !country || !contact_email) return res.status(400).json({ success: false, message: 'All fields required' });
  try {
    const result = await pool.query('INSERT INTO publication_houses (name, address, country, contact_email) VALUES ($1, $2, $3, $4) RETURNING id, name', [name.trim(), address.trim(), country.trim(), contact_email.trim()]);
    res.status(201).json({ success: true, publication_house: result.rows[0] });
  } catch (error) {
    console.error('Error adding publication house:', error);
    res.status(500).json({ success: false, message: 'Error adding publication house' });
  }
});

// === AUTHORS ===
router.get('/authors', async (req, res) => {
  try {
    const result = await pool.query('SELECT id, name FROM authors ORDER BY name');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching authors:', error);
    res.status(500).json({ success: false, message: 'Error fetching authors' });
  }
});

router.post('/authors', async (req, res) => {
  const { name, bio, date_of_birth, country } = req.body;
  if (!name || !date_of_birth || !country) return res.status(400).json({ success: false, message: 'Name, DOB and Country required' });
  try {
    const result = await pool.query('INSERT INTO authors (name, bio, date_of_birth, country) VALUES ($1, $2, $3, $4) RETURNING id, name', [name.trim(), bio.trim(), date_of_birth, country.trim()]);
    res.status(201).json({ success: true, author: result.rows[0] });
  } catch (error) {
    console.error('Error adding author:', error);
    res.status(500).json({ success: false, message: 'Error adding author' });
  }
});

// === ADD BOOK ===
router.post('/books', async (req, res) => {
  const {
    title,
    description,
    publication_date,
    cover_image,
    original_country,
    pdf_url,
    genre_id,
    language_id,
    publication_house_id,
    author_ids,
    added_by // moderator id
  } = req.body;

  if (!title || !genre_id || !language_id || !publication_house_id || !author_ids || !added_by) {
    return res.status(400).json({ success: false, message: 'Missing required fields' });
  }

  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    const bookResult = await client.query(`
      INSERT INTO books (
        title, description, publication_date, cover_image, original_country, pdf_url,
        genre_id, language_id, publication_house_id, average_rating, created_at, added_by
      ) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,0,NOW(),$10)
      RETURNING id
    `, [title, description, publication_date, cover_image, original_country, pdf_url,
        genre_id, language_id, publication_house_id, added_by]);

    const bookId = bookResult.rows[0].id;

    for (const authorId of author_ids) {
      await client.query('INSERT INTO book_authors (book_id, author_id) VALUES ($1, $2)', [bookId, authorId]);
    }

    await client.query('COMMIT');
    res.status(201).json({ success: true, book_id: bookId });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error adding book:', error);
    res.status(500).json({ success: false, message: 'Error adding book' });
  } finally {
    client.release();
  }
});

module.exports = router;
