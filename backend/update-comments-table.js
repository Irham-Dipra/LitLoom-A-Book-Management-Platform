require('dotenv').config();
const pool = require('./db');

async function updateCommentsTable() {
  try {
    console.log('🚀 Updating comments table for voting and replies...');

    await pool.query('BEGIN');

    // Add vote count columns to comments table
    await pool.query(`
      ALTER TABLE comments 
      ADD COLUMN IF NOT EXISTS upvotes INTEGER DEFAULT 0,
      ADD COLUMN IF NOT EXISTS downvotes INTEGER DEFAULT 0
    `);
    console.log('✅ Added vote count columns to comments table');

    // Add reply_count column to track number of replies
    await pool.query(`
      ALTER TABLE comments 
      ADD COLUMN IF NOT EXISTS reply_count INTEGER DEFAULT 0
    `);
    console.log('✅ Added reply_count column to comments table');

    // Create indexes for better performance
    await pool.query(`
      CREATE INDEX IF NOT EXISTS idx_comments_parent_id ON comments(parent_comment_id)
    `);
    await pool.query(`
      CREATE INDEX IF NOT EXISTS idx_comments_review_id ON comments(review_id)
    `);
    console.log('✅ Created indexes for comments table');

    // Update votes table to reference comments table instead of review_comments
    await pool.query(`
      ALTER TABLE votes 
      DROP CONSTRAINT IF EXISTS votes_comment_id_fkey
    `);
    await pool.query(`
      ALTER TABLE votes 
      ADD CONSTRAINT votes_comment_id_fkey 
      FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE
    `);
    console.log('✅ Updated votes table foreign key to reference comments table');

    await pool.query('COMMIT');
    console.log('🎉 Comments table updated successfully!');

  } catch (err) {
    await pool.query('ROLLBACK');
    console.error('❌ Error updating comments table:', err.message);
    throw err;
  }
}

// Run the update
(async () => {
  try {
    await updateCommentsTable();
  } catch (err) {
    console.error('❌ Update failed:', err.message);
    process.exit(1);
  } finally {
    await pool.end();
  }
})();