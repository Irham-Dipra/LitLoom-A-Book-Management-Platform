# 📚 Litloom - Your Digital Book Haven

[![React](https://img.shields.io/badge/React-19.1.0-blue.svg)](https://reactjs.org/)
[![Node.js](https://img.shields.io/badge/Node.js-Express-green.svg)](https://nodejs.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-blue.svg)](https://postgresql.org/)
<!-- [![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) -->

> **Litloom** is a comprehensive book management and discovery platform designed to connect book lovers with their next great read. Built as part of the CSE 216: Database Sessional course (Level 2, Term 1), this full-stack web application provides a modern, intuitive interface for book discovery, personal library management, and community engagement.

## 🎯 About Litloom

Litloom transforms the way you discover, organize, and engage with books. Whether you're a casual reader or a literary enthusiast, our platform offers a seamless experience for managing your reading journey. From discovering new titles to tracking your reading progress and sharing reviews with the community, Litloom is your all-in-one book companion.

## ✨ Features

### 🔍 **Book Discovery & Search**
- **Smart Search**: Find books by title, author, genre, or keywords
- **Advanced Filtering**: Filter by genre, language, publication year, and rating
- **Personalized Recommendations**: Discover books based on your reading history
- **Trending Books**: Explore what's popular in the community

### 📚 **Personal Library Management**
- **Custom Shelves**: Organize books into "Want to Read", "Currently Reading", and "Read"
- **Reading Progress**: Track your reading journey and completion status
- **Personal Ratings**: Rate books on a 5-star scale
- **Reading Statistics**: View your reading habits and achievements

### 💬 **Community Features**
- **Book Reviews**: Write and read detailed book reviews
- **Community Ratings**: See what other readers think about books
- **User Profiles**: Showcase your reading preferences and activity
- **Review Interactions**: Engage with other readers' reviews

### 📖 **Detailed Book Information**
- **Comprehensive Details**: Publication info, genres, languages, and descriptions
- **Author Biographies**: Learn about your favorite authors
- **Multiple Formats**: Support for digital (PDF) and physical books
- **Cover Gallery**: High-quality book cover images

### 🎨 **Modern User Experience**
- **Responsive Design**: Seamless experience across desktop, tablet, and mobile
- **Dark Theme**: Eye-friendly interface inspired by modern reading apps
- **Goodreads-Style Layout**: Familiar and intuitive book page design
- **Smooth Animations**: Polished interactions and transitions

### 🔐 **User Management**
- **Secure Authentication**: JWT-based login system with bcrypt password hashing
- **Profile Customization**: Personalize your profile with bio and preferences
- **Session Management**: Secure login/logout with activity tracking
- **Data Privacy**: Secure handling of personal information

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

### **Database**
- **PostgreSQL** - Primary database with complex relational schema
- **pg 8.16.0** - PostgreSQL client for Node.js
- **Database Features**: 
  - User management and authentication
  - Book catalog with detailed metadata
  - Review and rating system
  - Personal library management
  - Author and publisher information

### **Development Tools**
- **dotenv 16.5.0** - Environment variable management
- **CORS 2.8.5** - Cross-origin resource sharing
- **Express Validator 7.2.1** - Input validation and sanitization
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

2. **Import Database Schema**
   ```bash
   # From the project root directory
   psql -U postgres -d litloom -f database/litloom_schema_only.sql
   ```

3. **Import Sample Data (Optional)**
   ```bash
   # Import sample books, authors, and users
   psql -U postgres -d litloom -f database/litloom_data_inserts.sql
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

## 📁 Project Structure

```
LitLoom/
├── backend/                 # Node.js/Express backend
│   ├── controllers/         # Business logic controllers
│   ├── db/                  # Database connection
│   ├── routes/              # API route definitions
│   ├── .env                 # Environment variables
│   ├── index.js             # Main server file
│   └── package.json         # Backend dependencies
├── frontend/myapp/          # React frontend
│   ├── public/              # Static assets
│   ├── src/
│   │   ├── components/      # Reusable React components
│   │   ├── pages/           # Page components
│   │   ├── App.js           # Main application component
│   │   └── index.js         # Application entry point
│   └── package.json         # Frontend dependencies
├── database/                # Database schema and sample data
│   ├── litloom_schema_only.sql
│   ├── litloom_data_inserts.sql
│   └── litloom_full_backup.sql
└── README.md               # Project documentation
```

## 🗄 Database Schema

The Litloom database consists of the following main entities:

- **users** - User accounts and profiles
- **books** - Book catalog with metadata
- **authors** - Author information and biographies
- **genres** - Book categorization
- **languages** - Supported languages
- **publication_houses** - Publisher information
- **reviews** - User reviews and ratings
- **user_books** - Personal library management
- **login_history** - User session tracking

## 🎨 UI/UX Design

Litloom features a modern, dark-themed interface inspired by popular reading platforms:

- **Goodreads-Style Layout**: Familiar book page design with community features
- **Responsive Design**: Optimized for desktop, tablet, and mobile devices
- **Smooth Animations**: Polished interactions and micro-animations
- **Accessibility**: High contrast ratios and keyboard navigation support
- **Performance**: Optimized loading times and smooth scrolling

## 🤝 Contributing

We welcome contributions to Litloom! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Commit your changes** (`git commit -m 'Add amazing feature'`)
4. **Push to the branch** (`git push origin feature/amazing-feature`)
5. **Open a Pull Request**

### Development Guidelines

- Follow existing code style and conventions
- Write clear, descriptive commit messages
- Test your changes thoroughly before submitting
- Update documentation for new features
- Ensure responsive design compatibility

<!-- ## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details. -->

## 🎓 Academic Context

This project was developed as part of the **CSE 216: Database Sessional** course in Level 2, Term 1. It demonstrates:

- **Database Design**: Complex relational schema with proper normalization
- **Full-Stack Development**: Integration of frontend, backend, and database
- **Security Best Practices**: Authentication, authorization, and data protection
- **Modern Web Technologies**: React, Node.js, and PostgreSQL ecosystem
- **User Experience Design**: Intuitive interface and responsive design

## 👥 Team

- **Developer**: Priyanjan Das Anabil (2205079), Irham Dipra (2205068)
- **Course**: CSE 216: Database Sessional
- **Institution**: Bangladesh University of Engineering and Technology
- **Academic Year**: Level 2, Term 1

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/Irham-Dipra/DBMS-project/issues) page
2. Create a new issue with detailed information
3. Contact the development team

## 🚀 Future Enhancements

- **Social Features**: Friend connections and reading groups
- **Advanced Analytics**: Reading statistics and trends
- **Mobile App**: Native iOS and Android applications
- **AI Recommendations**: Machine learning-powered book suggestions
- **Integration APIs**: Goodreads and Amazon book data integration
- **Reading Challenges**: Gamification and reading goals

---

**Happy Reading with Litloom! 📚✨**

*Discover your next favorite book and connect with fellow readers in our growing community.*