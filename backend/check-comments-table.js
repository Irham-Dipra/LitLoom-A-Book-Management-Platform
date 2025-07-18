require('dotenv').config();
const pool = require('./db');

async function checkCommentsTable() {
  try {
    console.log('🔍 Checking comments table structure...');

    // Check if comments table exists and its structure
    const commentsTableInfo = await pool.query(`
      SELECT column_name, data_type, is_nullable, column_default
      FROM information_schema.columns 
      WHERE table_name = 'comments' AND table_schema = 'public'
      ORDER BY ordinal_position
    `);

    if (commentsTableInfo.rows.length === 0) {
      console.log('❌ Comments table does not exist');
    } else {
      console.log('✅ Comments table exists with columns:');
      commentsTableInfo.rows.forEach(col => {
        console.log(`  - ${col.column_name}: ${col.data_type} (nullable: ${col.is_nullable})`);
      });
    }

    // Check review_comments table structure
    const reviewCommentsInfo = await pool.query(`
      SELECT column_name, data_type, is_nullable, column_default
      FROM information_schema.columns 
      WHERE table_name = 'review_comments' AND table_schema = 'public'
      ORDER BY ordinal_position
    `);

    if (reviewCommentsInfo.rows.length === 0) {
      console.log('❌ review_comments table does not exist');
    } else {
      console.log('✅ review_comments table exists with columns:');
      reviewCommentsInfo.rows.forEach(col => {
        console.log(`  - ${col.column_name}: ${col.data_type} (nullable: ${col.is_nullable})`);
      });
    }

    // Check what data exists in comments table
    const commentsData = await pool.query('SELECT COUNT(*) FROM comments');
    console.log(`📊 Comments table has ${commentsData.rows[0].count} records`);

    const reviewCommentsData = await pool.query('SELECT COUNT(*) FROM review_comments');
    console.log(`📊 Review_comments table has ${reviewCommentsData.rows[0].count} records`);

  } catch (err) {
    console.error('❌ Error checking table structure:', err.message);
    throw err;
  }
}

// Run the check
(async () => {
  try {
    await checkCommentsTable();
  } catch (err) {
    console.error('❌ Check failed:', err.message);
    process.exit(1);
  } finally {
    await pool.end();
  }
})();