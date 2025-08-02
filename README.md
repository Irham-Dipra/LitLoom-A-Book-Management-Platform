# 📚 Litloom - Your Digital Book Haven

[![React](https://img.shields.io/badge/React-19.1.0-blue.svg)](https://reactjs.org/)
[![Node.js](https://img.shields.io/badge/Node.js-Express-green.svg)](https://nodejs.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blue.svg)](https://postgresql.org/)


**Litloom** is a full-stack **book management and discovery platform** we built for **CSE 216: Database Sessional** (Level 2, Term 1).  
It’s designed for anyone who loves books — from casual readers to hardcore literature nerds.  

With Litloom, you can:  
- **Discover** new books and authors  
- **Track** your reading progress and library  
- **See** your personal reading statistics  
- **Review & Discuss** books with others  
- **Manage** the book catalog if you’re a moderator  

Our database contains **7,800+ books**, fetched from the **Hardcover API** with **complete metadata**:  
**Title**, **Description**, **Publication Date**, **Cover Image**, **Original Country**, **Genres**, **Language**, **Publisher**, **Average Rating**, **ISBN**, **Readers Count**, **Page Count**, **Characters**, and **Author Bios with Profile Pictures**.  

If it’s book-related, it’s here. 📖  

---

## ✨ Features

### 🔍 **Advanced Book Discovery & Search**
- **Smart Search Engine**: Search by title, author, genre, and description  
- **Real-time Search**: Instant results with debounced queries  
- **Advanced Filters**: Genre, language, publication year, rating, country  
- **Search Analytics**: Track search queries and see what’s missing  
- **Failed Search Tracking**: Log missing books/authors for improvements  
- **Trending Books**: See what’s popular in the community  

### 📚 **Personal Library Management**
- **Custom Shelves**: *Want to Read*, *Currently Reading*, *Read*  
- **Shelf Management**: Add, move, or remove books anytime  
- **Reading Progress**: Track start/completion dates and history  
- **Personal Ratings**: Rate on a **5-star scale** with rating history  
- **Reading Goals**: Set and track your yearly reading target  

### 📊 **Reading Statistics & Analytics**
- **Stats Dashboard**: Your personal reading insights  
- **Goal Progress**: Visual indicators for annual reading goals  
- **Genre Analysis**: See what genres you read most  
- **Author Stats**: Track favorite authors and trends  
- **Reading Streaks**: Months of consecutive reading  
- **Book Length Analysis**: Pages read, book size preferences  
- **Monthly Activity**: Books read & pages completed per month  
- **Rating Distribution**: Analyze your rating habits  

### 👥 **User Management & Profiles**
- **Secure Authentication**: JWT-based login, bcrypt password hashing  
- **User Profiles**: Bio, name, and profile picture customization  
- **Profile Statistics**: Show reading stats on profiles  
- **Activity Tracking**: Login/logout history and sessions  
- **Account Settings**: Update your info anytime  

### 🛡️ **Moderator Dashboard & Content Management**
- **Book Management**: Add, edit, or delete books  
- **User Management**: Activate/deactivate users with reason tracking  
- **Bulk Operations**: Manage multiple entries at once  
- **Book Addition Wizard**: Step-by-step book adding process  
- **Data Validation**: Checks for all metadata  
- **Deletion Tracking**: Full audit log for removed content  
- **Advanced Filtering**: For easy content management  

### 💬 **Community Features & Social Interaction**
- **Book Reviews**: Write reviews with titles and ratings  
- **Review Voting**: Upvote/downvote reviews  
- **Threaded Comments**: Replies and discussions  
- **Comment Voting**: Vote on individual comments/replies  
- **Community Browse**: Discover reviews from other users  
- **User Interactions**: View profiles and reading activity  

### 📖 **Comprehensive Book Information**
- **Full Metadata**: ISBN, pages, publisher, etc.  
- **Author Info**: Bios and images  
- **Multiple Genres**: Support for more than one genre per book  
- **Character Tracking**: See characters and their appearances  
- **Ratings**: Average + your personal rating  
- **Cover Gallery**: High-quality cover images  

### 🔐 **Security & Data Protection**
- **JWT Authentication**: Token-based secure login  
- **Password Security**: bcrypt with salts  
- **Role-Based Access**: User vs. moderator permissions  
- **Session Management**: Secure login/logout  
- **Server-Side Validation**: For all inputs  
- **SQL Injection Protection**: Parameterized queries  

### 🎨 **Modern User Experience**
- **Responsive Design**: Works on all devices  
- **Dark Theme**: Perfect for late-night reading  
- **Smooth Animations**: Polished transitions and effects  
- **Loading States**: User-friendly loading indicators  
- **Error Handling**: Clear, helpful error messages  
- **Performance Optimization**: Fast data fetching and loading

## 🛠 Tech Stack

### **Frontend**
- **React 19.1.0** - Modern UI library with hooks and functional components
- **React Router DOM 7.6.2** - Client-side routing and navigation
- **React Icons 5.5.0** - Comprehensive icon library
- **React Select 11.1.8** - Enhanced dropdown components
- **CSS3** - Custom styling with animations and responsive design

### **Backend**
- **Node.js** - JavaScript runtime environment
- **Express.js 5.1.0** - Web application framework
- **PostgreSQL** - Relational database management system
- **JSON Web Tokens (JWT)** - Secure authentication
- **bcryptjs 3.0.2** - Password hashing and security
- **Express Validator 7.2.1** - Input validation and sanitization

### **Database**
- **PostgreSQL** - Primary database with complex relational schema
- **pg 8.16.0** - PostgreSQL client for Node.js
- **Advanced Functions**: Stored procedures for complex operations
- **Triggers**: Automated data tracking and validation
- **Views**: Pre-computed analytics and reporting
- **Indexes**: Optimized query performance

### **Development Tools**
- **dotenv 16.5.0** - Environment variable management
- **CORS 2.8.5** - Cross-origin resource sharing
- **Nodemon 3.1.10** - Development server with auto-restart

## 🚀 Getting Started

### Prerequisites

Before running Litloom, ensure you have the following installed:

- **Node.js** (v16.0.0 or higher)
- **npm** (v7.0.0 or higher)
- **PostgreSQL** (v12.0 or higher)
- **Git** (for cloning the repository)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Irham-Dipra/LitLoom.git
   cd LitLoom
   ```

2. **Install backend dependencies**
   ```bash
   cd backend
   npm install
   ```

3. **Install frontend dependencies**
   ```bash
   cd ../frontend/myapp
   npm install
   ```

### Database Setup

1. **Create PostgreSQL Database**
   ```bash
   # Connect to PostgreSQL
   psql -U postgres
   
   # Create database
   CREATE DATABASE litloom;
   
   # Exit psql
   \q
   ```

2. **Import Complete Database with Data**
   ```bash
   # From the project root directory
   psql -U postgres -d litloom < database/litloom_with_data.sql
   ```

   **Or import schema only:**
   ```bash
   psql -U postgres -d litloom < database/litloom_schema_only.sql
   ```

### Environment Configuration

1. **Create backend environment file**
   ```bash
   cd backend
   cp .env.example .env
   ```

2. **Configure environment variables**
   ```env
   # Database Configuration
   DB_USER=postgres
   DB_HOST=localhost
   DB_NAME=litloom
   DB_PASSWORD=your_password
   DB_PORT=5432
   
   # JWT Configuration
   JWT_SECRET=your-super-secret-jwt-key-here-make-it-long-and-random
   ```

### Running the Application

1. **Start the backend server**
   ```bash
   cd backend
   node index.js
   # Server will run on http://localhost:3000
   ```

2. **Start the frontend development server**
   ```bash
   cd frontend/myapp
   npm start
   # Application will open at http://localhost:3001
   ```

3. **Access the application**
   - Open your browser and navigate to `http://localhost:3001`
   - Create a new account or use existing credentials
   - Start exploring books and building your library!

### Default Accounts

The database includes sample accounts:
- **Regular User**: Username with sample library and reviews
- **Moderator**: Admin access to management features

## 📁 Project Structure

```
LitLoom/
├── backend/                    # Node.js/Express backend
│   ├── controllers/            # Business logic controllers
│   │   ├── authController.js   # Authentication logic
│   │   ├── booksController.js  # Book management
│   │   ├── usersController.js  # User management
│   │   └── reviewsController.js # Review system
│   ├── db/                     # Database connection
│   │   └── index.js            # PostgreSQL connection pool
│   ├── routes/                 # API route definitions
│   │   ├── auth.js             # Authentication routes
│   │   ├── books.js            # Book-related routes
│   │   ├── myBooks.js          # Personal library routes
│   │   ├── reviews.js          # Review system routes
│   │   ├── search.js           # Search functionality
│   │   ├── users.js            # User management
│   │   ├── moderator.js        # Moderator dashboard
│   │   └── addBook.js          # Book addition wizard
│   ├── .env                    # Environment variables
│   ├── index.js                # Main server file
│   └── package.json            # Backend dependencies
├── frontend/myapp/             # React frontend
│   ├── public/                 # Static assets
│   ├── src/
│   │   ├── components/         # Reusable React components
│   │   │   ├── Navbar.js       # Navigation component
│   │   │   ├── Review.js       # Review display component
│   │   │   ├── FilterSidebar.js # Search filters
│   │   │   └── ModeratorBooks.js # Book management
│   │   ├── pages/              # Page components
│   │   │   ├── Home.js         # Homepage
│   │   │   ├── Search.js       # Search results page
│   │   │   ├── IndividualBook.js # Book details page
│   │   │   ├── MyBooks.js      # Personal library
│   │   │   ├── Profile.js      # User profile
│   │   │   ├── ReadingStats.js # Reading analytics
│   │   │   ├── Browse.js       # Community reviews
│   │   │   ├── AddBook.js      # Book addition wizard
│   │   │   └── ModeratorDashboard.js # Admin panel
│   │   ├── contexts/           # React Context providers
│   │   │   └── FilterContext.js # Filter state management
│   │   ├── App.js              # Main application component
│   │   └── index.js            # Application entry point
│   └── package.json            # Frontend dependencies
├── api-integrations/           # External API integration
│   └── proper-books-integration.js # Hardcover API import
├── database/                   # Database schema and data
│   ├── litloom_schema_only.sql # Database structure
│   ├── litloom_with_data.sql   # Complete database with data
│   ├── public.sql              # Full schema export
│   └── README.md               # Database documentation
└── README.md                   # Project documentation
```

## 🗄 Database Schema

The Litloom database consists of 23 tables with comprehensive relationships:

### **Core Entities**
- **users** - User accounts, profiles, and settings
- **books** - Book catalog with complete metadata
- **authors** - Author information and biographies
- **genres** - Book categorization system
- **languages** - Supported languages with ISO codes
- **publication_houses** - Publisher information
- **characters** - Book character database

### **Relationship Tables**
- **book_authors** - Many-to-many: books ↔ authors
- **book_genres** - Many-to-many: books ↔ genres
- **book_character_appearances** - Many-to-many: books ↔ characters

### **User Interaction**
- **user_books** - Personal library management
- **ratings** - User book ratings (1-5 stars)
- **reviews** - User reviews with title and body
- **comments** - Threaded comments on reviews
- **votes** - Voting system for reviews and comments

### **System Management**
- **login_history** - User session tracking
- **search_queries** - Search analytics and tracking
- **failed_searches** - Content gap identification
- **book_deletion_log** - Audit trail for deleted content
- **user_deactivation_history** - User management tracking
- **book_suggestions** - User-submitted book requests

### **Access Control**
- **user_accounts** - Regular user designation
- **moderator_accounts** - Moderator role assignment

### **Advanced Features**
- **45+ Database Functions** - Complex business logic in PostgreSQL
- **Triggers** - Automated data tracking and validation
- **Views** - Pre-computed analytics (content_gaps, user_activation_status)
- **Indexes** - Optimized query performance
- **Constraints** - Data integrity and validation

## 🔧 API Endpoints

### **Authentication**
- `POST /auth/register` - User registration
- `POST /auth/login` - User login
- `POST /auth/logout` - User logout

### **Books**
- `GET /books` - Browse books with filters
- `GET /books/:id` - Individual book details
- `GET /search` - Advanced search functionality

### **Personal Library (myBooks)**
- `GET /myBooks/books` - User's library with filtering and sorting
- `GET /myBooks/rated-books` - User's rated books with pagination
- `GET /myBooks/shelves` - User's shelf counts and statistics
- `POST /myBooks/books` - Add book to library
- `PUT /myBooks/books/:id` - Update book shelf/rating/notes
- `DELETE /myBooks/books/:id` - Remove from library
- `GET /myBooks/stats` - Comprehensive reading statistics
- `POST /myBooks/books/:id/rate` - Rate a book (1-5 stars)
- `DELETE /myBooks/books/:id/rating` - Remove user's rating
- `POST /myBooks/reading-goal` - Set/update reading goal
- `GET /myBooks/reading-goal` - Get user's reading goal

### **Reviews & Community**
- `GET /reviews/all` - Browse community reviews with votes and comments
- `GET /reviews/user` - Get all reviews by authenticated user
- `GET /reviews/book/:id` - Reviews for specific book
- `POST /reviews` - Create new review with rating
- `POST /reviews/:id/vote` - Vote on review (upvote/downvote)
- `POST /reviews/:id/comment` - Add comment to review
- `GET /reviews/comments/:id/replies` - Get replies to a comment
- `POST /reviews/comments/:id/vote` - Vote on comment or reply

### **User Management**
- `GET /users/profile` - User profile data
- `PUT /users/profile` - Update profile information
- `GET /userManagement/users` - Get all users (moderator only)
- `POST /userManagement/users/:id/deactivate` - Deactivate user account
- `POST /userManagement/users/:id/reactivate` - Reactivate user account
- `GET /userManagement/deactivation-history` - Get user deactivation history

### **Analytics & Insights**
- `GET /analytics/genre-ratings` - Genre-wise rating analytics with metrics
- `GET /analytics/author-ratings` - Author performance analytics
- `GET /analytics/publisher-ratings` - Publisher performance analytics
- `GET /analytics/content-gaps` - Content gap analysis from failed searches
- `GET /analytics/options` - Get dropdown options for analytics filters
- `GET /analytics/summary` - Comprehensive analytics summary
- `GET /analytics/trends` - Trending books/genres over time
- `GET /analytics/user-activity-time` - User login activity by hour
- `GET /analytics/user-engagement` - User engagement scores and rankings
- `GET /analytics/user-base-overview` - User base statistics and overview
- `GET /analytics/user-activity-profile/:id` - Detailed user activity profile

### **Home Page Data**
- `GET /home/featured-books` - Featured books for homepage
- `GET /home/recent-books` - Recently added books
- `GET /home/trending-books` - Trending/popular books
- `GET /home/stats` - Platform statistics summary

### **Filter Options**
- `GET /filter-options` - Get all available filter options
  - Languages, genres, authors, publishers, countries
  - Publication date ranges, rating ranges

### **Authors**
- `GET /authors` - Browse authors with search and filtering
- `GET /authors/:id` - Individual author details with books
- `GET /authors/:id/books` - Books by specific author

### **Genres**
- `GET /genres` - Browse all genres
- `GET /genres/:id` - Individual genre details
- `GET /genres/:id/books` - Books in specific genre

### **Moderator Features**
- `GET /moderator/books` - Book management interface with advanced filtering
- `PUT /moderator/books/:id` - Edit book details
- `DELETE /moderator/books/:id` - Delete book with complete audit trail
- `GET /moderator/users` - User management with status filtering
- `GET /moderator/filter-options` - Filter options for moderator interfaces
- `GET /moderator/stats` - Moderator dashboard statistics

### **Content Management**
- `POST /addBook/start-session` - Begin transactional book addition
- `POST /addBook/rollback-session` - Rollback book addition transaction
- `POST /addBook/commit-session` - Commit book addition transaction
- `GET /addBook/genres` - Get genres with search for book addition
- `POST /addBook/genres` - Add new genre during book creation
- `GET /addBook/languages` - Get languages with search
- `POST /addBook/languages` - Add new language with ISO code
- `GET /addBook/publication_houses` - Get publishers with search
- `POST /addBook/publication_houses` - Add new publisher
- `GET /addBook/authors` - Get authors with search
- `POST /addBook/authors` - Add new author with biography
- `POST /addBook/books` - Complete book addition with all relationships

### **Advanced Search Features**
- Query parameters for all search endpoints:
  - `q` - Search query text
  - `genre` - Filter by genre ID
  - `author` - Filter by author ID
  - `language` - Filter by language ID
  - `publisher` - Filter by publisher ID
  - `country` - Filter by country
  - `minRating`, `maxRating` - Rating range filters
  - `minYear`, `maxYear` - Publication year range
  - `sort` - Sort field (title, author, rating, date)
  - `order` - Sort order (asc/desc)
  - `page`, `limit` - Pagination parameters

### **Data Analytics Query Parameters**
- `startDate`, `endDate` - Date range filtering
- `displayType` - Analytics display type (top-rated, most-books, etc.)
- `minBooks`, `minRating` - Minimum thresholds for filtering
- `limit` - Result limit for analytics queries
- `authorId`, `publisherId` - Specific entity filtering

## 📊 Advanced Analytics

### **User Analytics**
- Reading goal progress with percentage completion
- Monthly reading activity with page tracking
- Genre preference analysis
- Author reading statistics
- Reading streak calculation
- Book length preference analysis
- Rating distribution patterns

### **System Analytics**
- Search query tracking and analysis
- Failed search identification for content gaps
- Popular books and trending content
- User engagement metrics
- Content growth tracking

### **Moderator Insights**
- Book catalog management statistics
- User activity monitoring
- Content gap analysis from failed searches
- Deletion audit trails
- User management history

## 🎨 UI/UX Design

Litloom features a sophisticated, modern interface:

- **Goodreads-Inspired Layout**: Familiar book page design with enhanced features
- **Dark Theme**: Eye-friendly interface optimized for extended reading sessions
- **Responsive Grid System**: Optimized layouts for all screen sizes
- **Smooth Animations**: Polished micro-interactions and transitions
- **Loading States**: Skeleton screens and progress indicators
- **Error Boundaries**: Graceful error handling and user feedback
- **Accessibility**: ARIA labels, keyboard navigation, and high contrast
- **Performance**: Optimized rendering and efficient state management

## 🎓 Academic Context

This project was developed as part of the **CSE 216: Database Sessional** course in Level 2, Term 1. It demonstrates:

- **Database Design**: Complex relational schema with proper normalization
- **Full-Stack Development**: Integration of frontend, backend, and database
- **Security Best Practices**: Authentication, authorization, and data protection
- **Modern Web Technologies**: React, Node.js, and PostgreSQL ecosystem
- **User Experience Design**: Intuitive interface and responsive design

## 👥 Team

- **Developers**: Priyanjan Das Anabil (2205079), Irham Dipra (2205068)
- **Course**: CSE 216: Database Sessional
- **Institution**: Bangladesh University of Engineering and Technology (BUET)
- **Department**: Computer Science and Engineering
- **Academic Year**: Level 2, Term 1

---

**Happy Reading with Litloom! 📚✨**