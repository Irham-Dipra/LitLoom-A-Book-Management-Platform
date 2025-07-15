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

async function createCharacterTables() {
  const client = await pool.connect();
  
  try {
    console.log('=== Creating Character Tables ===\n');
    
    // Create characters table
    console.log('1. Creating characters table...');
    await client.query(`
      CREATE TABLE IF NOT EXISTS characters (
        id SERIAL PRIMARY KEY,
        name VARCHAR(500) NOT NULL,
        biography TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);
    console.log('   ✓ Characters table created successfully');
    
    // Create book_character_appearances junction table
    console.log('\n2. Creating book_character_appearances junction table...');
    await client.query(`
      CREATE TABLE IF NOT EXISTS book_character_appearances (
        id SERIAL PRIMARY KEY,
        book_id INTEGER NOT NULL REFERENCES books(id) ON DELETE CASCADE,
        character_id INTEGER NOT NULL REFERENCES characters(id) ON DELETE CASCADE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE(book_id, character_id)
      )
    `);
    console.log('   ✓ Book_character_appearances table created successfully');
    
    // Create indexes for better performance
    console.log('\n3. Creating indexes...');
    await client.query(`
      CREATE INDEX IF NOT EXISTS idx_characters_name ON characters(name);
    `);
    await client.query(`
      CREATE INDEX IF NOT EXISTS idx_book_character_appearances_book_id ON book_character_appearances(book_id);
    `);
    await client.query(`
      CREATE INDEX IF NOT EXISTS idx_book_character_appearances_character_id ON book_character_appearances(character_id);
    `);
    console.log('   ✓ Indexes created successfully');
    
    // Verify tables exist
    console.log('\n4. Verifying table creation...');
    const tables = await client.query(`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public' 
      AND table_name IN ('characters', 'book_character_appearances')
      ORDER BY table_name
    `);
    
    if (tables.rows.length === 2) {
      console.log('   ✓ Both tables verified successfully');
      tables.rows.forEach(row => {
        console.log(`     - ${row.table_name}`);
      });
    } else {
      console.log('   ✗ Table verification failed');
    }
    
    // Show table structure
    console.log('\n5. Table structures:');
    
    console.log('\n   Characters table:');
    const charactersStructure = await client.query(`
      SELECT column_name, data_type, is_nullable, column_default
      FROM information_schema.columns
      WHERE table_name = 'characters'
      ORDER BY ordinal_position
    `);
    charactersStructure.rows.forEach(row => {
      console.log(`     ${row.column_name}: ${row.data_type} ${row.is_nullable === 'NO' ? 'NOT NULL' : 'NULL'} ${row.column_default || ''}`);
    });
    
    console.log('\n   Book_character_appearances table:');
    const appearancesStructure = await client.query(`
      SELECT column_name, data_type, is_nullable, column_default
      FROM information_schema.columns
      WHERE table_name = 'book_character_appearances'
      ORDER BY ordinal_position
    `);
    appearancesStructure.rows.forEach(row => {
      console.log(`     ${row.column_name}: ${row.data_type} ${row.is_nullable === 'NO' ? 'NOT NULL' : 'NULL'} ${row.column_default || ''}`);
    });
    
    console.log('\n✅ Character tables created successfully!');
    
  } catch (error) {
    console.error('Error creating character tables:', error.message);
  } finally {
    client.release();
    await pool.end();
  }
}

createCharacterTables();