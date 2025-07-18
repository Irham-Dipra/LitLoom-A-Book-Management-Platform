require('dotenv').config();
const pool = require('./db');

async function addCommentReplies() {
  try {
    console.log('🚀 Adding comment reply functionality...');

    await pool.query('BEGIN');

    // Add parent_comment_id column to review_comments table
    await pool.query(`
      ALTER TABLE review_comments 
      ADD COLUMN IF NOT EXISTS parent_comment_id INTEGER REFERENCES review_comments(id) ON DELETE CASCADE
    `);
    console.log('✅ Added parent_comment_id column to review_comments table');

    // Add index for better performance on parent_comment_id
    await pool.query(`
      CREATE INDEX IF NOT EXISTS idx_review_comments_parent_id ON review_comments(parent_comment_id)
    `);
    console.log('✅ Created index for parent_comment_id');

    // Add reply_count column to track number of replies
    await pool.query(`
      ALTER TABLE review_comments 
      ADD COLUMN IF NOT EXISTS reply_count INTEGER DEFAULT 0
    `);
    console.log('✅ Added reply_count column to review_comments table');

    await pool.query('COMMIT');
    console.log('🎉 Comment reply functionality added successfully!');

  } catch (err) {
    await pool.query('ROLLBACK');
    console.error('❌ Error adding comment reply functionality:', err.message);
    throw err;
  }
}

// Run the update
(async () => {
  try {
    await addCommentReplies();
  } catch (err) {
    console.error('❌ Update failed:', err.message);
    process.exit(1);
  } finally {
    await pool.end();
  }
})();