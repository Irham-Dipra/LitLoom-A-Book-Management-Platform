import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import BookCard from '../components/BookCard';
import FilterBar from '../components/FilterBar';
import './Author.css';

function Author() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [author, setAuthor] = useState(null);
  const [books, setBooks] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [loggedIn, setLoggedIn] = useState(false);
  const [showFilters, setShowFilters] = useState(false);
  const [filters, setFilters] = useState({
    language: [],
    genre: [],
    author: [],
    publisher: [],
    country: [],
    pubDateRange: [1800, 2025],
    ratingRange: [0, 5]
  });

  useEffect(() => {
    fetchAuthorData();
    checkAuthStatus();
  }, [id]);

  const checkAuthStatus = () => {
    const token = localStorage.getItem('token');
    setLoggedIn(!!token);
  };

  const fetchAuthorData = async () => {
    try {
      setLoading(true);
      const token = localStorage.getItem('token');
      const headers = {
        'Content-Type': 'application/json',
      };
      
      if (token) {
        headers['Authorization'] = `Bearer ${token}`;
      }

      const response = await fetch(`http://localhost:3000/authors/${id}`, {
        headers
      });

      if (!response.ok) {
        if (response.status === 404) {
          setError('Author not found');
        } else {
          throw new Error('Failed to fetch author data');
        }
        return;
      }

      const data = await response.json();
      
      if (data.success) {
        setAuthor(data.data.author);
        setBooks(data.data.books);
      } else {
        setError(data.message || 'Failed to load author data');
      }
    } catch (error) {
      console.error('Error fetching author data:', error);
      setError('Unable to load author information');
    } finally {
      setLoading(false);
    }
  };

  const formatDate = (dateString) => {
    if (!dateString) return 'Unknown';
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { 
      year: 'numeric', 
      month: 'long', 
      day: 'numeric' 
    });
  };

  const handleAuthorClick = (authorId) => {
    navigate(`/author/${authorId}`);
  };

  const handleSearch = (searchTerm) => {
    navigate(`/search?q=${encodeURIComponent(searchTerm)}`);
  };

  const handleFilterToggle = () => {
    setShowFilters(!showFilters);
  };

  const handleFilterChange = (newFilters) => {
    setFilters(newFilters);
  };

  const hasActiveFilters = () => {
    return (
      filters.language.length > 0 ||
      filters.genre.length > 0 ||
      filters.author.length > 0 ||
      filters.publisher.length > 0 ||
      filters.country.length > 0 ||
      (filters.pubDateRange[0] !== 1800 || filters.pubDateRange[1] !== 2025) ||
      (filters.ratingRange[0] !== 0 || filters.ratingRange[1] !== 5)
    );
  };

  if (loading) {
    return (
      <div className="author-container">
        <Navbar 
          loggedIn={loggedIn} 
          onSearch={handleSearch}
          onFilterToggle={handleFilterToggle}
          hasActiveFilters={hasActiveFilters()}
        />
        <div className="loading-spinner">Loading author information...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="author-container">
        <Navbar 
          loggedIn={loggedIn} 
          onSearch={handleSearch}
          onFilterToggle={handleFilterToggle}
          hasActiveFilters={hasActiveFilters()}
        />
        <div className="error-message">
          <h2>Error</h2>
          <p>{error}</p>
          <button onClick={() => navigate(-1)}>Go Back</button>
        </div>
      </div>
    );
  }

  return (
    <div className="author-container">
      <Navbar 
        loggedIn={loggedIn} 
        onSearch={handleSearch}
        onFilterToggle={handleFilterToggle}
        hasActiveFilters={hasActiveFilters()}
      />
      
      {/* Filter popup panel */}
      <div className="filter-container">
        {showFilters && (
          <FilterBar
            filters={filters}
            setFilters={setFilters}
            isOpen={showFilters}
            setIsOpen={setShowFilters}
          />
        )}
      </div>
      
      <div className="author-content">
        <div className="author-header">
          <div className="author-image-container">
            <img 
              src={author.author_image || '/default-author.jpg'} 
              alt={author.name}
              className="author-image"
              onError={(e) => {
                e.target.src = '/default-author.jpg';
              }}
            />
          </div>
          
          <div className="author-info">
            <h1 className="author-name">{author.name}</h1>
            <div className="author-stats">
              <span className="books-count">{books.length} books</span>
            </div>
            
            {author.bio && (
              <div className="author-bio">
                <h3>About the Author</h3>
                <p>{author.bio}</p>
              </div>
            )}
          </div>
        </div>

        <div className="author-books-section">
          <h2>Books by {author.name}</h2>
          
          {books.length === 0 ? (
            <div className="no-books-message">
              <p>No books found for this author.</p>
            </div>
          ) : (
            <div className="author-books-grid">
              {books.map((book) => (
                <div key={book.id} className="author-book-card">
                  <BookCard
                    id={book.id}
                    title={book.title}
                    author={author.name}
                    authorId={author.id}
                    onAuthorClick={handleAuthorClick}
                    averageRating={book.average_rating}
                    coverUrl={book.cover_image}
                    userRating={book.user_rating || 0}
                    isRead={book.shelf === 'read'}
                    isInUserLibrary={book.shelf !== null}
                    shelf={book.shelf}
                    isInWishlist={book.shelf === 'want-to-read'}
                  />
                  
                  <div className="book-details">
                    <div className="book-meta">
                      <span className="publication-date">
                        Published: {formatDate(book.publication_date)}
                      </span>
                      {book.pages && (
                        <span className="page-count">{book.pages} pages</span>
                      )}
                      {book.language_name && (
                        <span className="language">{book.language_name}</span>
                      )}
                      {book.publisher_name && (
                        <span className="publisher">{book.publisher_name}</span>
                      )}
                    </div>
                    
                    {book.co_authors && book.co_authors.length > 0 && (
                      <div className="co-authors">
                        <span>Co-authors: </span>
                        {book.co_authors.map((coAuthor, index) => (
                          <span key={coAuthor.id}>
                            <button 
                              className="co-author-link"
                              onClick={() => handleAuthorClick(coAuthor.id)}
                            >
                              {coAuthor.name}
                            </button>
                            {index < book.co_authors.length - 1 && ', '}
                          </span>
                        ))}
                      </div>
                    )}
                    
                    {book.description && (
                      <div className="book-description">
                        <p>{book.description}</p>
                      </div>
                    )}
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

export default Author;