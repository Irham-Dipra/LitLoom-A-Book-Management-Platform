require('dotenv').config();
const express = require('express');
const cors = require('cors');
const pool = require('./db');
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());


const userRoutes = require('./routes/users');
const authRoutes = require('./routes/auth');
const homeRoutes = require('./routes/home');
const wishlistRoutes = require('./routes/wishlist');
const searchRoutes = require('./routes/search');



app.use('/users', userRoutes);
app.use('/auth', authRoutes);
app.use('/', homeRoutes);
app.use('/wishlist', wishlistRoutes);
app.use('/search', searchRoutes);


app.get('/books/:id', async (req, res) => {
  const { id } = req.params; 
  try {
    const book = await pool.query(`SELECT
        b.id, b.title, b.description, b.publication_date, b.cover_image, b.original_country,
        b.language_id, b.genre_id, b.publication_house_id, b.pdf_url, b.average_rating,
        b.created_at, b.added_by, a.name as "author_name"
      FROM books b
        JOIN book_authors ba ON b.id = ba.book_id
        JOIN authors a ON ba.author_id = a.id WHERE b.id = $1`, [id]);
    if (book.rows.length === 0) {
      return res.status(404).json({ message: 'Book not found' });
    }
    res.json(book.rows[0]);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server error');
  }
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running at port ${PORT}`);
});




