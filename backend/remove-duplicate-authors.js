require('dotenv').config();
const pool = require('./db');

async function removeMultipleAuthors() {
  try {
    console.log('🚀 Starting removal of duplicate authors...');

    // Begin transaction
    await pool.query('BEGIN');

    // Get books that have multiple authors
    const booksWithMultipleAuthors = await pool.query(`
      SELECT book_id, COUNT(*) as author_count
      FROM book_authors
      GROUP BY book_id
      HAVING COUNT(*) > 1
      ORDER BY book_id
    `);

    console.log(`📚 Found ${booksWithMultipleAuthors.rows.length} books with multiple authors`);

    if (booksWithMultipleAuthors.rows.length === 0) {
      console.log('✅ No books have multiple authors - nothing to clean up');
      await pool.query('COMMIT');
      return;
    }

    let totalRemovedFromBookAuthors = 0;
    let authorsToCheck = new Set();

    // Process each book with multiple authors
    for (const bookData of booksWithMultipleAuthors.rows) {
      const bookId = bookData.book_id;
      const authorCount = bookData.author_count;

      console.log(`📖 Processing book ${bookId} (${authorCount} authors)`);

      // Get all authors for this book, ordered by author_id (keeping the first one)
      const bookAuthors = await pool.query(`
        SELECT author_id
        FROM book_authors
        WHERE book_id = $1
        ORDER BY author_id ASC
      `, [bookId]);

      // Keep the first author, remove the rest
      const firstAuthor = bookAuthors.rows[0];
      const authorsToRemove = bookAuthors.rows.slice(1);

      console.log(`  ✅ Keeping author ${firstAuthor.author_id} (first entry)`);

      // Remove duplicate authors from book_authors table
      for (const authorToRemove of authorsToRemove) {
        await pool.query(`
          DELETE FROM book_authors
          WHERE book_id = $1 AND author_id = $2
        `, [bookId, authorToRemove.author_id]);

        console.log(`  ❌ Removed author ${authorToRemove.author_id} from book ${bookId}`);
        totalRemovedFromBookAuthors++;
        
        // Add to list of authors to check for orphaning
        authorsToCheck.add(authorToRemove.author_id);
      }
    }

    console.log(`📊 Removed ${totalRemovedFromBookAuthors} duplicate author entries from book_authors table`);

    // Now check for orphaned authors and remove them
    console.log(`🔍 Checking ${authorsToCheck.size} authors for orphaning...`);
    
    let orphanedAuthorsRemoved = 0;
    for (const authorId of authorsToCheck) {
      // Check if this author is still referenced by any book
      const authorReferences = await pool.query(`
        SELECT COUNT(*) as ref_count
        FROM book_authors
        WHERE author_id = $1
      `, [authorId]);

      if (authorReferences.rows[0].ref_count === '0') {
        // Author is orphaned, get their name first
        const authorInfo = await pool.query(`
          SELECT name FROM authors WHERE id = $1
        `, [authorId]);

        // Remove the orphaned author
        await pool.query(`
          DELETE FROM authors WHERE id = $1
        `, [authorId]);

        console.log(`  🗑️  Removed orphaned author: ${authorInfo.rows[0]?.name || 'Unknown'} (ID: ${authorId})`);
        orphanedAuthorsRemoved++;
      }
    }

    await pool.query('COMMIT');
    
    console.log(`\n🎉 Cleanup completed successfully!`);
    console.log(`📊 Summary:`);
    console.log(`   - Removed ${totalRemovedFromBookAuthors} duplicate author entries from book_authors table`);
    console.log(`   - Removed ${orphanedAuthorsRemoved} orphaned authors from authors table`);
    console.log(`   - Processed ${booksWithMultipleAuthors.rows.length} books with multiple authors`);

  } catch (err) {
    await pool.query('ROLLBACK');
    console.error('❌ Cleanup failed:', err.message);
    throw err;
  }
}

async function showAuthorStatistics() {
  try {
    console.log('\n📋 Author Statistics:');
    
    // Count total books
    const totalBooks = await pool.query('SELECT COUNT(*) FROM books');
    
    // Count total authors
    const totalAuthors = await pool.query('SELECT COUNT(*) FROM authors');
    
    // Count total book-author relationships
    const totalBookAuthors = await pool.query('SELECT COUNT(*) FROM book_authors');
    
    // Count books with multiple authors
    const booksWithMultipleAuthors = await pool.query(`
      SELECT COUNT(*) FROM (
        SELECT book_id
        FROM book_authors
        GROUP BY book_id
        HAVING COUNT(*) > 1
      ) as multi_author_books
    `);
    
    // Count books with single authors
    const booksWithSingleAuthor = await pool.query(`
      SELECT COUNT(*) FROM (
        SELECT book_id
        FROM book_authors
        GROUP BY book_id
        HAVING COUNT(*) = 1
      ) as single_author_books
    `);

    console.log(`📚 Total books: ${totalBooks.rows[0].count}`);
    console.log(`👥 Total authors: ${totalAuthors.rows[0].count}`);
    console.log(`🔗 Total book-author relationships: ${totalBookAuthors.rows[0].count}`);
    console.log(`📖 Books with single author: ${booksWithSingleAuthor.rows[0].count}`);
    console.log(`📚 Books with multiple authors: ${booksWithMultipleAuthors.rows[0].count}`);

  } catch (err) {
    console.error('❌ Error getting statistics:', err.message);
  }
}

// Run the cleanup
(async () => {
  try {
    await showAuthorStatistics();
    console.log('\n' + '='.repeat(50));
    await removeMultipleAuthors();
    console.log('\n' + '='.repeat(50));
    await showAuthorStatistics();
  } catch (err) {
    console.error('❌ Script failed:', err.message);
    process.exit(1);
  } finally {
    await pool.end();
  }
})();