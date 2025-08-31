const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  user: process.env.DB_USER || 'postgres',
  host: process.env.DB_HOST || 'db.vptaxhbczlifinecnygf.supabase.co',
  database: process.env.DB_NAME || 'postgres',
  password: process.env.DB_PASSWORD || 'litloom3223',
  port: process.env.DB_PORT || 5432,
  ssl: {
    rejectUnauthorized: false, // required for Supabase
  },
});

module.exports = pool;
