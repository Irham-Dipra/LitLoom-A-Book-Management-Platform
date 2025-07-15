#!/usr/bin/env node

const path = require('path');
require(path.join(__dirname, '..', 'backend', 'node_modules', 'dotenv')).config({ path: path.join(__dirname, '..', 'backend', '.env') });
const { Pool } = require(path.join(__dirname, '..', 'backend', 'node_modules', 'pg'));

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'dipra3223',
  database: process.env.DB_NAME || 'litloom',
  port: process.env.DB_PORT || 5432,
});

async function cleanupBookData() {
  const client = await pool.connect();
  
  try {
    console.log('=== Cleaning Up Book-Related Data ===\n');
    console.log('⚠️  This will DELETE all book-related data but preserve user data!');
    console.log('   PRESERVING: login_history, moderator_accounts, ratings, reviews, user_accounts, users, votes');
    console.log('   DELETING: books, authors, genres, characters, languages, publication_houses, and all relationship tables\n');
    
    // Show current data counts before deletion
    console.log('1. Current data counts BEFORE cleanup:');
    const beforeCounts = await Promise.all([
      client.query('SELECT COUNT(*) FROM books'),
      client.query('SELECT COUNT(*) FROM authors'),
      client.query('SELECT COUNT(*) FROM genres'),
      client.query('SELECT COUNT(*) FROM characters'),
      client.query('SELECT COUNT(*) FROM languages'),
      client.query('SELECT COUNT(*) FROM publication_houses'),
      client.query('SELECT COUNT(*) FROM book_authors'),
      client.query('SELECT COUNT(*) FROM book_genres'),
      client.query('SELECT COUNT(*) FROM book_character_appearances'),
      client.query('SELECT COUNT(*) FROM users'),
      client.query('SELECT COUNT(*) FROM reviews'),
      client.query('SELECT COUNT(*) FROM ratings')
    ]);
    
    console.log(`   Books: ${beforeCounts[0].rows[0].count}`);
    console.log(`   Authors: ${beforeCounts[1].rows[0].count}`);
    console.log(`   Genres: ${beforeCounts[2].rows[0].count}`);
    console.log(`   Characters: ${beforeCounts[3].rows[0].count}`);
    console.log(`   Languages: ${beforeCounts[4].rows[0].count}`);
    console.log(`   Publication Houses: ${beforeCounts[5].rows[0].count}`);
    console.log(`   Book-Author relationships: ${beforeCounts[6].rows[0].count}`);
    console.log(`   Book-Genre relationships: ${beforeCounts[7].rows[0].count}`);
    console.log(`   Book-Character relationships: ${beforeCounts[8].rows[0].count}`);
    console.log(`   Users (PRESERVED): ${beforeCounts[9].rows[0].count}`);
    console.log(`   Reviews (PRESERVED): ${beforeCounts[10].rows[0].count}`);
    console.log(`   Ratings (PRESERVED): ${beforeCounts[11].rows[0].count}`);
    
    // Start transaction for safe cleanup
    await client.query('BEGIN');
    
    console.log('\n2. Starting cleanup process...');
    
    // Delete relationship tables first (to avoid foreign key constraints)
    console.log('   Deleting relationship tables...');
    await client.query('DELETE FROM book_character_appearances');
    console.log('   ✓ Cleared book_character_appearances');
    
    await client.query('DELETE FROM book_genres');
    console.log('   ✓ Cleared book_genres');
    
    await client.query('DELETE FROM book_authors');
    console.log('   ✓ Cleared book_authors');
    
    // Delete user_books relationships (but preserve user data)
    const userBooksExists = await client.query(`
      SELECT EXISTS (
        SELECT 1 FROM information_schema.tables 
        WHERE table_name = 'user_books'
      )
    `);
    
    if (userBooksExists.rows[0].exists) {
      await client.query('DELETE FROM user_books');
      console.log('   ✓ Cleared user_books relationships');
    }
    
    // Delete main tables
    console.log('   Deleting main tables...');
    await client.query('DELETE FROM books');
    console.log('   ✓ Cleared books');
    
    await client.query('DELETE FROM authors');
    console.log('   ✓ Cleared authors');
    
    await client.query('DELETE FROM genres');
    console.log('   ✓ Cleared genres');
    
    await client.query('DELETE FROM characters');
    console.log('   ✓ Cleared characters');
    
    await client.query('DELETE FROM languages');
    console.log('   ✓ Cleared languages');
    
    await client.query('DELETE FROM publication_houses');
    console.log('   ✓ Cleared publication_houses');
    
    // Reset sequences to start from 1
    console.log('\n3. Resetting ID sequences...');
    await client.query('ALTER SEQUENCE books_id_seq RESTART WITH 1');
    await client.query('ALTER SEQUENCE authors_id_seq RESTART WITH 1');
    await client.query('ALTER SEQUENCE genres_id_seq RESTART WITH 1');
    await client.query('ALTER SEQUENCE characters_id_seq RESTART WITH 1');
    await client.query('ALTER SEQUENCE languages_id_seq RESTART WITH 1');
    await client.query('ALTER SEQUENCE publication_houses_id_seq RESTART WITH 1');
    await client.query('ALTER SEQUENCE book_genres_id_seq RESTART WITH 1');
    await client.query('ALTER SEQUENCE book_character_appearances_id_seq RESTART WITH 1');
    console.log('   ✓ All ID sequences reset to start from 1');
    
    // Commit the transaction
    await client.query('COMMIT');
    
    // Show final counts
    console.log('\n4. Final data counts AFTER cleanup:');
    const afterCounts = await Promise.all([
      client.query('SELECT COUNT(*) FROM books'),
      client.query('SELECT COUNT(*) FROM authors'),
      client.query('SELECT COUNT(*) FROM genres'),
      client.query('SELECT COUNT(*) FROM characters'),
      client.query('SELECT COUNT(*) FROM languages'),
      client.query('SELECT COUNT(*) FROM publication_houses'),
      client.query('SELECT COUNT(*) FROM book_authors'),
      client.query('SELECT COUNT(*) FROM book_genres'),
      client.query('SELECT COUNT(*) FROM book_character_appearances'),
      client.query('SELECT COUNT(*) FROM users'),
      client.query('SELECT COUNT(*) FROM reviews'),
      client.query('SELECT COUNT(*) FROM ratings')
    ]);
    
    console.log(`   Books: ${afterCounts[0].rows[0].count}`);
    console.log(`   Authors: ${afterCounts[1].rows[0].count}`);
    console.log(`   Genres: ${afterCounts[2].rows[0].count}`);
    console.log(`   Characters: ${afterCounts[3].rows[0].count}`);
    console.log(`   Languages: ${afterCounts[4].rows[0].count}`);
    console.log(`   Publication Houses: ${afterCounts[5].rows[0].count}`);
    console.log(`   Book-Author relationships: ${afterCounts[6].rows[0].count}`);
    console.log(`   Book-Genre relationships: ${afterCounts[7].rows[0].count}`);
    console.log(`   Book-Character relationships: ${afterCounts[8].rows[0].count}`);
    console.log(`   Users (PRESERVED): ${afterCounts[9].rows[0].count}`);
    console.log(`   Reviews (PRESERVED): ${afterCounts[10].rows[0].count}`);
    console.log(`   Ratings (PRESERVED): ${afterCounts[11].rows[0].count}`);
    
    console.log('\n✅ Book data cleanup completed successfully!');
    console.log('   Ready for fresh API import with proper-books-integration.js');
    
  } catch (error) {
    // Rollback transaction on error
    await client.query('ROLLBACK');
    console.error('Error during cleanup (transaction rolled back):', error.message);
  } finally {
    client.release();
    await pool.end();
  }
}

cleanupBookData();