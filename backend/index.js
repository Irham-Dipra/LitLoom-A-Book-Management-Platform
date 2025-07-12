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
const filterOptionsRoutes = require('./routes/filter-options');
const addBookRoutes = require('./routes/addbook');
const reviewRoutes = require('./routes/reviews');
const userBooksRoutes = require('./routes/userBooks');



app.use('/users', userRoutes);
app.use('/auth', authRoutes);
app.use('/', homeRoutes);
app.use('/wishlist', wishlistRoutes);
app.use('/search', searchRoutes);
app.use('/filter-options', filterOptionsRoutes);
app.use('/addBook', addBookRoutes);
app.use('/reviews', reviewRoutes);
app.use('/myBooks', userBooksRoutes);

app.get('/books/:id', async (req, res) => {
  const { id } = req.params; 
  try {
    // Check if user is authenticated (optional)
    let userId = null;
    const token = req.header('Authorization')?.replace('Bearer ', '');
    
    if (token) {
      const jwt = require('jsonwebtoken');
      const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key-here';
      try {
        const decoded = jwt.verify(token, JWT_SECRET);
        userId = decoded.id;
      } catch (error) {
        // Token invalid, but we'll continue without user data
        console.log('Invalid token provided, continuing without user data');
      }
    }

    // Base query for book details
    let query = `
      SELECT
        b.id, b.title, b.description, b.publication_date, b.cover_image, b.original_country,
        b.language_id, b.genre_id, b.publication_house_id, b.pdf_url, b.average_rating,
        b.created_at, b.added_by, a.name as "author_name"
    `;

    // If user is authenticated, include their rating and shelf
    if (userId) {
      query += `, COALESCE(ub.user_rating, 0) as user_rating, ub.shelf`;
    } else {
      query += `, 0 as user_rating, null as shelf`;
    }

    query += `
      FROM books b
        JOIN book_authors ba ON b.id = ba.book_id
        JOIN authors a ON ba.author_id = a.id
    `;

    if (userId) {
      query += `LEFT JOIN user_books ub ON b.id = ub.book_id AND ub.user_id = ${userId}`;
    }

    query += ` WHERE b.id = $1`;

    const book = await pool.query(query, [id]);
    
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




