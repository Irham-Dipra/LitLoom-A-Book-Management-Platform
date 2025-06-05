-- USERS
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    is_approved CHAR(1) DEFAULT '0' CHECK (is_approved IN ('0', '1')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    profile_picture_url VARCHAR(500) NOT NULL,
    bio TEXT
);

-- USER ROLES
CREATE TABLE user_accounts (
    user_id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE moderator_accounts (
    user_id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE guest_accounts (
    user_id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE
);

-- LOGIN HISTORY
CREATE TABLE login_history (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    login_time TIMESTAMP NOT NULL,
    ip_address VARCHAR(45) NOT NULL
);

CREATE INDEX idx_login_history_user ON login_history(user_id);

-- GENRES
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- LANGUAGES
CREATE TABLE languages (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    iso_code VARCHAR(10) UNIQUE NOT NULL
);

-- PUBLICATION HOUSES
CREATE TABLE publication_houses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(500) NOT NULL,
    country VARCHAR(100) NOT NULL,
    contact_email VARCHAR(255) NOT NULL
);

-- BOOKS
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    publication_date DATE NOT NULL,
    cover_image VARCHAR(500) NOT NULL,
    original_country VARCHAR(100) NOT NULL,
    language_id INTEGER NOT NULL REFERENCES languages(id),
    genre_id INTEGER NOT NULL REFERENCES genres(id),
    publication_house_id INTEGER NOT NULL REFERENCES publication_houses(id),
    pdf_url VARCHAR(500) NOT NULL,
    average_rating NUMERIC(3,2) DEFAULT 0 NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX idx_books_creator ON books(created_by);

-- AUTHORS
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    bio TEXT,
    date_of_birth DATE NOT NULL,
    country VARCHAR(100) NOT NULL
);

-- BOOK-AUTHORS
CREATE TABLE book_authors (
    book_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE
);

-- CHARACTERS
CREATE TABLE book_characters (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    description TEXT,
    fictional_age INTEGER NOT NULL,
    gender VARCHAR(20) NOT NULL
);

-- CHARACTER APPEARANCES
CREATE TABLE book_character_appearances (
    book_id INTEGER NOT NULL,
    character_id INTEGER NOT NULL,
    PRIMARY KEY (book_id, character_id),
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (character_id) REFERENCES book_characters(id) ON DELETE CASCADE
);

-- WISHLISTS
CREATE TABLE wishlists (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES user_accounts(user_id) ON DELETE CASCADE,
    status VARCHAR(50) NOT NULL,
    added_at TIMESTAMP NOT NULL
);

-- WISHED BOOKS
CREATE TABLE wished_books (
    wishlist_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    PRIMARY KEY (wishlist_id, book_id),
    FOREIGN KEY (wishlist_id) REFERENCES wishlists(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

-- REVIEWS
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    book_id INTEGER NOT NULL REFERENCES books(id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    body TEXT,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_reviews_book ON reviews(book_id);

-- RATINGS
CREATE TABLE ratings (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    book_id INTEGER NOT NULL REFERENCES books(id) ON DELETE CASCADE,
    value INTEGER NOT NULL CHECK (value BETWEEN 1 AND 5),
    created_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_ratings_book ON ratings(book_id);

-- COMMENTS
CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    review_id INTEGER NOT NULL REFERENCES reviews(id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    body TEXT NOT NULL,
    parent_comment_id INTEGER REFERENCES comments(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_comments_review_created ON comments(review_id, created_at);

-- VOTES
CREATE TABLE votes (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    review_id INTEGER REFERENCES reviews(id) ON DELETE CASCADE,
    comment_id INTEGER REFERENCES comments(id) ON DELETE CASCADE,
    vote_type VARCHAR(10) NOT NULL CHECK (vote_type IN ('up', 'down')),
    created_at TIMESTAMP NOT NULL,
    CONSTRAINT vote_target_ck CHECK (
        (review_id IS NOT NULL AND comment_id IS NULL) OR
        (review_id IS NULL AND comment_id IS NOT NULL)
    )
);

CREATE INDEX idx_votes_user ON votes(user_id);

-- BOOK SUGGESTIONS
CREATE TABLE book_suggestions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES user_accounts(user_id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    author_name VARCHAR(255) NOT NULL,
    description TEXT,
    language VARCHAR(100) NOT NULL,
    genre VARCHAR(100) NOT NULL,
    submitted_at TIMESTAMP NOT NULL,
    approved CHAR(1) DEFAULT '0' NOT NULL CHECK (approved IN ('0', '1')),
    approved_by INTEGER NOT NULL REFERENCES moderator_accounts(user_id),
    approved_at TIMESTAMP NOT NULL
);

