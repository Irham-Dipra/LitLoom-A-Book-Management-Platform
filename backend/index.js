require('dotenv').config();
const express = require('express'); // imports the exports library
const cors = require('cors');  // imports the CORS middleware
const pool = require('./db'); // imports the database connection pool
const app = express(); // creates an express app instance
const PORT = process.env.PORT || 3000; // sets port equal to env.port or 3000

// Middleware
app.use(cors()); // applies cors globally, react will need this
app.use(express.json()); // to parse JSON bodies

//Basic route
// app.get('/', (req, res) => {
  //   res.send('Book review backend server is running!');
  // });

const userRoutes = require('./routes/users'); // add this line
const authRoutes = require('./routes/auth'); // add this line
const homeRoutes = require('./routes/home');
 
// Add this line after your existing route imports


app.use('/users', userRoutes); // mount route
app.use('/auth', authRoutes); // mount route for authentication
app.use('/', homeRoutes); // mount home route


app.get('/books/:id', async (req, res) => {
  const { id } = req.params; // get the book ID from the request parameters
  try {
    const book = await pool.query(`SELECT
        b.id, b.title, b.description, b.publication_date, b.cover_image, b.original_country,
        b.language_id, b.genre_id, b.publication_house_id, b.pdf_url, b.average_rating,
        b.created_at, b.added_by, a.name as "author_name"
      FROM books b
        JOIN book_authors ba ON b.id = ba.book_id
        JOIN authors a ON ba.author_id = a.id WHERE b.id = $1`, [id]); // query the database for the book with the given ID
    if (book.rows.length === 0) {
      return res.status(404).json({ message: 'Book not found' }); // if no book is found, send a 404 status code
    }
    res.json(book.rows[0]); // send the book data as JSON
  } catch (err) {
    console.error(err.message); // log any errors
    res.status(500).send('Server error'); // send a 500 status code if there's an error
  }
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running at http://0.0.0.0:${PORT}`);
});




