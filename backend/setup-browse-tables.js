require('dotenv').config();
const pool = require('./db');

async function setupBrowseTables() {
  try {
    console.log('🚀 Setting up browse functionality tables...');

    // Create review_votes table
    await pool.query(`
      CREATE TABLE IF NOT EXISTS review_votes (
        id SERIAL PRIMARY KEY,
        review_id INTEGER NOT NULL REFERENCES reviews(id) ON DELETE CASCADE,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        vote_type VARCHAR(10) NOT NULL CHECK (vote_type IN ('upvote', 'downvote')),
        created_at TIMESTAMP DEFAULT NOW(),
        updated_at TIMESTAMP DEFAULT NOW(),
        UNIQUE(review_id, user_id)
      )
    `);
    console.log('✅ Created review_votes table');

    // Create review_comments table
    await pool.query(`
      CREATE TABLE IF NOT EXISTS review_comments (
        id SERIAL PRIMARY KEY,
        review_id INTEGER NOT NULL REFERENCES reviews(id) ON DELETE CASCADE,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        comment TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT NOW(),
        updated_at TIMESTAMP DEFAULT NOW()
      )
    `);
    console.log('✅ Created review_comments table');

    // Add indexes for better performance
    await pool.query(`
      CREATE INDEX IF NOT EXISTS idx_review_votes_review_id ON review_votes(review_id)
    `);
    await pool.query(`
      CREATE INDEX IF NOT EXISTS idx_review_votes_user_id ON review_votes(user_id)
    `);
    await pool.query(`
      CREATE INDEX IF NOT EXISTS idx_review_comments_review_id ON review_comments(review_id)
    `);
    await pool.query(`
      CREATE INDEX IF NOT EXISTS idx_review_comments_user_id ON review_comments(user_id)
    `);
    console.log('✅ Created indexes');

    // Add vote count columns to reviews table
    await pool.query(`
      ALTER TABLE reviews ADD COLUMN IF NOT EXISTS upvotes INTEGER DEFAULT 0
    `);
    await pool.query(`
      ALTER TABLE reviews ADD COLUMN IF NOT EXISTS downvotes INTEGER DEFAULT 0
    `);
    console.log('✅ Added vote count columns to reviews table');

    console.log('🎉 Browse functionality tables setup complete!');
  } catch (err) {
    console.error('❌ Error setting up browse tables:', err.message);
    throw err;
  }
}

// Run the setup
(async () => {
  try {
    await setupBrowseTables();
  } catch (err) {
    console.error('❌ Setup failed:', err.message);
    process.exit(1);
  } finally {
    await pool.end();
  }
})();