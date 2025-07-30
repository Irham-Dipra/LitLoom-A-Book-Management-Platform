-- Fix book deletion trigger function for CASCADE behavior
CREATE OR REPLACE FUNCTION track_book_deletion() 
RETURNS trigger AS $$
DECLARE
    reviews_json JSONB;
    comments_json JSONB;
    ratings_json JSONB;
    user_books_json JSONB;
    review_count INTEGER;
    comment_count INTEGER;
    rating_count INTEGER;
    user_book_count INTEGER;
BEGIN
    -- Collect all review data for this book
    SELECT 
        COALESCE(json_agg(reviews.*), '[]'::json)::jsonb,
        COUNT(*)
    INTO reviews_json, review_count
    FROM reviews 
    WHERE book_id = OLD.id;
    
    -- Collect all comment data for reviews of this book
    SELECT 
        COALESCE(json_agg(c.*), '[]'::json)::jsonb,
        COUNT(*)
    INTO comments_json, comment_count
    FROM comments c
    JOIN reviews r ON c.review_id = r.id
    WHERE r.book_id = OLD.id;
    
    -- Collect all rating data for this book
    SELECT 
        COALESCE(json_agg(ratings.*), '[]'::json)::jsonb,
        COUNT(*)
    INTO ratings_json, rating_count
    FROM ratings 
    WHERE book_id = OLD.id;
    
    -- Collect all user_books data for this book
    SELECT 
        COALESCE(json_agg(user_books.*), '[]'::json)::jsonb,
        COUNT(*)
    INTO user_books_json, user_book_count
    FROM user_books 
    WHERE book_id = OLD.id;
    
    -- Log everything to deletion log
    INSERT INTO book_deletion_log (
        book_id, book_data, reviews_data, comments_data, ratings_data, user_books_data,
        deletion_reason, total_reviews, total_comments, total_ratings, total_user_books
    ) VALUES (
        OLD.id, 
        to_jsonb(OLD.*), 
        reviews_json, 
        comments_json, 
        ratings_json, 
        user_books_json,
        'Book deleted by moderator',
        review_count,
        comment_count,
        rating_count,
        user_book_count
    );
    
    -- Note: No need to update deleted_book_title since records will be cascaded
    -- The data is already preserved in the deletion log above
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;