-- Add reading_goal column to users table
-- This allows users to set their own annual reading goal instead of hardcoded 12 books

ALTER TABLE users ADD COLUMN reading_goal INTEGER DEFAULT 12;

-- Update existing users to have a default goal of 12 books
UPDATE users SET reading_goal = 12 WHERE reading_goal IS NULL;

-- Add a check constraint to ensure reasonable goals (1-1000 books)
ALTER TABLE users ADD CONSTRAINT users_reading_goal_check CHECK (reading_goal >= 1 AND reading_goal <= 1000);