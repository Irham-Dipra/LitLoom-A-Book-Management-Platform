require('dotenv').config();
const express = require('express'); // imports the exports library
const cors = require('cors');  // imports the CORS middleware

const app = express(); // creates an express app instance
const PORT = process.env.PORT || 3000; // sets port equal to env.port or 3000

// Middleware
app.use(cors()); // applies cors globally, react will need this
app.use(express.json()); // to parse JSON bodies

// Basic route
app.get('/', (req, res) => {
  res.send('Book review backend server is running!');
});

// Start server
app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});


const userRoutes = require('./routes/users'); // add this line

app.use('/users', userRoutes); // mount route
