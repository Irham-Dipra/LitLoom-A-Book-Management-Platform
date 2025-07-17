# Database Changes Summary

## Updated SQL Files - $(date)

### Changes Made:

1. **user_books table modifications:**
   - Removed `user_rating` column (previously dropped)
   - Maintained `shelf` column with NOT NULL constraint and default value 'want-to-read'
   - Ratings now stored exclusively in separate `ratings` table

2. **Rating System Updates:**
   - All user ratings now stored in `ratings` table
   - `user_books.user_rating` column completely removed
   - Backend queries updated to fetch ratings from `ratings` table via JOIN

3. **Author Functionality:**
   - Added comprehensive author routes (`/authors/:id`)
   - Backend queries now include `author_id` for clickable author names
   - Author page displays author bio, image, and all their books

4. **Key Schema Features:**
   - `ratings` table: Stores user ratings (1-5 stars) with constraints
   - `user_books` table: Tracks user's library without rating data
   - `authors` table: Includes author images and biography
   - Many-to-many relationships: books ↔ authors, books ↔ genres

### Files Updated:

- `litloom_schema_only_current.sql` - Updated schema without data
- `litloom_complete_with_data.sql` - Complete backup with all data
- `litloom_schema_updated.sql` - New schema file (same as current)
- `litloom_complete_with_data_updated.sql` - New complete backup

### Database Structure:

**Core Tables:**
- `books` - Book information
- `authors` - Author information with bio and image
- `users` - User accounts
- `ratings` - User ratings for books (1-5 stars)
- `user_books` - User's library/shelves
- `reviews` - Book reviews

**Relationship Tables:**
- `book_authors` - Books to authors mapping
- `book_genres` - Books to genres mapping
- `book_character_appearances` - Books to characters mapping

**Key Changes from Previous Version:**
- Removed `user_rating` column from `user_books` table
- All ratings now in dedicated `ratings` table
- Author functionality fully implemented
- Backend queries optimized for rating system

### Usage:

To restore from schema only:
```bash
psql -U postgres -d litloom < litloom_schema_only_current.sql
```

To restore complete database with data:
```bash
psql -U postgres -d litloom < litloom_complete_with_data.sql
```