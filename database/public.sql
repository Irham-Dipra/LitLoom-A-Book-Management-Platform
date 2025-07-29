/*
 Navicat Premium Dump SQL

 Source Server         : litloom
 Source Server Type    : PostgreSQL
 Source Server Version : 160009 (160009)
 Source Host           : localhost:5432
 Source Catalog        : litloom
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 160009 (160009)
 File Encoding         : 65001

 Date: 29/07/2025 15:35:43
*/


-- ----------------------------
-- Sequence structure for authors_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."authors_id_seq";
CREATE SEQUENCE "public"."authors_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."authors_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for book_character_appearances_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."book_character_appearances_id_seq";
CREATE SEQUENCE "public"."book_character_appearances_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."book_character_appearances_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for book_deletion_log_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."book_deletion_log_id_seq";
CREATE SEQUENCE "public"."book_deletion_log_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."book_deletion_log_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for book_genres_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."book_genres_id_seq";
CREATE SEQUENCE "public"."book_genres_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."book_genres_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for book_suggestions_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."book_suggestions_id_seq";
CREATE SEQUENCE "public"."book_suggestions_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."book_suggestions_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for books_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."books_id_seq";
CREATE SEQUENCE "public"."books_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."books_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for characters_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."characters_id_seq";
CREATE SEQUENCE "public"."characters_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."characters_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for comments_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."comments_id_seq";
CREATE SEQUENCE "public"."comments_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."comments_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for failed_searches_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."failed_searches_id_seq";
CREATE SEQUENCE "public"."failed_searches_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."failed_searches_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for genres_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."genres_id_seq";
CREATE SEQUENCE "public"."genres_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."genres_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for languages_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."languages_id_seq";
CREATE SEQUENCE "public"."languages_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."languages_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for login_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."login_history_id_seq";
CREATE SEQUENCE "public"."login_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."login_history_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for publication_houses_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."publication_houses_id_seq";
CREATE SEQUENCE "public"."publication_houses_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."publication_houses_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for ratings_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."ratings_id_seq";
CREATE SEQUENCE "public"."ratings_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."ratings_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for reviews_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."reviews_id_seq";
CREATE SEQUENCE "public"."reviews_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."reviews_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for search_queries_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."search_queries_id_seq";
CREATE SEQUENCE "public"."search_queries_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."search_queries_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for user_books_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."user_books_id_seq";
CREATE SEQUENCE "public"."user_books_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."user_books_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for user_deactivation_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."user_deactivation_history_id_seq";
CREATE SEQUENCE "public"."user_deactivation_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."user_deactivation_history_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for users_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."users_id_seq";
CREATE SEQUENCE "public"."users_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."users_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for votes_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."votes_id_seq";
CREATE SEQUENCE "public"."votes_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;
ALTER SEQUENCE "public"."votes_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Table structure for authors
-- ----------------------------
DROP TABLE IF EXISTS "public"."authors";
CREATE TABLE "public"."authors" (
  "id" int4 NOT NULL DEFAULT nextval('authors_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "bio" text COLLATE "pg_catalog"."default",
  "author_image" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."authors" OWNER TO "postgres";

-- ----------------------------
-- Table structure for book_authors
-- ----------------------------
DROP TABLE IF EXISTS "public"."book_authors";
CREATE TABLE "public"."book_authors" (
  "book_id" int4 NOT NULL,
  "author_id" int4 NOT NULL
)
;
ALTER TABLE "public"."book_authors" OWNER TO "postgres";

-- ----------------------------
-- Table structure for book_character_appearances
-- ----------------------------
DROP TABLE IF EXISTS "public"."book_character_appearances";
CREATE TABLE "public"."book_character_appearances" (
  "id" int4 NOT NULL DEFAULT nextval('book_character_appearances_id_seq'::regclass),
  "book_id" int4 NOT NULL,
  "character_id" int4 NOT NULL,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "public"."book_character_appearances" OWNER TO "postgres";

-- ----------------------------
-- Table structure for book_deletion_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."book_deletion_log";
CREATE TABLE "public"."book_deletion_log" (
  "id" int4 NOT NULL DEFAULT nextval('book_deletion_log_id_seq'::regclass),
  "book_id" int4 NOT NULL,
  "book_data" jsonb NOT NULL,
  "reviews_data" jsonb,
  "comments_data" jsonb,
  "ratings_data" jsonb,
  "user_books_data" jsonb,
  "deletion_reason" text COLLATE "pg_catalog"."default",
  "deleted_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "deleted_by" int4,
  "total_reviews" int4 DEFAULT 0,
  "total_comments" int4 DEFAULT 0,
  "total_ratings" int4 DEFAULT 0,
  "total_user_books" int4 DEFAULT 0
)
;
ALTER TABLE "public"."book_deletion_log" OWNER TO "postgres";

-- ----------------------------
-- Table structure for book_genres
-- ----------------------------
DROP TABLE IF EXISTS "public"."book_genres";
CREATE TABLE "public"."book_genres" (
  "id" int4 NOT NULL DEFAULT nextval('book_genres_id_seq'::regclass),
  "book_id" int4 NOT NULL,
  "genre_id" int4 NOT NULL
)
;
ALTER TABLE "public"."book_genres" OWNER TO "postgres";

-- ----------------------------
-- Table structure for book_suggestions
-- ----------------------------
DROP TABLE IF EXISTS "public"."book_suggestions";
CREATE TABLE "public"."book_suggestions" (
  "id" int4 NOT NULL DEFAULT nextval('book_suggestions_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "author_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "language" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "genre" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "submitted_at" timestamp(6) NOT NULL,
  "approved" char(1) COLLATE "pg_catalog"."default" NOT NULL DEFAULT '0'::bpchar,
  "approved_at" timestamp(6),
  "approved_by" int4
)
;
ALTER TABLE "public"."book_suggestions" OWNER TO "postgres";

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS "public"."books";
CREATE TABLE "public"."books" (
  "id" int4 NOT NULL DEFAULT nextval('books_id_seq'::regclass),
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" text COLLATE "pg_catalog"."default",
  "publication_date" date,
  "cover_image" varchar(500) COLLATE "pg_catalog"."default",
  "original_country" varchar(100) COLLATE "pg_catalog"."default",
  "language_id" int4,
  "publication_house_id" int4,
  "average_rating" numeric(3,2) DEFAULT 0,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "added_by" int4,
  "isbn" varchar(20) COLLATE "pg_catalog"."default",
  "readers_count" int4 DEFAULT 0,
  "page" int4
)
;
ALTER TABLE "public"."books" OWNER TO "postgres";

-- ----------------------------
-- Table structure for characters
-- ----------------------------
DROP TABLE IF EXISTS "public"."characters";
CREATE TABLE "public"."characters" (
  "id" int4 NOT NULL DEFAULT nextval('characters_id_seq'::regclass),
  "name" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
  "biography" text COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "public"."characters" OWNER TO "postgres";

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS "public"."comments";
CREATE TABLE "public"."comments" (
  "id" int4 NOT NULL DEFAULT nextval('comments_id_seq'::regclass),
  "review_id" int4 NOT NULL,
  "user_id" int4 NOT NULL,
  "body" text COLLATE "pg_catalog"."default" NOT NULL,
  "parent_comment_id" int4,
  "created_at" timestamp(6) NOT NULL,
  "upvotes" int4 DEFAULT 0,
  "downvotes" int4 DEFAULT 0,
  "reply_count" int4 DEFAULT 0
)
;
ALTER TABLE "public"."comments" OWNER TO "postgres";

-- ----------------------------
-- Table structure for failed_searches
-- ----------------------------
DROP TABLE IF EXISTS "public"."failed_searches";
CREATE TABLE "public"."failed_searches" (
  "id" int4 NOT NULL DEFAULT nextval('failed_searches_id_seq'::regclass),
  "search_query_id" int4,
  "search_category" varchar(50) COLLATE "pg_catalog"."default",
  "missing_term" text COLLATE "pg_catalog"."default",
  "normalized_term" text COLLATE "pg_catalog"."default",
  "search_context" jsonb,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "public"."failed_searches" OWNER TO "postgres";

-- ----------------------------
-- Table structure for genres
-- ----------------------------
DROP TABLE IF EXISTS "public"."genres";
CREATE TABLE "public"."genres" (
  "id" int4 NOT NULL DEFAULT nextval('genres_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."genres" OWNER TO "postgres";

-- ----------------------------
-- Table structure for languages
-- ----------------------------
DROP TABLE IF EXISTS "public"."languages";
CREATE TABLE "public"."languages" (
  "id" int4 NOT NULL DEFAULT nextval('languages_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "iso_code" varchar(10) COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."languages" OWNER TO "postgres";

-- ----------------------------
-- Table structure for login_history
-- ----------------------------
DROP TABLE IF EXISTS "public"."login_history";
CREATE TABLE "public"."login_history" (
  "id" int4 NOT NULL DEFAULT nextval('login_history_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "login_time" timestamp(6) NOT NULL,
  "ip_address" varchar(45) COLLATE "pg_catalog"."default" NOT NULL,
  "logout_time" timestamp(6)
)
;
ALTER TABLE "public"."login_history" OWNER TO "postgres";

-- ----------------------------
-- Table structure for moderator_accounts
-- ----------------------------
DROP TABLE IF EXISTS "public"."moderator_accounts";
CREATE TABLE "public"."moderator_accounts" (
  "user_id" int4 NOT NULL
)
;
ALTER TABLE "public"."moderator_accounts" OWNER TO "postgres";

-- ----------------------------
-- Table structure for publication_houses
-- ----------------------------
DROP TABLE IF EXISTS "public"."publication_houses";
CREATE TABLE "public"."publication_houses" (
  "id" int4 NOT NULL DEFAULT nextval('publication_houses_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "public"."publication_houses" OWNER TO "postgres";

-- ----------------------------
-- Table structure for ratings
-- ----------------------------
DROP TABLE IF EXISTS "public"."ratings";
CREATE TABLE "public"."ratings" (
  "id" int4 NOT NULL DEFAULT nextval('ratings_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "book_id" int4 NOT NULL,
  "value" int4 NOT NULL,
  "created_at" timestamp(6) NOT NULL,
  "deleted_book_title" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."ratings" OWNER TO "postgres";

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS "public"."reviews";
CREATE TABLE "public"."reviews" (
  "id" int4 NOT NULL DEFAULT nextval('reviews_id_seq'::regclass),
  "book_id" int4 NOT NULL,
  "user_id" int4 NOT NULL,
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "body" text COLLATE "pg_catalog"."default",
  "rating" int4 NOT NULL,
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL,
  "upvotes" int4 DEFAULT 0,
  "downvotes" int4 DEFAULT 0,
  "deleted_book_title" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."reviews" OWNER TO "postgres";

-- ----------------------------
-- Table structure for search_queries
-- ----------------------------
DROP TABLE IF EXISTS "public"."search_queries";
CREATE TABLE "public"."search_queries" (
  "id" int4 NOT NULL DEFAULT nextval('search_queries_id_seq'::regclass),
  "user_id" int4,
  "query_text" text COLLATE "pg_catalog"."default",
  "normalized_query" text COLLATE "pg_catalog"."default",
  "search_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "search_filters" jsonb,
  "result_count" int4 DEFAULT 0,
  "search_timestamp" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "ip_address" inet,
  "user_agent" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."search_queries" OWNER TO "postgres";

-- ----------------------------
-- Table structure for user_accounts
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_accounts";
CREATE TABLE "public"."user_accounts" (
  "user_id" int4 NOT NULL
)
;
ALTER TABLE "public"."user_accounts" OWNER TO "postgres";

-- ----------------------------
-- Table structure for user_books
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_books";
CREATE TABLE "public"."user_books" (
  "id" int4 NOT NULL DEFAULT nextval('user_books_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "book_id" int4 NOT NULL,
  "shelf" varchar(50) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'want-to-read'::character varying,
  "date_added" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "date_read" timestamp(6),
  "review_id" int4,
  "notes" text COLLATE "pg_catalog"."default",
  "deleted_book_title" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."user_books" OWNER TO "postgres";

-- ----------------------------
-- Table structure for user_deactivation_history
-- ----------------------------
DROP TABLE IF EXISTS "public"."user_deactivation_history";
CREATE TABLE "public"."user_deactivation_history" (
  "id" int4 NOT NULL DEFAULT nextval('user_deactivation_history_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "moderator_id" int4 NOT NULL,
  "action" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "reason" text COLLATE "pg_catalog"."default",
  "duration_days" int4,
  "auto_reactivate_at" timestamp(6),
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "public"."user_deactivation_history" OWNER TO "postgres";

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "public"."users";
CREATE TABLE "public"."users" (
  "id" int4 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
  "email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "username" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "profile_picture_url" varchar(500) COLLATE "pg_catalog"."default",
  "bio" text COLLATE "pg_catalog"."default",
  "first_name" varchar(100) COLLATE "pg_catalog"."default",
  "last_name" varchar(100) COLLATE "pg_catalog"."default",
  "active_status" bool NOT NULL DEFAULT false,
  "is_active" bool DEFAULT true,
  "deactivation_reason" text COLLATE "pg_catalog"."default",
  "deactivated_by" int4,
  "deactivated_at" timestamp(6),
  "deactivation_duration_days" int4,
  "auto_reactivate_at" timestamp(6),
  "reading_goal" int4 DEFAULT 12
)
;
ALTER TABLE "public"."users" OWNER TO "postgres";

-- ----------------------------
-- Table structure for votes
-- ----------------------------
DROP TABLE IF EXISTS "public"."votes";
CREATE TABLE "public"."votes" (
  "id" int4 NOT NULL DEFAULT nextval('votes_id_seq'::regclass),
  "user_id" int4 NOT NULL,
  "review_id" int4,
  "comment_id" int4,
  "vote_type" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) NOT NULL
)
;
ALTER TABLE "public"."votes" OWNER TO "postgres";

-- ----------------------------
-- Function structure for add_book_to_library
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."add_book_to_library"("p_user_id" int4, "p_book_id" int4, "p_shelf" text);
CREATE FUNCTION "public"."add_book_to_library"("p_user_id" int4, "p_book_id" int4, "p_shelf" text='want-to-read'::text)
  RETURNS "pg_catalog"."int4" AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."add_book_to_library"("p_user_id" int4, "p_book_id" int4, "p_shelf" text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for add_comment_with_reply_count
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."add_comment_with_reply_count"("p_review_id" int4, "p_user_id" int4, "p_comment_body" text, "p_parent_comment_id" int4);
CREATE FUNCTION "public"."add_comment_with_reply_count"("p_review_id" int4, "p_user_id" int4, "p_comment_body" text, "p_parent_comment_id" int4=NULL::integer)
  RETURNS "pg_catalog"."int4" AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."add_comment_with_reply_count"("p_review_id" int4, "p_user_id" int4, "p_comment_body" text, "p_parent_comment_id" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for add_review_with_rating
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."add_review_with_rating"("p_user_id" int4, "p_book_id" int4, "p_title" text, "p_body" text, "p_rating" int4);
CREATE FUNCTION "public"."add_review_with_rating"("p_user_id" int4, "p_book_id" int4, "p_title" text, "p_body" text, "p_rating" int4)
  RETURNS "pg_catalog"."int4" AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."add_review_with_rating"("p_user_id" int4, "p_book_id" int4, "p_title" text, "p_body" text, "p_rating" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for auto_reactivate_users
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."auto_reactivate_users"();
CREATE FUNCTION "public"."auto_reactivate_users"()
  RETURNS "pg_catalog"."int4" AS $BODY$
DECLARE
    reactivated_count INTEGER := 0;
    user_record RECORD;
BEGIN
    -- Find users who should be automatically reactivated
    FOR user_record IN 
        SELECT id, username, auto_reactivate_at 
        FROM users 
        WHERE is_active = FALSE 
        AND auto_reactivate_at IS NOT NULL 
        AND auto_reactivate_at <= CURRENT_TIMESTAMP
    LOOP
        -- Reactivate the user
        UPDATE users 
        SET is_active = TRUE,
            deactivation_reason = NULL,
            deactivated_by = NULL,
            deactivated_at = NULL,
            deactivation_duration_days = NULL,
            auto_reactivate_at = NULL
        WHERE id = user_record.id;
        
        -- Log the automatic reactivation
        INSERT INTO user_deactivation_history (
            user_id, 
            moderator_id, 
            action, 
            reason
        ) VALUES (
            user_record.id,
            1, -- System user ID (should be created if doesn't exist)
            'reactivate',
            'Automatic reactivation after deactivation period expired'
        );
        
        reactivated_count := reactivated_count + 1;
        
        -- Log the reactivation
        RAISE NOTICE 'Auto-reactivated user ID: %, Username: %, Was scheduled for: %', 
            user_record.id, user_record.username, user_record.auto_reactivate_at;
    END LOOP;
    
    RETURN reactivated_count;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."auto_reactivate_users"() OWNER TO "postgres";
COMMENT ON FUNCTION "public"."auto_reactivate_users"() IS 'Call this function periodically (hourly/daily) to automatically reactivate users whose deactivation period has expired';

-- ----------------------------
-- Function structure for deactivate_user
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."deactivate_user"("p_user_id" int4, "p_moderator_id" int4, "p_reason" text, "p_duration_days" int4);
CREATE FUNCTION "public"."deactivate_user"("p_user_id" int4, "p_moderator_id" int4, "p_reason" text, "p_duration_days" int4=NULL::integer)
  RETURNS "pg_catalog"."bool" AS $BODY$
DECLARE
    auto_reactivate_date TIMESTAMP := NULL;
BEGIN
    -- Check if user exists and is currently active
    IF NOT EXISTS (SELECT 1 FROM users WHERE id = p_user_id AND is_active = TRUE) THEN
        RAISE EXCEPTION 'User not found or already deactivated';
    END IF;
    
    -- Check if moderator exists and has permission (role = 'moderator')
    IF NOT EXISTS (SELECT 1 FROM users WHERE id = p_moderator_id AND role = 'moderator') THEN
        RAISE EXCEPTION 'Moderator not found or insufficient permissions';
    END IF;
    
    -- Calculate auto reactivation date if duration is provided
    IF p_duration_days IS NOT NULL AND p_duration_days > 0 THEN
        auto_reactivate_date := CURRENT_TIMESTAMP + (p_duration_days || ' days')::INTERVAL;
    END IF;
    
    -- Deactivate the user
    UPDATE users 
    SET is_active = FALSE,
        deactivation_reason = p_reason,
        deactivated_by = p_moderator_id,
        deactivated_at = CURRENT_TIMESTAMP,
        deactivation_duration_days = p_duration_days,
        auto_reactivate_at = auto_reactivate_date
    WHERE id = p_user_id;
    
    -- Log the deactivation
    INSERT INTO user_deactivation_history (
        user_id, 
        moderator_id, 
        action, 
        reason, 
        duration_days, 
        auto_reactivate_at
    ) VALUES (
        p_user_id,
        p_moderator_id,
        'deactivate',
        p_reason,
        p_duration_days,
        auto_reactivate_date
    );
    
    RETURN TRUE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."deactivate_user"("p_user_id" int4, "p_moderator_id" int4, "p_reason" text, "p_duration_days" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for get_book_deletion_stats
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_book_deletion_stats"();
CREATE FUNCTION "public"."get_book_deletion_stats"()
  RETURNS TABLE("total_deleted_books" int4, "total_preserved_reviews" int4, "total_preserved_comments" int4, "total_preserved_ratings" int4, "total_preserved_user_books" int4, "last_deletion_date" timestamp) AS $BODY$
BEGIN
    RETURN QUERY
    SELECT 
        COUNT(*)::INTEGER as total_deleted_books,
        SUM(bdl.total_reviews)::INTEGER as total_preserved_reviews,
        SUM(bdl.total_comments)::INTEGER as total_preserved_comments,
        SUM(bdl.total_ratings)::INTEGER as total_preserved_ratings,
        SUM(bdl.total_user_books)::INTEGER as total_preserved_user_books,
        MAX(bdl.deleted_at) as last_deletion_date
    FROM book_deletion_log bdl;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "public"."get_book_deletion_stats"() OWNER TO "postgres";

-- ----------------------------
-- Function structure for get_monthly_reading_activity
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_monthly_reading_activity"("p_user_id" int4, "p_months" int4);
CREATE FUNCTION "public"."get_monthly_reading_activity"("p_user_id" int4, "p_months" int4=12)
  RETURNS TABLE("month" text, "books_read" int8, "pages_read" int8) AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "public"."get_monthly_reading_activity"("p_user_id" int4, "p_months" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for get_reading_goal_progress
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_reading_goal_progress"("p_user_id" int4);
CREATE FUNCTION "public"."get_reading_goal_progress"("p_user_id" int4)
  RETURNS TABLE("goal" int4, "current_progress" int8, "progress_percentage" numeric, "books_remaining" int4) AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "public"."get_reading_goal_progress"("p_user_id" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for get_reading_streak
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_reading_streak"("p_user_id" int4);
CREATE FUNCTION "public"."get_reading_streak"("p_user_id" int4)
  RETURNS "pg_catalog"."int4" AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."get_reading_streak"("p_user_id" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for get_review_with_user_votes
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_review_with_user_votes"("p_review_id" int4, "p_user_id" int4);
CREATE FUNCTION "public"."get_review_with_user_votes"("p_review_id" int4, "p_user_id" int4=NULL::integer)
  RETURNS TABLE("review_id" int4, "review_title" text, "review_body" text, "review_rating" int4, "review_upvotes" int4, "review_downvotes" int4, "review_created_at" timestamp, "review_user_vote" text, "book_id" int4, "book_title" text, "author_name" text, "user_id" int4, "user_name" text, "user_first_name" text, "user_last_name" text, "user_profile_picture" text) AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "public"."get_review_with_user_votes"("p_review_id" int4, "p_user_id" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for get_user_author_stats
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_user_author_stats"("p_user_id" int4, "p_limit" int4);
CREATE FUNCTION "public"."get_user_author_stats"("p_user_id" int4, "p_limit" int4=10)
  RETURNS TABLE("author" text, "book_count" int8, "avg_rating" numeric) AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "public"."get_user_author_stats"("p_user_id" int4, "p_limit" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for get_user_book_length_stats
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_user_book_length_stats"("p_user_id" int4);
CREATE FUNCTION "public"."get_user_book_length_stats"("p_user_id" int4)
  RETURNS TABLE("length_category" text, "book_count" int8) AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "public"."get_user_book_length_stats"("p_user_id" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for get_user_genre_stats
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_user_genre_stats"("p_user_id" int4, "p_limit" int4);
CREATE FUNCTION "public"."get_user_genre_stats"("p_user_id" int4, "p_limit" int4=10)
  RETURNS TABLE("genre" text, "book_count" int8) AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "public"."get_user_genre_stats"("p_user_id" int4, "p_limit" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for get_user_rating_distribution
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_user_rating_distribution"("p_user_id" int4);
CREATE FUNCTION "public"."get_user_rating_distribution"("p_user_id" int4)
  RETURNS TABLE("rating" int4, "count" int8) AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "public"."get_user_rating_distribution"("p_user_id" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for get_user_reading_stats
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."get_user_reading_stats"("p_user_id" int4);
CREATE FUNCTION "public"."get_user_reading_stats"("p_user_id" int4)
  RETURNS TABLE("total_books" int8, "books_read" int8, "currently_reading" int8, "want_to_read" int8, "total_pages_read" int8, "avg_pages_per_book" numeric, "rated_books" int8, "user_avg_rating" numeric, "library_avg_rating" numeric, "books_with_ratings" int8, "books_read_this_year" int8, "pages_read_this_year" int8, "reading_goal" int4) AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION "public"."get_user_reading_stats"("p_user_id" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for handle_comment_vote
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."handle_comment_vote"("p_comment_id" int4, "p_user_id" int4, "p_vote_type" text);
CREATE FUNCTION "public"."handle_comment_vote"("p_comment_id" int4, "p_user_id" int4, "p_vote_type" text)
  RETURNS "pg_catalog"."json" AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."handle_comment_vote"("p_comment_id" int4, "p_user_id" int4, "p_vote_type" text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for handle_review_vote
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."handle_review_vote"("p_review_id" int4, "p_user_id" int4, "p_vote_type" text);
CREATE FUNCTION "public"."handle_review_vote"("p_review_id" int4, "p_user_id" int4, "p_vote_type" text)
  RETURNS "pg_catalog"."json" AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."handle_review_vote"("p_review_id" int4, "p_user_id" int4, "p_vote_type" text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for handle_user_login
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."handle_user_login"("user_id_param" int4, "ip_address_param" text);
CREATE FUNCTION "public"."handle_user_login"("user_id_param" int4, "ip_address_param" text)
  RETURNS "pg_catalog"."bool" AS $BODY$
BEGIN
    -- Insert login record
    INSERT INTO login_history (user_id, login_time, ip_address)
    VALUES (user_id_param, NOW(), ip_address_param);
    
    -- Update user active status
    UPDATE users SET active_status = true WHERE id = user_id_param;
    
    RETURN true;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error in handle_user_login: %', SQLERRM;
        RETURN false;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."handle_user_login"("user_id_param" int4, "ip_address_param" text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for handle_user_logout
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."handle_user_logout"("p_user_id" int4);
CREATE FUNCTION "public"."handle_user_logout"("p_user_id" int4)
  RETURNS "pg_catalog"."bool" AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."handle_user_logout"("p_user_id" int4) OWNER TO "postgres";

-- ----------------------------
-- Function structure for normalize_search_term
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."normalize_search_term"("input_text" text);
CREATE FUNCTION "public"."normalize_search_term"("input_text" text)
  RETURNS "pg_catalog"."text" AS $BODY$
BEGIN
    RETURN LOWER(REGEXP_REPLACE(input_text, '[^a-zA-Z0-9]', '', 'g'));
END;
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 100;
ALTER FUNCTION "public"."normalize_search_term"("input_text" text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for reactivate_user
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."reactivate_user"("p_user_id" int4, "p_moderator_id" int4, "p_reason" text);
CREATE FUNCTION "public"."reactivate_user"("p_user_id" int4, "p_moderator_id" int4, "p_reason" text='Manual reactivation by moderator'::text)
  RETURNS "pg_catalog"."bool" AS $BODY$
BEGIN
    -- Check if user exists and is currently deactivated
    IF NOT EXISTS (SELECT 1 FROM users WHERE id = p_user_id AND is_active = FALSE) THEN
        RAISE EXCEPTION 'User not found or already active';
    END IF;
    
    -- Check if moderator exists and has permission
    IF NOT EXISTS (SELECT 1 FROM users WHERE id = p_moderator_id AND role = 'moderator') THEN
        RAISE EXCEPTION 'Moderator not found or insufficient permissions';
    END IF;
    
    -- Reactivate the user
    UPDATE users 
    SET is_active = TRUE,
        deactivation_reason = NULL,
        deactivated_by = NULL,
        deactivated_at = NULL,
        deactivation_duration_days = NULL,
        auto_reactivate_at = NULL
    WHERE id = p_user_id;
    
    -- Log the reactivation
    INSERT INTO user_deactivation_history (
        user_id, 
        moderator_id, 
        action, 
        reason
    ) VALUES (
        p_user_id,
        p_moderator_id,
        'reactivate',
        p_reason
    );
    
    RETURN TRUE;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."reactivate_user"("p_user_id" int4, "p_moderator_id" int4, "p_reason" text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for track_book_deletion
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."track_book_deletion"();
CREATE FUNCTION "public"."track_book_deletion"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
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
    
    -- Update user data with deleted book title before foreign key is set to NULL
    UPDATE user_books 
    SET deleted_book_title = OLD.title 
    WHERE book_id = OLD.id;
    
    UPDATE reviews 
    SET deleted_book_title = OLD.title 
    WHERE book_id = OLD.id;
    
    UPDATE ratings 
    SET deleted_book_title = OLD.title 
    WHERE book_id = OLD.id;
    
    RETURN OLD;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."track_book_deletion"() OWNER TO "postgres";

-- ----------------------------
-- Function structure for update_book_in_library
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_book_in_library"("p_user_id" int4, "p_book_id" int4, "p_shelf" text, "p_rating" int4, "p_date_read" timestamp, "p_notes" text);
CREATE FUNCTION "public"."update_book_in_library"("p_user_id" int4, "p_book_id" int4, "p_shelf" text=NULL::text, "p_rating" int4=NULL::integer, "p_date_read" timestamp=NULL::timestamp without time zone, "p_notes" text=NULL::text)
  RETURNS "pg_catalog"."bool" AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."update_book_in_library"("p_user_id" int4, "p_book_id" int4, "p_shelf" text, "p_rating" int4, "p_date_read" timestamp, "p_notes" text) OWNER TO "postgres";

-- ----------------------------
-- Function structure for update_reading_goal
-- ----------------------------
DROP FUNCTION IF EXISTS "public"."update_reading_goal"("p_user_id" int4, "p_goal" int4);
CREATE FUNCTION "public"."update_reading_goal"("p_user_id" int4, "p_goal" int4)
  RETURNS "pg_catalog"."int4" AS $BODY$
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
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "public"."update_reading_goal"("p_user_id" int4, "p_goal" int4) OWNER TO "postgres";

-- ----------------------------
-- View structure for user_activation_status
-- ----------------------------
DROP VIEW IF EXISTS "public"."user_activation_status";
CREATE VIEW "public"."user_activation_status" AS  SELECT u.id,
    u.username,
    u.email,
    u.first_name,
    u.last_name,
    u.is_active,
    u.deactivation_reason,
    u.deactivated_at,
    u.deactivation_duration_days,
    u.auto_reactivate_at,
    moderator.username AS deactivated_by_username,
        CASE
            WHEN u.is_active = false AND u.auto_reactivate_at IS NOT NULL THEN
            CASE
                WHEN u.auto_reactivate_at > CURRENT_TIMESTAMP THEN EXTRACT(days FROM u.auto_reactivate_at::timestamp with time zone - CURRENT_TIMESTAMP)::integer
                ELSE 0
            END
            ELSE NULL::integer
        END AS days_until_reactivation,
    u.created_at AS user_created_at
   FROM users u
     LEFT JOIN users moderator ON u.deactivated_by = moderator.id;
ALTER TABLE "public"."user_activation_status" OWNER TO "postgres";

-- ----------------------------
-- View structure for content_gaps
-- ----------------------------
DROP VIEW IF EXISTS "public"."content_gaps";
CREATE VIEW "public"."content_gaps" AS  SELECT 'authors'::text AS content_type,
    fs.normalized_term AS normalized_search,
    array_agg(DISTINCT fs.missing_term ORDER BY fs.missing_term) AS search_variations,
    count(*) AS search_count,
    count(DISTINCT sq.user_id) AS user_count,
    min(fs.created_at) AS first_searched,
    max(fs.created_at) AS last_searched
   FROM failed_searches fs
     JOIN search_queries sq ON fs.search_query_id = sq.id
  WHERE fs.search_category::text = 'authors'::text
  GROUP BY fs.normalized_term
UNION ALL
 SELECT 'books'::text AS content_type,
    fs.normalized_term AS normalized_search,
    array_agg(DISTINCT fs.missing_term ORDER BY fs.missing_term) AS search_variations,
    count(*) AS search_count,
    count(DISTINCT sq.user_id) AS user_count,
    min(fs.created_at) AS first_searched,
    max(fs.created_at) AS last_searched
   FROM failed_searches fs
     JOIN search_queries sq ON fs.search_query_id = sq.id
  WHERE fs.search_category::text = 'books'::text
  GROUP BY fs.normalized_term
UNION ALL
 SELECT 'genres'::text AS content_type,
    fs.normalized_term AS normalized_search,
    array_agg(DISTINCT fs.missing_term ORDER BY fs.missing_term) AS search_variations,
    count(*) AS search_count,
    count(DISTINCT sq.user_id) AS user_count,
    min(fs.created_at) AS first_searched,
    max(fs.created_at) AS last_searched
   FROM failed_searches fs
     JOIN search_queries sq ON fs.search_query_id = sq.id
  WHERE fs.search_category::text = 'genres'::text
  GROUP BY fs.normalized_term
UNION ALL
 SELECT 'languages'::text AS content_type,
    fs.normalized_term AS normalized_search,
    array_agg(DISTINCT fs.missing_term ORDER BY fs.missing_term) AS search_variations,
    count(*) AS search_count,
    count(DISTINCT sq.user_id) AS user_count,
    min(fs.created_at) AS first_searched,
    max(fs.created_at) AS last_searched
   FROM failed_searches fs
     JOIN search_queries sq ON fs.search_query_id = sq.id
  WHERE fs.search_category::text = 'languages'::text
  GROUP BY fs.normalized_term
UNION ALL
 SELECT 'publishers'::text AS content_type,
    fs.normalized_term AS normalized_search,
    array_agg(DISTINCT fs.missing_term ORDER BY fs.missing_term) AS search_variations,
    count(*) AS search_count,
    count(DISTINCT sq.user_id) AS user_count,
    min(fs.created_at) AS first_searched,
    max(fs.created_at) AS last_searched
   FROM failed_searches fs
     JOIN search_queries sq ON fs.search_query_id = sq.id
  WHERE fs.search_category::text = 'publishers'::text
  GROUP BY fs.normalized_term
  ORDER BY 4 DESC, 2;
ALTER TABLE "public"."content_gaps" OWNER TO "postgres";

-- ----------------------------
-- View structure for missing_authors_analysis
-- ----------------------------
DROP VIEW IF EXISTS "public"."missing_authors_analysis";
CREATE VIEW "public"."missing_authors_analysis" AS  SELECT fs.normalized_term AS normalized_author,
    array_agg(DISTINCT fs.missing_term ORDER BY fs.missing_term) AS search_variations,
    count(*) AS total_searches,
    count(DISTINCT sq.user_id) AS unique_users,
    min(fs.created_at) AS first_searched,
    max(fs.created_at) AS last_searched
   FROM failed_searches fs
     JOIN search_queries sq ON fs.search_query_id = sq.id
  WHERE fs.search_category::text = 'authors'::text
  GROUP BY fs.normalized_term
  ORDER BY (count(*)) DESC, fs.normalized_term;
ALTER TABLE "public"."missing_authors_analysis" OWNER TO "postgres";

-- ----------------------------
-- View structure for missing_books_analysis
-- ----------------------------
DROP VIEW IF EXISTS "public"."missing_books_analysis";
CREATE VIEW "public"."missing_books_analysis" AS  SELECT fs.normalized_term AS normalized_book,
    array_agg(DISTINCT fs.missing_term ORDER BY fs.missing_term) AS search_variations,
    count(*) AS total_searches,
    count(DISTINCT sq.user_id) AS unique_users,
    min(fs.created_at) AS first_searched,
    max(fs.created_at) AS last_searched
   FROM failed_searches fs
     JOIN search_queries sq ON fs.search_query_id = sq.id
  WHERE fs.search_category::text = 'books'::text
  GROUP BY fs.normalized_term
  ORDER BY (count(*)) DESC, fs.normalized_term;
ALTER TABLE "public"."missing_books_analysis" OWNER TO "postgres";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."authors_id_seq"
OWNED BY "public"."authors"."id";
SELECT setval('"public"."authors_id_seq"', 8430, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."book_character_appearances_id_seq"
OWNED BY "public"."book_character_appearances"."id";
SELECT setval('"public"."book_character_appearances_id_seq"', 4316, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."book_deletion_log_id_seq"
OWNED BY "public"."book_deletion_log"."id";
SELECT setval('"public"."book_deletion_log_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."book_genres_id_seq"
OWNED BY "public"."book_genres"."id";
SELECT setval('"public"."book_genres_id_seq"', 25123, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."book_suggestions_id_seq"
OWNED BY "public"."book_suggestions"."id";
SELECT setval('"public"."book_suggestions_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."books_id_seq"
OWNED BY "public"."books"."id";
SELECT setval('"public"."books_id_seq"', 7833, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."characters_id_seq"
OWNED BY "public"."characters"."id";
SELECT setval('"public"."characters_id_seq"', 3712, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."comments_id_seq"
OWNED BY "public"."comments"."id";
SELECT setval('"public"."comments_id_seq"', 341, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."failed_searches_id_seq"
OWNED BY "public"."failed_searches"."id";
SELECT setval('"public"."failed_searches_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."genres_id_seq"
OWNED BY "public"."genres"."id";
SELECT setval('"public"."genres_id_seq"', 1414, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."languages_id_seq"
OWNED BY "public"."languages"."id";
SELECT setval('"public"."languages_id_seq"', 49, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."login_history_id_seq"
OWNED BY "public"."login_history"."id";
SELECT setval('"public"."login_history_id_seq"', 14, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."publication_houses_id_seq"
OWNED BY "public"."publication_houses"."id";
SELECT setval('"public"."publication_houses_id_seq"', 3499, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."ratings_id_seq"
OWNED BY "public"."ratings"."id";
SELECT setval('"public"."ratings_id_seq"', 14, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."reviews_id_seq"
OWNED BY "public"."reviews"."id";
SELECT setval('"public"."reviews_id_seq"', 139, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."search_queries_id_seq"
OWNED BY "public"."search_queries"."id";
SELECT setval('"public"."search_queries_id_seq"', 10, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."user_books_id_seq"
OWNED BY "public"."user_books"."id";
SELECT setval('"public"."user_books_id_seq"', 80, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."user_deactivation_history_id_seq"
OWNED BY "public"."user_deactivation_history"."id";
SELECT setval('"public"."user_deactivation_history_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."users_id_seq"
OWNED BY "public"."users"."id";
SELECT setval('"public"."users_id_seq"', 21, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."votes_id_seq"
OWNED BY "public"."votes"."id";
SELECT setval('"public"."votes_id_seq"', 606, true);

-- ----------------------------
-- Primary Key structure for table authors
-- ----------------------------
ALTER TABLE "public"."authors" ADD CONSTRAINT "authors_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table book_authors
-- ----------------------------
CREATE INDEX "idx_book_authors_book_id" ON "public"."book_authors" USING btree (
  "book_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table book_authors
-- ----------------------------
ALTER TABLE "public"."book_authors" ADD CONSTRAINT "book_authors_pkey" PRIMARY KEY ("book_id", "author_id");

-- ----------------------------
-- Indexes structure for table book_character_appearances
-- ----------------------------
CREATE INDEX "idx_book_character_appearances_book_id" ON "public"."book_character_appearances" USING btree (
  "book_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_book_character_appearances_character_id" ON "public"."book_character_appearances" USING btree (
  "character_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table book_character_appearances
-- ----------------------------
ALTER TABLE "public"."book_character_appearances" ADD CONSTRAINT "book_character_appearances_book_id_character_id_key" UNIQUE ("book_id", "character_id");

-- ----------------------------
-- Primary Key structure for table book_character_appearances
-- ----------------------------
ALTER TABLE "public"."book_character_appearances" ADD CONSTRAINT "book_character_appearances_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table book_deletion_log
-- ----------------------------
CREATE INDEX "idx_book_deletion_log_book_id" ON "public"."book_deletion_log" USING btree (
  "book_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_book_deletion_log_deleted_at" ON "public"."book_deletion_log" USING btree (
  "deleted_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table book_deletion_log
-- ----------------------------
ALTER TABLE "public"."book_deletion_log" ADD CONSTRAINT "book_deletion_log_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table book_genres
-- ----------------------------
CREATE INDEX "idx_book_genres_book_id" ON "public"."book_genres" USING btree (
  "book_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_book_genres_genre_id" ON "public"."book_genres" USING btree (
  "genre_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table book_genres
-- ----------------------------
ALTER TABLE "public"."book_genres" ADD CONSTRAINT "book_genres_book_id_genre_id_key" UNIQUE ("book_id", "genre_id");

-- ----------------------------
-- Primary Key structure for table book_genres
-- ----------------------------
ALTER TABLE "public"."book_genres" ADD CONSTRAINT "book_genres_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Checks structure for table book_suggestions
-- ----------------------------
ALTER TABLE "public"."book_suggestions" ADD CONSTRAINT "book_suggestions_approved_check" CHECK (approved = ANY (ARRAY['0'::bpchar, '1'::bpchar]));

-- ----------------------------
-- Primary Key structure for table book_suggestions
-- ----------------------------
ALTER TABLE "public"."book_suggestions" ADD CONSTRAINT "book_suggestions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table books
-- ----------------------------
CREATE INDEX "idx_books_creator" ON "public"."books" USING btree (
  "added_by" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table books
-- ----------------------------
CREATE TRIGGER "book_deletion_trigger" BEFORE DELETE ON "public"."books"
FOR EACH ROW
EXECUTE PROCEDURE "public"."track_book_deletion"();

-- ----------------------------
-- Primary Key structure for table books
-- ----------------------------
ALTER TABLE "public"."books" ADD CONSTRAINT "books_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table characters
-- ----------------------------
CREATE INDEX "idx_characters_name" ON "public"."characters" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table characters
-- ----------------------------
ALTER TABLE "public"."characters" ADD CONSTRAINT "characters_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table comments
-- ----------------------------
CREATE INDEX "idx_comments_review_created" ON "public"."comments" USING btree (
  "review_id" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "created_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table comments
-- ----------------------------
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table failed_searches
-- ----------------------------
CREATE INDEX "idx_failed_searches_category" ON "public"."failed_searches" USING btree (
  "search_category" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_failed_searches_normalized" ON "public"."failed_searches" USING btree (
  "normalized_term" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_failed_searches_timestamp" ON "public"."failed_searches" USING btree (
  "created_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table failed_searches
-- ----------------------------
ALTER TABLE "public"."failed_searches" ADD CONSTRAINT "failed_searches_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table genres
-- ----------------------------
ALTER TABLE "public"."genres" ADD CONSTRAINT "genres_name_key" UNIQUE ("name");

-- ----------------------------
-- Primary Key structure for table genres
-- ----------------------------
ALTER TABLE "public"."genres" ADD CONSTRAINT "genres_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table languages
-- ----------------------------
ALTER TABLE "public"."languages" ADD CONSTRAINT "languages_iso_code_key" UNIQUE ("iso_code");

-- ----------------------------
-- Primary Key structure for table languages
-- ----------------------------
ALTER TABLE "public"."languages" ADD CONSTRAINT "languages_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table login_history
-- ----------------------------
CREATE INDEX "idx_login_history_user" ON "public"."login_history" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_login_history_user_logout" ON "public"."login_history" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "logout_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table login_history
-- ----------------------------
ALTER TABLE "public"."login_history" ADD CONSTRAINT "login_history_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table moderator_accounts
-- ----------------------------
ALTER TABLE "public"."moderator_accounts" ADD CONSTRAINT "moderator_accounts_pkey" PRIMARY KEY ("user_id");

-- ----------------------------
-- Primary Key structure for table publication_houses
-- ----------------------------
ALTER TABLE "public"."publication_houses" ADD CONSTRAINT "publication_houses_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table ratings
-- ----------------------------
CREATE INDEX "idx_ratings_book" ON "public"."ratings" USING btree (
  "book_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_ratings_deleted_title" ON "public"."ratings" USING btree (
  "deleted_book_title" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_book_title IS NOT NULL;
CREATE INDEX "idx_ratings_user_id" ON "public"."ratings" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table ratings
-- ----------------------------
ALTER TABLE "public"."ratings" ADD CONSTRAINT "unique_user_book_rating" UNIQUE ("user_id", "book_id");

-- ----------------------------
-- Checks structure for table ratings
-- ----------------------------
ALTER TABLE "public"."ratings" ADD CONSTRAINT "ratings_value_check" CHECK (value >= 1 AND value <= 5);

-- ----------------------------
-- Primary Key structure for table ratings
-- ----------------------------
ALTER TABLE "public"."ratings" ADD CONSTRAINT "ratings_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table reviews
-- ----------------------------
CREATE INDEX "idx_reviews_book" ON "public"."reviews" USING btree (
  "book_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_reviews_deleted_title" ON "public"."reviews" USING btree (
  "deleted_book_title" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_book_title IS NOT NULL;

-- ----------------------------
-- Checks structure for table reviews
-- ----------------------------
ALTER TABLE "public"."reviews" ADD CONSTRAINT "reviews_rating_check" CHECK (rating >= 1 AND rating <= 5);

-- ----------------------------
-- Primary Key structure for table reviews
-- ----------------------------
ALTER TABLE "public"."reviews" ADD CONSTRAINT "reviews_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table search_queries
-- ----------------------------
CREATE INDEX "idx_search_queries_normalized" ON "public"."search_queries" USING btree (
  "normalized_query" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_search_queries_result_count" ON "public"."search_queries" USING btree (
  "result_count" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_search_queries_timestamp" ON "public"."search_queries" USING btree (
  "search_timestamp" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_search_queries_user_id" ON "public"."search_queries" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table search_queries
-- ----------------------------
ALTER TABLE "public"."search_queries" ADD CONSTRAINT "search_queries_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table user_accounts
-- ----------------------------
ALTER TABLE "public"."user_accounts" ADD CONSTRAINT "user_accounts_pkey" PRIMARY KEY ("user_id");

-- ----------------------------
-- Indexes structure for table user_books
-- ----------------------------
CREATE INDEX "idx_user_books_book" ON "public"."user_books" USING btree (
  "book_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_books_date_added" ON "public"."user_books" USING btree (
  "date_added" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_books_deleted_title" ON "public"."user_books" USING btree (
  "deleted_book_title" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
) WHERE deleted_book_title IS NOT NULL;
CREATE INDEX "idx_user_books_shelf" ON "public"."user_books" USING btree (
  "shelf" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_books_user" ON "public"."user_books" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_books_user_date_read" ON "public"."user_books" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "date_read" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_user_books_user_shelf" ON "public"."user_books" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST,
  "shelf" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table user_books
-- ----------------------------
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_user_id_book_id_key" UNIQUE ("user_id", "book_id");

-- ----------------------------
-- Checks structure for table user_books
-- ----------------------------
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_shelf_check" CHECK (shelf::text = ANY (ARRAY['want-to-read'::character varying::text, 'currently-reading'::character varying::text, 'read'::character varying::text]));

-- ----------------------------
-- Primary Key structure for table user_books
-- ----------------------------
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table user_deactivation_history
-- ----------------------------
CREATE INDEX "idx_deactivation_history_created_at" ON "public"."user_deactivation_history" USING btree (
  "created_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_deactivation_history_moderator_id" ON "public"."user_deactivation_history" USING btree (
  "moderator_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "idx_deactivation_history_user_id" ON "public"."user_deactivation_history" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table user_deactivation_history
-- ----------------------------
ALTER TABLE "public"."user_deactivation_history" ADD CONSTRAINT "user_deactivation_history_action_check" CHECK (action::text = ANY (ARRAY['deactivate'::character varying, 'reactivate'::character varying]::text[]));

-- ----------------------------
-- Primary Key structure for table user_deactivation_history
-- ----------------------------
ALTER TABLE "public"."user_deactivation_history" ADD CONSTRAINT "user_deactivation_history_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table users
-- ----------------------------
CREATE INDEX "idx_users_auto_reactivate" ON "public"."users" USING btree (
  "auto_reactivate_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST
) WHERE auto_reactivate_at IS NOT NULL;
CREATE INDEX "idx_users_is_active" ON "public"."users" USING btree (
  "is_active" "pg_catalog"."bool_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_email_key" UNIQUE ("email");
ALTER TABLE "public"."users" ADD CONSTRAINT "users_username_key" UNIQUE ("username");

-- ----------------------------
-- Checks structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_reading_goal_check" CHECK (reading_goal >= 1 AND reading_goal <= 1000);

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table votes
-- ----------------------------
CREATE INDEX "idx_votes_user" ON "public"."votes" USING btree (
  "user_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Checks structure for table votes
-- ----------------------------
ALTER TABLE "public"."votes" ADD CONSTRAINT "votes_vote_type_check" CHECK (vote_type::text = ANY (ARRAY['up'::character varying::text, 'down'::character varying::text]));
ALTER TABLE "public"."votes" ADD CONSTRAINT "vote_target_ck" CHECK (review_id IS NOT NULL AND comment_id IS NULL OR review_id IS NULL AND comment_id IS NOT NULL);

-- ----------------------------
-- Primary Key structure for table votes
-- ----------------------------
ALTER TABLE "public"."votes" ADD CONSTRAINT "votes_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table book_authors
-- ----------------------------
ALTER TABLE "public"."book_authors" ADD CONSTRAINT "book_authors_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "public"."authors" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."book_authors" ADD CONSTRAINT "book_authors_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table book_character_appearances
-- ----------------------------
ALTER TABLE "public"."book_character_appearances" ADD CONSTRAINT "book_character_appearances_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."book_character_appearances" ADD CONSTRAINT "book_character_appearances_character_id_fkey" FOREIGN KEY ("character_id") REFERENCES "public"."characters" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table book_deletion_log
-- ----------------------------
ALTER TABLE "public"."book_deletion_log" ADD CONSTRAINT "book_deletion_log_deleted_by_fkey" FOREIGN KEY ("deleted_by") REFERENCES "public"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table book_genres
-- ----------------------------
ALTER TABLE "public"."book_genres" ADD CONSTRAINT "book_genres_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."book_genres" ADD CONSTRAINT "book_genres_genre_id_fkey" FOREIGN KEY ("genre_id") REFERENCES "public"."genres" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table book_suggestions
-- ----------------------------
ALTER TABLE "public"."book_suggestions" ADD CONSTRAINT "book_suggestions_approved_by_fkey" FOREIGN KEY ("approved_by") REFERENCES "public"."moderator_accounts" ("user_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."book_suggestions" ADD CONSTRAINT "book_suggestions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."user_accounts" ("user_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table books
-- ----------------------------
ALTER TABLE "public"."books" ADD CONSTRAINT "books_created_by_fkey" FOREIGN KEY ("added_by") REFERENCES "public"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."books" ADD CONSTRAINT "books_language_id_fkey" FOREIGN KEY ("language_id") REFERENCES "public"."languages" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."books" ADD CONSTRAINT "books_publication_house_id_fkey" FOREIGN KEY ("publication_house_id") REFERENCES "public"."publication_houses" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table comments
-- ----------------------------
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_parent_comment_id_fkey" FOREIGN KEY ("parent_comment_id") REFERENCES "public"."comments" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_review_id_fkey" FOREIGN KEY ("review_id") REFERENCES "public"."reviews" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."comments" ADD CONSTRAINT "comments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table failed_searches
-- ----------------------------
ALTER TABLE "public"."failed_searches" ADD CONSTRAINT "failed_searches_search_query_id_fkey" FOREIGN KEY ("search_query_id") REFERENCES "public"."search_queries" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table login_history
-- ----------------------------
ALTER TABLE "public"."login_history" ADD CONSTRAINT "login_history_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table moderator_accounts
-- ----------------------------
ALTER TABLE "public"."moderator_accounts" ADD CONSTRAINT "moderator_accounts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table ratings
-- ----------------------------
ALTER TABLE "public"."ratings" ADD CONSTRAINT "ratings_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE "public"."ratings" ADD CONSTRAINT "ratings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table reviews
-- ----------------------------
ALTER TABLE "public"."reviews" ADD CONSTRAINT "reviews_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE "public"."reviews" ADD CONSTRAINT "reviews_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table search_queries
-- ----------------------------
ALTER TABLE "public"."search_queries" ADD CONSTRAINT "search_queries_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table user_accounts
-- ----------------------------
ALTER TABLE "public"."user_accounts" ADD CONSTRAINT "user_accounts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table user_books
-- ----------------------------
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."books" ("id") ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_review_id_fkey" FOREIGN KEY ("review_id") REFERENCES "public"."reviews" ("id") ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE "public"."user_books" ADD CONSTRAINT "user_books_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table user_deactivation_history
-- ----------------------------
ALTER TABLE "public"."user_deactivation_history" ADD CONSTRAINT "user_deactivation_history_moderator_id_fkey" FOREIGN KEY ("moderator_id") REFERENCES "public"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."user_deactivation_history" ADD CONSTRAINT "user_deactivation_history_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table users
-- ----------------------------
ALTER TABLE "public"."users" ADD CONSTRAINT "users_deactivated_by_fkey" FOREIGN KEY ("deactivated_by") REFERENCES "public"."users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table votes
-- ----------------------------
ALTER TABLE "public"."votes" ADD CONSTRAINT "votes_comment_id_fkey" FOREIGN KEY ("comment_id") REFERENCES "public"."comments" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."votes" ADD CONSTRAINT "votes_review_id_fkey" FOREIGN KEY ("review_id") REFERENCES "public"."reviews" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."votes" ADD CONSTRAINT "votes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
