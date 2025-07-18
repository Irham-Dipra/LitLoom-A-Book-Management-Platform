require('dotenv').config();
const pool = require('./db');

async function migrateReviewRatings() {
  try {
    console.log('🚀 Starting migration of review ratings to ratings table...');

    // Begin transaction
    await pool.query('BEGIN');

    // Get all reviews with ratings that don't exist in ratings table
    const reviewsQuery = `
      SELECT r.user_id, r.book_id, r.rating, r.created_at
      FROM reviews r
      LEFT JOIN ratings rt ON r.user_id = rt.user_id AND r.book_id = rt.book_id
      WHERE rt.id IS NULL AND r.rating IS NOT NULL
      ORDER BY r.created_at ASC
    `;

    const reviews = await pool.query(reviewsQuery);
    console.log(`📚 Found ${reviews.rows.length} reviews with ratings to migrate`);

    if (reviews.rows.length === 0) {
      console.log('✅ No reviews need migration - ratings table is up to date');
      await pool.query('COMMIT');
      return;
    }

    // Insert ratings from reviews
    let migratedCount = 0;
    for (const review of reviews.rows) {
      try {
        await pool.query(
          `INSERT INTO ratings (user_id, book_id, value, created_at)
           VALUES ($1, $2, $3, $4)`,
          [review.user_id, review.book_id, review.rating, review.created_at]
        );
        migratedCount++;
        console.log(`✅ Migrated rating for user ${review.user_id}, book ${review.book_id} (${review.rating} stars)`);
      } catch (err) {
        console.error(`❌ Error migrating rating for user ${review.user_id}, book ${review.book_id}:`, err.message);
        // Continue with other ratings instead of failing the whole migration
      }
    }

    await pool.query('COMMIT');
    console.log(`🎉 Migration completed! Successfully migrated ${migratedCount} ratings.`);

    // Show summary
    const totalRatings = await pool.query('SELECT COUNT(*) FROM ratings');
    console.log(`📊 Total ratings in database: ${totalRatings.rows[0].count}`);

  } catch (err) {
    await pool.query('ROLLBACK');
    console.error('❌ Migration failed:', err.message);
    throw err;
  }
}

async function showMigrationStatus() {
  try {
    console.log('\n📋 Migration Status Report:');
    
    // Count reviews with ratings
    const reviewsWithRatings = await pool.query(
      'SELECT COUNT(*) FROM reviews WHERE rating IS NOT NULL'
    );
    
    // Count ratings in ratings table
    const ratingsCount = await pool.query('SELECT COUNT(*) FROM ratings');
    
    // Count reviews with ratings that don't have corresponding ratings table entry
    const unmigrated = await pool.query(`
      SELECT COUNT(*) FROM reviews r
      LEFT JOIN ratings rt ON r.user_id = rt.user_id AND r.book_id = rt.book_id
      WHERE rt.id IS NULL AND r.rating IS NOT NULL
    `);

    console.log(`📚 Reviews with ratings: ${reviewsWithRatings.rows[0].count}`);
    console.log(`⭐ Ratings in ratings table: ${ratingsCount.rows[0].count}`);
    console.log(`🔄 Unmigrated ratings: ${unmigrated.rows[0].count}`);

  } catch (err) {
    console.error('❌ Error getting migration status:', err.message);
  }
}

// Run the migration
(async () => {
  try {
    await showMigrationStatus();
    await migrateReviewRatings();
    await showMigrationStatus();
  } catch (err) {
    console.error('❌ Migration script failed:', err.message);
    process.exit(1);
  } finally {
    await pool.end();
  }
})();