// Transaction helper utilities for database operations
const pool = require('../db');

/**
 * Execute a function within a database transaction
 * @param {Function} callback - Function to execute within transaction
 * @returns {Promise<any>} - Result of the callback function
 */
async function withTransaction(callback) {
  const client = await pool.connect();
  
  try {
    await client.query('BEGIN');
    const result = await callback(client);
    await client.query('COMMIT');
    return result;
  } catch (error) {
    await client.query('ROLLBACK');
    throw error;
  } finally {
    client.release();
  }
}

/**
 * Execute multiple database operations atomically
 * @param {Array<Function>} operations - Array of functions that take client as parameter
 * @returns {Promise<Array>} - Array of results from each operation
 */
async function executeAtomically(operations) {
  return withTransaction(async (client) => {
    const results = [];
    for (const operation of operations) {
      const result = await operation(client);
      results.push(result);
    }
    return results;
  });
}

/**
 * Retry a transaction up to maxRetries times in case of deadlock
 * @param {Function} callback - Function to execute within transaction
 * @param {number} maxRetries - Maximum number of retry attempts (default: 3)
 * @returns {Promise<any>} - Result of the callback function
 */
async function withRetryableTransaction(callback, maxRetries = 3) {
  let lastError;
  
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await withTransaction(callback);
    } catch (error) {
      lastError = error;
      
      // Check if it's a deadlock or serialization failure
      if (error.code === '40P01' || error.code === '40001') {
        console.warn(`Transaction attempt ${attempt} failed due to deadlock, retrying...`);
        if (attempt === maxRetries) break;
        
        // Wait before retry with exponential backoff
        await new Promise(resolve => setTimeout(resolve, Math.pow(2, attempt) * 100));
        continue;
      }
      
      // If it's not a deadlock, don't retry
      throw error;
    }
  }
  
  throw lastError;
}

/**
 * Execute a batch of similar operations (like bulk inserts) in a transaction
 * @param {string} query - SQL query with placeholders
 * @param {Array<Array>} paramSets - Array of parameter arrays for each query execution
 * @returns {Promise<Array>} - Array of query results
 */
async function executeBatch(query, paramSets) {
  return withTransaction(async (client) => {
    const results = [];
    for (const params of paramSets) {
      const result = await client.query(query, params);
      results.push(result);
    }
    return results;
  });
}

module.exports = {
  withTransaction,
  executeAtomically,
  withRetryableTransaction,
  executeBatch
};