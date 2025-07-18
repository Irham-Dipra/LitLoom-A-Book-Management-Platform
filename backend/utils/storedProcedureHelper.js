// Stored Procedure Helper Utilities
const pool = require('../db');

/**
 * Execute a stored procedure with proper error handling
 * @param {string} procedureName - Name of the stored procedure
 * @param {Array} params - Parameters for the procedure
 * @param {Object} options - Options for execution
 * @returns {Promise<any>} - Result of the procedure
 */
async function callStoredProcedure(procedureName, params = [], options = {}) {
  try {
    const { expectSingleResult = false, returnField = null } = options;
    
    // Build parameter placeholders
    const paramPlaceholders = params.map((_, index) => `$${index + 1}`).join(', ');
    const query = `SELECT * FROM ${procedureName}(${paramPlaceholders})`;
    
    const result = await pool.query(query, params);
    
    if (expectSingleResult) {
      if (result.rows.length === 0) {
        throw new Error(`No result returned from ${procedureName}`);
      }
      return returnField ? result.rows[0][returnField] : result.rows[0];
    }
    
    return result.rows;
  } catch (error) {
    console.error(`Error calling stored procedure ${procedureName}:`, error);
    throw error;
  }
}

/**
 * Execute a stored function that returns a single value
 * @param {string} functionName - Name of the stored function
 * @param {Array} params - Parameters for the function
 * @param {string} returnField - Name of the return field
 * @returns {Promise<any>} - Single value result
 */
async function callStoredFunction(functionName, params = [], returnField = 'result') {
  try {
    const paramPlaceholders = params.map((_, index) => `$${index + 1}`).join(', ');
    const query = `SELECT ${functionName}(${paramPlaceholders}) as ${returnField}`;
    
    const result = await pool.query(query, params);
    
    if (result.rows.length === 0) {
      throw new Error(`No result returned from ${functionName}`);
    }
    
    return result.rows[0][returnField];
  } catch (error) {
    console.error(`Error calling stored function ${functionName}:`, error);
    throw error;
  }
}

/**
 * Execute multiple stored procedures in a transaction
 * @param {Array<Object>} procedures - Array of procedure objects
 * @returns {Promise<Array>} - Array of results
 */
async function callMultipleStoredProcedures(procedures) {
  const client = await pool.connect();
  
  try {
    await client.query('BEGIN');
    
    const results = [];
    
    for (const proc of procedures) {
      const { name, params = [], options = {} } = proc;
      const { expectSingleResult = false, returnField = null } = options;
      
      const paramPlaceholders = params.map((_, index) => `$${index + 1}`).join(', ');
      const query = `SELECT * FROM ${name}(${paramPlaceholders})`;
      
      const result = await client.query(query, params);
      
      if (expectSingleResult) {
        if (result.rows.length === 0) {
          throw new Error(`No result returned from ${name}`);
        }
        results.push(returnField ? result.rows[0][returnField] : result.rows[0]);
      } else {
        results.push(result.rows);
      }
    }
    
    await client.query('COMMIT');
    return results;
  } catch (error) {
    await client.query('ROLLBACK');
    throw error;
  } finally {
    client.release();
  }
}

/**
 * Common stored procedure calls for easy reuse
 */
const StoredProcedures = {
  // User Authentication
  handleLogin: async (userId, ipAddress) => {
    return await callStoredFunction('handle_user_login', [userId, ipAddress], 'success');
  },
  
  handleLogout: async (userId) => {
    return await callStoredFunction('handle_user_logout', [userId], 'success');
  },
  
  // Reading Statistics
  getUserReadingStats: async (userId) => {
    return await callStoredProcedure('get_user_reading_stats', [userId], { expectSingleResult: true });
  },
  
  getMonthlyActivity: async (userId, months = 12) => {
    return await callStoredProcedure('get_monthly_reading_activity', [userId, months]);
  },
  
  getGenreStats: async (userId, limit = 10) => {
    return await callStoredProcedure('get_user_genre_stats', [userId, limit]);
  },
  
  getAuthorStats: async (userId, limit = 10) => {
    return await callStoredProcedure('get_user_author_stats', [userId, limit]);
  },
  
  getBookLengthStats: async (userId) => {
    return await callStoredProcedure('get_user_book_length_stats', [userId]);
  },
  
  getRatingDistribution: async (userId) => {
    return await callStoredProcedure('get_user_rating_distribution', [userId]);
  },
  
  // Book Management
  addBookToLibrary: async (userId, bookId, shelf = 'want-to-read') => {
    return await callStoredFunction('add_book_to_library', [userId, bookId, shelf], 'user_book_id');
  },
  
  updateBookInLibrary: async (userId, bookId, shelf = null, rating = null, dateRead = null, notes = null) => {
    return await callStoredFunction('update_book_in_library', [userId, bookId, shelf, rating, dateRead, notes], 'success');
  },
  
  // Utility Functions
  updateReadingGoal: async (userId, goal) => {
    return await callStoredFunction('update_reading_goal', [userId, goal], 'reading_goal');
  },
  
  getReadingGoalProgress: async (userId) => {
    return await callStoredProcedure('get_reading_goal_progress', [userId], { expectSingleResult: true });
  },
  
  getReadingStreak: async (userId) => {
    return await callStoredFunction('get_reading_streak', [userId], 'streak');
  },
  
  // Review and Comment Management
  handleReviewVote: async (reviewId, userId, voteType) => {
    return await callStoredFunction('handle_review_vote', [reviewId, userId, voteType], 'handle_review_vote');
  },
  
  handleCommentVote: async (commentId, userId, voteType) => {
    return await callStoredFunction('handle_comment_vote', [commentId, userId, voteType], 'handle_comment_vote');
  },
  
  addReviewWithRating: async (userId, bookId, title, body, rating) => {
    return await callStoredFunction('add_review_with_rating', [userId, bookId, title, body, rating], 'add_review_with_rating');
  },
  
  addCommentWithReplyCount: async (reviewId, userId, commentBody, parentCommentId = null) => {
    return await callStoredFunction('add_comment_with_reply_count', [reviewId, userId, commentBody, parentCommentId], 'add_comment_with_reply_count');
  },
  
  getReviewWithUserVotes: async (reviewId, userId = null) => {
    return await callStoredProcedure('get_review_with_user_votes', [reviewId, userId], { expectSingleResult: true });
  }
};

module.exports = {
  callStoredProcedure,
  callStoredFunction,
  callMultipleStoredProcedures,
  StoredProcedures
};