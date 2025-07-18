-- LitLoom Database Stored Procedures and Functions
-- This file contains all stored procedures and functions for the LitLoom application

-- ============================================================================
-- READING STATISTICS PROCEDURES
-- ============================================================================

-- Function to get comprehensive reading statistics for a user
CREATE OR REPLACE FUNCTION get_user_reading_stats(p_user_id INTEGER)
RETURNS TABLE (
    total_books BIGINT,
    books_read BIGINT,
    currently_reading BIGINT,
    want_to_read BIGINT,
    total_pages_read BIGINT,
    avg_pages_per_book NUMERIC,
    rated_books BIGINT,
    user_avg_rating NUMERIC,
    library_avg_rating NUMERIC,
    books_with_ratings BIGINT,
    books_read_this_year BIGINT,
    pages_read_this_year BIGINT,
    reading_goal INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        -- Basic library stats
        COUNT(*) as total_books,
        COUNT(CASE WHEN ub.shelf = 'read' THEN 1 END) as books_read,
        COUNT(CASE WHEN ub.shelf = 'currently-reading' THEN 1 END) as currently_reading,
        COUNT(CASE WHEN ub.shelf = 'want-to-read' THEN 1 END) as want_to_read,
        
        -- Page statistics
        COALESCE(SUM(CASE WHEN ub.shelf = 'read' AND b.page IS NOT NULL THEN b.page ELSE 0 END), 0) as total_pages_read,
        AVG(CASE WHEN ub.shelf = 'read' AND b.page IS NOT NULL THEN b.page END)::numeric as avg_pages_per_book,
        
        -- User rating statistics
        (SELECT COUNT(*) FROM ratings r WHERE r.user_id = p_user_id) as rated_books,
        (SELECT AVG(r.value)::numeric FROM ratings r WHERE r.user_id = p_user_id) as user_avg_rating,
        
        -- Library average rating (based on book ratings)
        AVG(CASE WHEN ub.shelf = 'read' AND b.average_rating IS NOT NULL THEN b.average_rating END)::numeric as library_avg_rating,
        COUNT(CASE WHEN ub.shelf = 'read' AND b.average_rating IS NOT NULL THEN 1 END) as books_with_ratings,
        
        -- This year's progress
        COUNT(CASE WHEN ub.shelf = 'read' AND EXTRACT(YEAR FROM ub.date_read) = EXTRACT(YEAR FROM NOW()) THEN 1 END) as books_read_this_year,
        COALESCE(SUM(CASE WHEN ub.shelf = 'read' AND EXTRACT(YEAR FROM ub.date_read) = EXTRACT(YEAR FROM NOW()) AND b.page IS NOT NULL THEN b.page ELSE 0 END), 0) as pages_read_this_year,
        
        -- Reading goal
        (SELECT u.reading_goal FROM users u WHERE u.id = p_user_id) as reading_goal
        
    FROM user_books ub
    LEFT JOIN books b ON ub.book_id = b.id
    WHERE ub.user_id = p_user_id;
END;
$$ LANGUAGE plpgsql;

-- Function to get monthly reading activity
CREATE OR REPLACE FUNCTION get_monthly_reading_activity(p_user_id INTEGER, p_months INTEGER DEFAULT 12)
RETURNS TABLE (
    month TEXT,
    books_read BIGINT,
    pages_read BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        TO_CHAR(ub.date_read, 'YYYY-MM') as month,
        COUNT(*) as books_read,
        COALESCE(SUM(CASE WHEN b.page IS NOT NULL THEN b.page ELSE 0 END), 0) as pages_read
    FROM user_books ub
    LEFT JOIN books b ON ub.book_id = b.id
    WHERE ub.user_id = p_user_id 
        AND ub.date_read IS NOT NULL 
        AND ub.date_read >= NOW() - INTERVAL '1 month' * p_months
    GROUP BY TO_CHAR(ub.date_read, 'YYYY-MM')
    ORDER BY month DESC;
END;
$$ LANGUAGE plpgsql;

-- Function to get user's genre distribution
CREATE OR REPLACE FUNCTION get_user_genre_stats(p_user_id INTEGER, p_limit INTEGER DEFAULT 10)
RETURNS TABLE (
    genre TEXT,
    book_count BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        g.name::TEXT as genre,
        COUNT(*) as book_count
    FROM user_books ub
    JOIN books b ON ub.book_id = b.id
    JOIN book_genres bg ON b.id = bg.book_id
    JOIN genres g ON bg.genre_id = g.id
    WHERE ub.user_id = p_user_id AND ub.shelf = 'read'
    GROUP BY g.name
    ORDER BY book_count DESC
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;

-- Function to get user's favorite authors
CREATE OR REPLACE FUNCTION get_user_author_stats(p_user_id INTEGER, p_limit INTEGER DEFAULT 10)
RETURNS TABLE (
    author TEXT,
    book_count BIGINT,
    avg_rating NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        a.name::TEXT as author,
        COUNT(*) as book_count,
        AVG(r.value)::numeric as avg_rating
    FROM user_books ub
    JOIN books b ON ub.book_id = b.id
    JOIN book_authors ba ON b.id = ba.book_id
    JOIN authors a ON ba.author_id = a.id
    LEFT JOIN ratings r ON b.id = r.book_id AND r.user_id = ub.user_id
    WHERE ub.user_id = p_user_id AND ub.shelf = 'read'
    GROUP BY a.name
    ORDER BY book_count DESC, avg_rating DESC
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;

-- Function to get user's book length preferences
CREATE OR REPLACE FUNCTION get_user_book_length_stats(p_user_id INTEGER)
RETURNS TABLE (
    length_category TEXT,
    book_count BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        CASE 
            WHEN b.page < 200 THEN 'Short (< 200 pages)'
            WHEN b.page < 400 THEN 'Medium (200-400 pages)'
            WHEN b.page < 600 THEN 'Long (400-600 pages)'
            ELSE 'Very Long (600+ pages)'
        END as length_category,
        COUNT(*) as book_count
    FROM user_books ub
    JOIN books b ON ub.book_id = b.id
    WHERE ub.user_id = p_user_id AND ub.shelf = 'read' AND b.page IS NOT NULL
    GROUP BY length_category
    ORDER BY book_count DESC;
END;
$$ LANGUAGE plpgsql;

-- Function to get user's rating distribution
CREATE OR REPLACE FUNCTION get_user_rating_distribution(p_user_id INTEGER)
RETURNS TABLE (
    rating INTEGER,
    count BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        r.value as rating,
        COUNT(*) as count
    FROM ratings r
    WHERE r.user_id = p_user_id
    GROUP BY r.value
    ORDER BY r.value;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- USER AUTHENTICATION PROCEDURES
-- ============================================================================

-- Procedure to handle user login
CREATE OR REPLACE FUNCTION handle_user_login(
    p_user_id INTEGER,
    p_ip_address TEXT
) RETURNS BOOLEAN AS $$
BEGIN
    -- Log login history
    INSERT INTO login_history (user_id, login_time, ip_address)
    VALUES (p_user_id, NOW(), p_ip_address);
    
    -- Update user's active status
    UPDATE users SET active_status = TRUE WHERE id = p_user_id;
    
    RETURN TRUE;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error in handle_user_login: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- Procedure to handle user logout
CREATE OR REPLACE FUNCTION handle_user_logout(p_user_id INTEGER)
RETURNS BOOLEAN AS $$
DECLARE
    logout_count INTEGER;
BEGIN
    -- Update the most recent login record to add logout time
    UPDATE login_history 
    SET logout_time = NOW() 
    WHERE id = (
        SELECT id FROM login_history 
        WHERE user_id = p_user_id AND logout_time IS NULL 
        ORDER BY login_time DESC 
        LIMIT 1
    );
    
    GET DIAGNOSTICS logout_count = ROW_COUNT;
    
    -- Update user's active status
    UPDATE users SET active_status = FALSE WHERE id = p_user_id;
    
    RETURN logout_count > 0;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error in handle_user_logout: %', SQLERRM;
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- BOOK MANAGEMENT PROCEDURES
-- ============================================================================

-- Procedure to add a book to user's library
CREATE OR REPLACE FUNCTION add_book_to_library(
    p_user_id INTEGER,
    p_book_id INTEGER,
    p_shelf TEXT DEFAULT 'want-to-read'
) RETURNS INTEGER AS $$
DECLARE
    user_book_id INTEGER;
    book_exists BOOLEAN;
    already_in_library BOOLEAN;
BEGIN
    -- Check if book exists
    SELECT EXISTS(SELECT 1 FROM books WHERE id = p_book_id) INTO book_exists;
    
    IF NOT book_exists THEN
        RAISE EXCEPTION 'Book not found';
    END IF;
    
    -- Check if book is already in user's library
    SELECT EXISTS(
        SELECT 1 FROM user_books 
        WHERE user_id = p_user_id AND book_id = p_book_id
    ) INTO already_in_library;
    
    IF already_in_library THEN
        RAISE EXCEPTION 'Book already in library';
    END IF;
    
    -- Add book to user's library
    INSERT INTO user_books (user_id, book_id, shelf, date_added)
    VALUES (p_user_id, p_book_id, p_shelf, CURRENT_TIMESTAMP)
    RETURNING id INTO user_book_id;
    
    RETURN user_book_id;
END;
$$ LANGUAGE plpgsql;

-- Procedure to update book in user's library
CREATE OR REPLACE FUNCTION update_book_in_library(
    p_user_id INTEGER,
    p_book_id INTEGER,
    p_shelf TEXT DEFAULT NULL,
    p_rating INTEGER DEFAULT NULL,
    p_date_read TIMESTAMP DEFAULT NULL,
    p_notes TEXT DEFAULT NULL
) RETURNS BOOLEAN AS $$
DECLARE
    book_in_library BOOLEAN;
    current_shelf TEXT;
BEGIN
    -- Check if book is in user's library
    SELECT EXISTS(
        SELECT 1 FROM user_books 
        WHERE user_id = p_user_id AND book_id = p_book_id
    ), 
    (SELECT shelf FROM user_books WHERE user_id = p_user_id AND book_id = p_book_id)
    INTO book_in_library, current_shelf;
    
    IF NOT book_in_library THEN
        RAISE EXCEPTION 'Book not found in library';
    END IF;
    
    -- Special case: if unmarking as read (shelf is null), remove from library entirely
    IF p_shelf IS NULL THEN
        DELETE FROM user_books WHERE user_id = p_user_id AND book_id = p_book_id;
        RETURN TRUE;
    END IF;
    
    -- Update book details
    UPDATE user_books 
    SET 
        shelf = COALESCE(p_shelf, shelf),
        date_read = CASE 
            WHEN p_shelf = 'read' AND p_date_read IS NULL THEN NOW()
            ELSE COALESCE(p_date_read, date_read)
        END,
        notes = COALESCE(p_notes, notes)
    WHERE user_id = p_user_id AND book_id = p_book_id;
    
    -- If rating was provided, update ratings table
    IF p_rating IS NOT NULL THEN
        -- Insert or update rating
        INSERT INTO ratings (user_id, book_id, value, created_at)
        VALUES (p_user_id, p_book_id, p_rating, CURRENT_TIMESTAMP)
        ON CONFLICT (user_id, book_id) 
        DO UPDATE SET value = EXCLUDED.value, created_at = EXCLUDED.created_at;
    END IF;
    
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- UTILITY FUNCTIONS
-- ============================================================================

-- Function to calculate reading goal progress
CREATE OR REPLACE FUNCTION get_reading_goal_progress(p_user_id INTEGER)
RETURNS TABLE (
    goal INTEGER,
    current_progress BIGINT,
    progress_percentage NUMERIC,
    books_remaining INTEGER
) AS $$
DECLARE
    user_goal INTEGER;
    books_read_this_year BIGINT;
BEGIN
    -- Get user's reading goal
    SELECT reading_goal INTO user_goal FROM users WHERE id = p_user_id;
    
    -- Get books read this year
    SELECT COUNT(*) INTO books_read_this_year
    FROM user_books
    WHERE user_id = p_user_id 
        AND shelf = 'read'
        AND EXTRACT(YEAR FROM date_read) = EXTRACT(YEAR FROM NOW());
    
    RETURN QUERY
    SELECT 
        user_goal as goal,
        books_read_this_year as current_progress,
        CASE 
            WHEN user_goal > 0 THEN (books_read_this_year * 100.0 / user_goal)
            ELSE 0
        END as progress_percentage,
        GREATEST(0, user_goal - books_read_this_year::INTEGER) as books_remaining;
END;
$$ LANGUAGE plpgsql;

-- Function to calculate reading streak
CREATE OR REPLACE FUNCTION get_reading_streak(p_user_id INTEGER)
RETURNS INTEGER AS $$
DECLARE
    streak_count INTEGER := 0;
    month_record RECORD;
BEGIN
    -- Check consecutive months with reading activity
    FOR month_record IN
        SELECT 
            TO_CHAR(date_read, 'YYYY-MM') as month,
            COUNT(*) as books_read
        FROM user_books
        WHERE user_id = p_user_id 
            AND date_read IS NOT NULL
            AND date_read >= NOW() - INTERVAL '12 months'
        GROUP BY TO_CHAR(date_read, 'YYYY-MM')
        ORDER BY month DESC
    LOOP
        IF month_record.books_read > 0 THEN
            streak_count := streak_count + 1;
        ELSE
            EXIT;
        END IF;
    END LOOP;
    
    RETURN streak_count;
END;
$$ LANGUAGE plpgsql;

-- Function to update user's reading goal
CREATE OR REPLACE FUNCTION update_reading_goal(
    p_user_id INTEGER,
    p_goal INTEGER
) RETURNS INTEGER AS $$
DECLARE
    updated_goal INTEGER;
BEGIN
    -- Validate goal
    IF p_goal < 1 OR p_goal > 1000 THEN
        RAISE EXCEPTION 'Goal must be between 1 and 1000';
    END IF;
    
    -- Update user's reading goal
    UPDATE users 
    SET reading_goal = p_goal 
    WHERE id = p_user_id
    RETURNING reading_goal INTO updated_goal;
    
    IF updated_goal IS NULL THEN
        RAISE EXCEPTION 'User not found';
    END IF;
    
    RETURN updated_goal;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- REVIEW AND COMMENT MANAGEMENT PROCEDURES
-- ============================================================================

-- Function to handle review voting with proper transaction management
CREATE OR REPLACE FUNCTION handle_review_vote(
    p_review_id INTEGER,
    p_user_id INTEGER,
    p_vote_type TEXT
) RETURNS JSON AS $$
DECLARE
    existing_vote_type TEXT;
    upvotes_count INTEGER;
    downvotes_count INTEGER;
    user_vote_type TEXT;
    result JSON;
BEGIN
    -- Validate vote type
    IF p_vote_type NOT IN ('upvote', 'downvote') THEN
        RAISE EXCEPTION 'Invalid vote type: %', p_vote_type;
    END IF;
    
    -- Check if user already voted on this review
    SELECT vote_type INTO existing_vote_type
    FROM votes 
    WHERE review_id = p_review_id AND user_id = p_user_id;
    
    IF existing_vote_type IS NOT NULL THEN
        IF existing_vote_type = p_vote_type THEN
            -- Remove vote (user clicked same button)
            DELETE FROM votes 
            WHERE review_id = p_review_id AND user_id = p_user_id;
            user_vote_type := NULL;
        ELSE
            -- Update vote (user switched from upvote to downvote or vice versa)
            UPDATE votes 
            SET vote_type = p_vote_type, updated_at = NOW() 
            WHERE review_id = p_review_id AND user_id = p_user_id;
            user_vote_type := p_vote_type;
        END IF;
    ELSE
        -- Insert new vote
        INSERT INTO votes (review_id, user_id, vote_type, created_at)
        VALUES (p_review_id, p_user_id, p_vote_type, NOW());
        user_vote_type := p_vote_type;
    END IF;
    
    -- Update vote counts in reviews table
    SELECT 
        COUNT(CASE WHEN vote_type = 'upvote' THEN 1 END),
        COUNT(CASE WHEN vote_type = 'downvote' THEN 1 END)
    INTO upvotes_count, downvotes_count
    FROM votes 
    WHERE review_id = p_review_id;
    
    UPDATE reviews 
    SET upvotes = upvotes_count, downvotes = downvotes_count 
    WHERE id = p_review_id;
    
    -- Return result as JSON
    result := json_build_object(
        'success', true,
        'upvotes', upvotes_count,
        'downvotes', downvotes_count,
        'user_vote', user_vote_type
    );
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Function to handle comment voting with proper transaction management
CREATE OR REPLACE FUNCTION handle_comment_vote(
    p_comment_id INTEGER,
    p_user_id INTEGER,
    p_vote_type TEXT
) RETURNS JSON AS $$
DECLARE
    existing_vote_type TEXT;
    upvotes_count INTEGER;
    downvotes_count INTEGER;
    user_vote_type TEXT;
    result JSON;
BEGIN
    -- Validate vote type
    IF p_vote_type NOT IN ('upvote', 'downvote') THEN
        RAISE EXCEPTION 'Invalid vote type: %', p_vote_type;
    END IF;
    
    -- Check if user already voted on this comment
    SELECT vote_type INTO existing_vote_type
    FROM votes 
    WHERE comment_id = p_comment_id AND user_id = p_user_id;
    
    IF existing_vote_type IS NOT NULL THEN
        IF existing_vote_type = p_vote_type THEN
            -- Remove vote (user clicked same button)
            DELETE FROM votes 
            WHERE comment_id = p_comment_id AND user_id = p_user_id;
            user_vote_type := NULL;
        ELSE
            -- Update vote (user switched from upvote to downvote or vice versa)
            UPDATE votes 
            SET vote_type = p_vote_type, updated_at = NOW() 
            WHERE comment_id = p_comment_id AND user_id = p_user_id;
            user_vote_type := p_vote_type;
        END IF;
    ELSE
        -- Insert new vote
        INSERT INTO votes (comment_id, user_id, vote_type, created_at)
        VALUES (p_comment_id, p_user_id, p_vote_type, NOW());
        user_vote_type := p_vote_type;
    END IF;
    
    -- Update vote counts in comments table
    SELECT 
        COUNT(CASE WHEN vote_type = 'upvote' THEN 1 END),
        COUNT(CASE WHEN vote_type = 'downvote' THEN 1 END)
    INTO upvotes_count, downvotes_count
    FROM votes 
    WHERE comment_id = p_comment_id;
    
    UPDATE comments 
    SET upvotes = upvotes_count, downvotes = downvotes_count 
    WHERE id = p_comment_id;
    
    -- Return result as JSON
    result := json_build_object(
        'success', true,
        'upvotes', upvotes_count,
        'downvotes', downvotes_count,
        'user_vote', user_vote_type
    );
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Function to add a review with rating in a single transaction
CREATE OR REPLACE FUNCTION add_review_with_rating(
    p_user_id INTEGER,
    p_book_id INTEGER,
    p_title TEXT,
    p_body TEXT,
    p_rating INTEGER
) RETURNS INTEGER AS $$
DECLARE
    review_id INTEGER;
    existing_rating_id INTEGER;
BEGIN
    -- Validate rating
    IF p_rating < 1 OR p_rating > 5 THEN
        RAISE EXCEPTION 'Rating must be between 1 and 5';
    END IF;
    
    -- Insert the review
    INSERT INTO reviews (user_id, book_id, title, body, rating, created_at, updated_at)
    VALUES (p_user_id, p_book_id, p_title, p_body, p_rating, NOW(), NOW())
    RETURNING id INTO review_id;
    
    -- Check if rating exists for this user and book
    SELECT id INTO existing_rating_id
    FROM ratings 
    WHERE user_id = p_user_id AND book_id = p_book_id;
    
    IF existing_rating_id IS NOT NULL THEN
        -- Update existing rating
        UPDATE ratings 
        SET value = p_rating, created_at = NOW() 
        WHERE id = existing_rating_id;
    ELSE
        -- Insert new rating
        INSERT INTO ratings (user_id, book_id, value, created_at)
        VALUES (p_user_id, p_book_id, p_rating, NOW());
    END IF;
    
    RETURN review_id;
END;
$$ LANGUAGE plpgsql;

-- Function to add a comment with reply count update
CREATE OR REPLACE FUNCTION add_comment_with_reply_count(
    p_review_id INTEGER,
    p_user_id INTEGER,
    p_comment_body TEXT,
    p_parent_comment_id INTEGER DEFAULT NULL
) RETURNS INTEGER AS $$
DECLARE
    comment_id INTEGER;
BEGIN
    -- Validate comment body
    IF p_comment_body IS NULL OR trim(p_comment_body) = '' THEN
        RAISE EXCEPTION 'Comment cannot be empty';
    END IF;
    
    -- Insert comment
    INSERT INTO comments (review_id, user_id, body, parent_comment_id, created_at)
    VALUES (p_review_id, p_user_id, trim(p_comment_body), p_parent_comment_id, NOW())
    RETURNING id INTO comment_id;
    
    -- If this is a reply, update the parent comment's reply count
    IF p_parent_comment_id IS NOT NULL THEN
        UPDATE comments 
        SET reply_count = reply_count + 1 
        WHERE id = p_parent_comment_id;
    END IF;
    
    RETURN comment_id;
END;
$$ LANGUAGE plpgsql;

-- Function to get review with comments and votes for a specific user
CREATE OR REPLACE FUNCTION get_review_with_user_votes(
    p_review_id INTEGER,
    p_user_id INTEGER DEFAULT NULL
) RETURNS TABLE (
    review_id INTEGER,
    review_title TEXT,
    review_body TEXT,
    review_rating INTEGER,
    review_upvotes INTEGER,
    review_downvotes INTEGER,
    review_created_at TIMESTAMP,
    review_user_vote TEXT,
    book_id INTEGER,
    book_title TEXT,
    author_name TEXT,
    user_id INTEGER,
    user_name TEXT,
    user_first_name TEXT,
    user_last_name TEXT,
    user_profile_picture TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        r.id,
        r.title,
        r.body,
        r.rating,
        r.upvotes,
        r.downvotes,
        r.created_at,
        CASE 
            WHEN p_user_id IS NULL THEN NULL
            ELSE (SELECT vote_type FROM votes WHERE review_id = r.id AND user_id = p_user_id)
        END as user_vote,
        b.id as book_id,
        b.title as book_title,
        a.name as author_name,
        u.id as user_id,
        u.username as user_name,
        u.first_name,
        u.last_name,
        u.profile_picture_url
    FROM reviews r
    JOIN users u ON r.user_id = u.id
    JOIN books b ON r.book_id = b.id
    JOIN book_authors ba ON b.id = ba.book_id
    JOIN authors a ON ba.author_id = a.id
    WHERE r.id = p_review_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- INDEXES FOR PERFORMANCE
-- ============================================================================

-- Create indexes to optimize stored procedure performance
CREATE INDEX IF NOT EXISTS idx_user_books_user_shelf ON user_books(user_id, shelf);
CREATE INDEX IF NOT EXISTS idx_user_books_user_date_read ON user_books(user_id, date_read);
CREATE INDEX IF NOT EXISTS idx_ratings_user_id ON ratings(user_id);
CREATE INDEX IF NOT EXISTS idx_login_history_user_logout ON login_history(user_id, logout_time);
CREATE INDEX IF NOT EXISTS idx_book_genres_book_id ON book_genres(book_id);
CREATE INDEX IF NOT EXISTS idx_book_authors_book_id ON book_authors(book_id);

-- Add unique constraint for ratings if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'unique_user_book_rating'
    ) THEN
        ALTER TABLE ratings 
        ADD CONSTRAINT unique_user_book_rating 
        UNIQUE (user_id, book_id);
    END IF;
END $$;