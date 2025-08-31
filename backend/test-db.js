const { Pool } = require('pg');
require('dotenv').config(); // if you’re using .env for credentials

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

pool.connect()
  .then(client => {
    console.log('✅ Connected to database successfully!');
    client.release();
    process.exit(0);
  })
  .catch(err => {
    console.error('❌ Connection failed:', err.message);
    process.exit(1);
  });
