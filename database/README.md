# LitLoom Database

This folder contains the PostgreSQL database dumps for the LitLoom application.

## Files

- `litloom_schema_only.sql` - Database schema without data
- `litloom_with_data.sql` - Complete database with all data

## Usage

### Restore schema only:
```bash
psql -U postgres -d litloom < litloom_schema_only.sql
```

### Restore complete database with data:
```bash
psql -U postgres -d litloom < litloom_with_data.sql
```

## Database Structure

The database includes:
- User management (users, authentication)
- Book catalog (books, authors, genres, languages)
- User interactions (ratings, reviews, user libraries)
- Many-to-many relationships for books-authors, books-genres

## Key Features

- **Ratings System**: User ratings stored in separate `ratings` table
- **User Libraries**: Books organized in user shelves (want-to-read, currently-reading, read)
- **Author Support**: Full author profiles with bio and images
- **Comprehensive Book Data**: Includes publication info, covers, descriptions