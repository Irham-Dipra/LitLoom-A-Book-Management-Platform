require('dotenv').config();
const pool = require('./db');

async function checkVotesTable() {
  try {
    console.log('🔍 Checking existing votes table structure...');

    // Check if votes table exists and its structure
    const tableInfo = await pool.query(`
      SELECT column_name, data_type, is_nullable, column_default
      FROM information_schema.columns 
      WHERE table_name = 'votes' AND table_schema = 'public'
      ORDER BY ordinal_position
    `);

    if (tableInfo.rows.length === 0) {
      console.log('❌ Votes table does not exist');
    } else {
      console.log('✅ Votes table exists with columns:');
      tableInfo.rows.forEach(col => {
        console.log(`  - ${col.column_name}: ${col.data_type} (nullable: ${col.is_nullable})`);
      });
    }

    // Check if review_votes table exists
    const reviewVotesInfo = await pool.query(`
      SELECT column_name, data_type, is_nullable, column_default
      FROM information_schema.columns 
      WHERE table_name = 'review_votes' AND table_schema = 'public'
      ORDER BY ordinal_position
    `);

    if (reviewVotesInfo.rows.length === 0) {
      console.log('❌ review_votes table does not exist');
    } else {
      console.log('✅ review_votes table exists with columns:');
      reviewVotesInfo.rows.forEach(col => {
        console.log(`  - ${col.column_name}: ${col.data_type} (nullable: ${col.is_nullable})`);
      });
    }

    // Check review_comments table structure
    const commentsInfo = await pool.query(`
      SELECT column_name, data_type, is_nullable, column_default
      FROM information_schema.columns 
      WHERE table_name = 'review_comments' AND table_schema = 'public'
      ORDER BY ordinal_position
    `);

    if (commentsInfo.rows.length === 0) {
      console.log('❌ review_comments table does not exist');
    } else {
      console.log('✅ review_comments table exists with columns:');
      commentsInfo.rows.forEach(col => {
        console.log(`  - ${col.column_name}: ${col.data_type} (nullable: ${col.is_nullable})`);
      });
    }

  } catch (err) {
    console.error('❌ Error checking table structure:', err.message);
    throw err;
  }
}

// Run the check
(async () => {
  try {
    await checkVotesTable();
  } catch (err) {
    console.error('❌ Check failed:', err.message);
    process.exit(1);
  } finally {
    await pool.end();
  }
})();