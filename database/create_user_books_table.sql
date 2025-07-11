-- Create user_books table for tracking user reading progress
CREATE TABLE user_books (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    book_id INTEGER NOT NULL REFERENCES books(id) ON DELETE CASCADE,
    shelf VARCHAR(50) NOT NULL DEFAULT 'want-to-read' CHECK (shelf IN ('want-to-read', 'currently-reading', 'read')),
    user_rating INTEGER CHECK (user_rating BETWEEN 1 AND 5),
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    date_read TIMESTAMP,
    review_id INTEGER REFERENCES reviews(id) ON DELETE SET NULL,
    notes TEXT,
    UNIQUE(user_id, book_id)
);

-- Create indexes for better performance
CREATE INDEX idx_user_books_user ON user_books(user_id);
CREATE INDEX idx_user_books_book ON user_books(book_id);
CREATE INDEX idx_user_books_shelf ON user_books(shelf);
CREATE INDEX idx_user_books_date_added ON user_books(date_added);