require('dotenv').config();
const pool = require('./db');

async function updateVotesTable() {
  try {
    console.log('🚀 Updating votes table structure...');

    await pool.query('BEGIN');

    // Drop the existing tables
    await pool.query('DROP TABLE IF EXISTS review_votes CASCADE');
    await pool.query('DROP TABLE IF EXISTS votes CASCADE');
    console.log('✅ Dropped old tables');

    // Create new unified votes table
    await pool.query(`
      CREATE TABLE votes (
        id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        review_id INTEGER REFERENCES reviews(id) ON DELETE CASCADE,
        comment_id INTEGER REFERENCES review_comments(id) ON DELETE CASCADE,
        vote_type VARCHAR(10) NOT NULL CHECK (vote_type IN ('upvote', 'downvote')),
        created_at TIMESTAMP DEFAULT NOW(),
        updated_at TIMESTAMP DEFAULT NOW(),
        CONSTRAINT vote_target_check CHECK (
          (review_id IS NOT NULL AND comment_id IS NULL) OR 
          (review_id IS NULL AND comment_id IS NOT NULL)
        ),
        CONSTRAINT unique_user_vote UNIQUE (user_id, review_id, comment_id)
      )
    `);
    console.log('✅ Created new unified votes table');

    // Add vote count columns to review_comments table
    await pool.query(`
      ALTER TABLE review_comments 
      ADD COLUMN IF NOT EXISTS upvotes INTEGER DEFAULT 0,
      ADD COLUMN IF NOT EXISTS downvotes INTEGER DEFAULT 0
    `);
    console.log('✅ Added vote count columns to review_comments table');

    // Create indexes for better performance
    await pool.query('CREATE INDEX IF NOT EXISTS idx_votes_user_id ON votes(user_id)');
    await pool.query('CREATE INDEX IF NOT EXISTS idx_votes_review_id ON votes(review_id)');
    await pool.query('CREATE INDEX IF NOT EXISTS idx_votes_comment_id ON votes(comment_id)');
    console.log('✅ Created indexes for votes table');

    await pool.query('COMMIT');
    console.log('🎉 Votes table update completed successfully!');

  } catch (err) {
    await pool.query('ROLLBACK');
    console.error('❌ Error updating votes table:', err.message);
    throw err;
  }
}

// Run the update
(async () => {
  try {
    await updateVotesTable();
  } catch (err) {
    console.error('❌ Update failed:', err.message);
    process.exit(1);
  } finally {
    await pool.end();
  }
})();