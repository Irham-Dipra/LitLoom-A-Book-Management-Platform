#!/usr/bin/env node

const { Pool } = require('./backend/node_modules/pg');
const fs = require('fs');
const path = require('path');

// Database connection using same config as backend
const pool = new Pool({
  host: 'localhost',
  user: 'postgres',
  password: 'dipra3223',
  database: 'litloom',
  port: 5432,
});

async function getDatabaseStatus() {
  try {
    const client = await pool.connect();
    
    // Get database version
    const versionResult = await client.query('SELECT version()');
    const version = versionResult.rows[0].version;
    
    // Get table counts
    const counts = await Promise.all([
      client.query('SELECT COUNT(*) as count FROM books'),
      client.query('SELECT COUNT(*) as count FROM users'),
      client.query('SELECT COUNT(*) as count FROM authors'),
      client.query('SELECT COUNT(*) as count FROM reviews'),
      client.query('SELECT COUNT(*) as count FROM ratings'),
    ]);
    
    // Get recent books
    const recentBooks = await client.query(`
      SELECT b.title, b.publication_date, b.average_rating, g.name as genre 
      FROM books b 
      LEFT JOIN genres g ON b.genre_id = g.id 
      ORDER BY b.created_at DESC 
      LIMIT 3
    `);
    
    // Get database size
    const sizeResult = await client.query(`
      SELECT pg_size_pretty(pg_database_size('litloom')) as size
    `);
    
    client.release();
    
    const status = {
      timestamp: new Date().toISOString(),
      database: 'litloom',
      status: 'connected',
      version: version.split(' ')[1],
      size: sizeResult.rows[0].size,
      tables: {
        books: parseInt(counts[0].rows[0].count),
        users: parseInt(counts[1].rows[0].count),
        authors: parseInt(counts[2].rows[0].count),
        reviews: parseInt(counts[3].rows[0].count),
        ratings: parseInt(counts[4].rows[0].count),
      },
      recent_books: recentBooks.rows,
      connection_pool: {
        total: pool.totalCount,
        idle: pool.idleCount,
        waiting: pool.waitingCount,
      }
    };
    
    return status;
    
  } catch (error) {
    return {
      timestamp: new Date().toISOString(),
      database: 'litloom',
      status: 'error',
      error: error.message,
    };
  }
}

async function main() {
  const status = await getDatabaseStatus();
  
  // Write to status file
  const statusFile = path.join(__dirname, 'database-status.json');
  fs.writeFileSync(statusFile, JSON.stringify(status, null, 2));
  
  // Print to console
  console.log('=== LitLoom Database Status ===');
  console.log(`Status: ${status.status}`);
  console.log(`Database: ${status.database}`);
  
  if (status.status === 'connected') {
    console.log(`Version: PostgreSQL ${status.version}`);
    console.log(`Size: ${status.size}`);
    console.log('\nData Counts:');
    console.log(`  Books: ${status.tables.books}`);
    console.log(`  Users: ${status.tables.users}`);
    console.log(`  Authors: ${status.tables.authors}`);
    console.log(`  Reviews: ${status.tables.reviews}`);
    console.log(`  Ratings: ${status.tables.ratings}`);
    
    console.log('\nRecent Books:');
    status.recent_books.forEach(book => {
      console.log(`  "${book.title}" (${book.genre}) - ${book.average_rating}★`);
    });
    
    console.log(`\nConnection Pool: ${status.connection_pool.total} total, ${status.connection_pool.idle} idle`);
  } else {
    console.log(`Error: ${status.error}`);
  }
  
  console.log(`\nStatus saved to: ${statusFile}`);
  process.exit(0);
}

if (require.main === module) {
  main();
}

module.exports = { getDatabaseStatus };