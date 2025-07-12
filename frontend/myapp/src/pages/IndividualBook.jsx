import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { FaStar, FaCheckCircle, FaPlus, FaCheck, FaBook, FaUser, FaCalendar, FaGlobe } from 'react-icons/fa';
import { BiChevronDown } from 'react-icons/bi';
import RatingComponent from '../components/RatingComponent';
import Navbar from '../components/Navbar';
import './IndividualBook.css';

function IndividualBook() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [book, setBook] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [userRating, setUserRating] = useState(0);
  const [isRating, setIsRating] = useState(false);
  const [currentShelf, setCurrentShelf] = useState(null);
  const [isUpdatingShelf, setIsUpdatingShelf] = useState(false);
  const [showShelfDropdown, setShowShelfDropdown] = useState(false);
  const [loggedIn, setLoggedIn] = useState(false);

  useEffect(() => {
    // Check login status
    const token = localStorage.getItem('token') || localStorage.getItem('authToken');
    setLoggedIn(!!token);

    const fetchBook = async () => {
      try {
        const headers = {
          'Content-Type': 'application/json'
        };
        
        // Add authorization header if token exists
        if (token) {
          headers['Authorization'] = `Bearer ${token}`;
        }

        const res = await fetch(`http://localhost:3000/books/${id}`, { headers });
        if (!res.ok) throw new Error('Failed to fetch book details');
        const data = await res.json();
        
        setBook(data);
        setUserRating(data.user_rating || 0);
        setCurrentShelf(data.shelf);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    fetchBook();
  }, [id]);

  const isLoggedIn = () => {
    const token = localStorage.getItem('token') || localStorage.getItem('authToken');
    return token && token.trim() !== '' && token !== 'null';
  };

  const handleRatingChange = async (rating) => {
    if (!isLoggedIn()) {
      navigate('/login');
      return;
    }

    setIsRating(true);
    try {
      const token = localStorage.getItem('token') || localStorage.getItem('authToken');
      
      // First add book to library if not already added
      if (!currentShelf) {
        const addResponse = await fetch('http://localhost:3000/myBooks/books', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`,
          },
          body: JSON.stringify({
            bookId: id
          })
        });
        // It's okay if this fails (book might already be in library)
      }
      
      // Then rate the book
      const rateResponse = await fetch(`http://localhost:3000/myBooks/books/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify({
          rating: rating
        })
      });

      if (!rateResponse.ok) {
        throw new Error('Failed to update rating');
      }

      setUserRating(rating);
      
    } catch (error) {
      console.error('Failed to rate book:', error);
      alert('Failed to rate book. Please try again.');
    } finally {
      setIsRating(false);
    }
  };

  const handleShelfChange = async (shelf) => {
    if (!isLoggedIn()) {
      navigate('/login');
      return;
    }

    setIsUpdatingShelf(true);
    setShowShelfDropdown(false);
    
    try {
      const token = localStorage.getItem('token') || localStorage.getItem('authToken');
      
      if (!currentShelf) {
        // Add book to library with specified shelf
        const addResponse = await fetch('http://localhost:3000/myBooks/books', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`,
          },
          body: JSON.stringify({
            bookId: id,
            shelf: shelf
          })
        });

        if (!addResponse.ok) {
          throw new Error('Failed to add book to library');
        }
      } else {
        // Update existing book shelf
        const updateResponse = await fetch(`http://localhost:3000/myBooks/books/${id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`,
          },
          body: JSON.stringify({
            shelf: shelf
          })
        });

        if (!updateResponse.ok) {
          throw new Error('Failed to update book shelf');
        }
      }

      setCurrentShelf(shelf);
      
    } catch (error) {
      console.error('Failed to update shelf:', error);
      alert('Failed to update shelf. Please try again.');
    } finally {
      setIsUpdatingShelf(false);
    }
  };

  const getShelfDisplayName = (shelf) => {
    switch (shelf) {
      case 'want-to-read': return 'Want to Read';
      case 'currently-reading': return 'Currently Reading';
      case 'read': return 'Read';
      default: return 'Want to Read';
    }
  };

  const getShelfButtonClass = (shelf) => {
    switch (shelf) {
      case 'read': return 'shelf-read';
      case 'currently-reading': return 'shelf-reading';
      default: return 'shelf-want';
    }
  };

  if (loading) {
    return (
      <div className="book-page">
        <Navbar loggedIn={loggedIn} />
        <div className="loading-container">
          <div className="loading-spinner"></div>
          <p>Loading book details...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="book-page">
        <Navbar loggedIn={loggedIn} />
        <div className="error-container">
          <p>Error: {error}</p>
        </div>
      </div>
    );
  }

  if (!book) {
    return (
      <div className="book-page">
        <Navbar loggedIn={loggedIn} />
        <div className="error-container">
          <p>No book found.</p>
        </div>
      </div>
    );
  }

  // Calculate stars for rating
  const rating = Math.round(parseFloat(book.average_rating) || 0);
  const formatDate = (dateString) => {
    if (!dateString) return 'Unknown';
    return new Date(dateString).getFullYear();
  };

  return (
    <div className="book-page">
      <Navbar loggedIn={loggedIn} />
      
      <div className="book-container">
        <div className="book-main">
          {/* Left side - Book cover and actions */}
          <div className="book-left">
            <div className="book-cover-container">
              <img
                src={book.cover_image || '/default-book-cover.jpg'}
                alt={book.title}
                className="book-cover-large"
              />
              {currentShelf === 'read' && (
                <div className="read-badge">
                  <FaCheckCircle /> Read
                </div>
              )}
            </div>

            {/* Book actions */}
            <div className="book-actions-container">
              {loggedIn ? (
                <>
                  <div className="shelf-selector">
                    <button 
                      className={`shelf-button ${getShelfButtonClass(currentShelf)} ${isUpdatingShelf ? 'loading' : ''}`}
                      onClick={() => setShowShelfDropdown(!showShelfDropdown)}
                      disabled={isUpdatingShelf}
                    >
                      {isUpdatingShelf ? (
                        'Updating...'
                      ) : (
                        <>
                          {currentShelf ? getShelfDisplayName(currentShelf) : 'Want to Read'}
                          <BiChevronDown />
                        </>
                      )}
                    </button>
                    
                    {showShelfDropdown && (
                      <div className="shelf-dropdown">
                        <div 
                          className="shelf-option"
                          onClick={() => handleShelfChange('want-to-read')}
                        >
                          Want to Read
                        </div>
                        <div 
                          className="shelf-option"
                          onClick={() => handleShelfChange('currently-reading')}
                        >
                          Currently Reading
                        </div>
                        <div 
                          className="shelf-option"
                          onClick={() => handleShelfChange('read')}
                        >
                          Read
                        </div>
                      </div>
                    )}
                  </div>

                  <div className="rating-section">
                    <span className="rating-label">Rate this book:</span>
                    <RatingComponent
                      currentRating={userRating}
                      onRatingChange={handleRatingChange}
                      isInteractive={true}
                      size="medium"
                    />
                  </div>
                </>
              ) : (
                <button 
                  className="login-prompt-button"
                  onClick={() => navigate('/login')}
                >
                  Sign in to rate and review
                </button>
              )}
            </div>
          </div>

          {/* Right side - Book details */}
          <div className="book-right">
            <div className="book-header">
              <h1 className="book-title">{book.title}</h1>
              <div className="book-author">
                <FaUser className="author-icon" />
                <span>by {book.author_name || 'Unknown Author'}</span>
              </div>
            </div>

            <div className="book-rating-summary">
              <div className="average-rating">
                <div className="rating-stars">
                  {[1, 2, 3, 4, 5].map((num) => (
                    <FaStar 
                      key={num} 
                      className={`star ${num <= rating ? 'filled' : 'empty'}`} 
                    />
                  ))}
                </div>
                <span className="rating-value">{book.average_rating ? parseFloat(book.average_rating).toFixed(2) : 'No rating'}</span>
              </div>
            </div>

            <div className="book-meta">
              <div className="meta-item">
                <FaCalendar className="meta-icon" />
                <span>Published {formatDate(book.publication_date)}</span>
              </div>
              {book.original_country && (
                <div className="meta-item">
                  <FaGlobe className="meta-icon" />
                  <span>{book.original_country}</span>
                </div>
              )}
            </div>

            <div className="book-description-section">
              <h3>Description</h3>
              <div className="book-description">
                {book.description || 'No description available for this book.'}
              </div>
            </div>

            <div className="book-details-section">
              <h3>Book Details</h3>
              <div className="details-grid">
                <div className="detail-item">
                  <span className="detail-label">Language:</span>
                  <span className="detail-value">Language ID {book.language_id}</span>
                </div>
                <div className="detail-item">
                  <span className="detail-label">Genre:</span>
                  <span className="detail-value">Genre ID {book.genre_id}</span>
                </div>
                <div className="detail-item">
                  <span className="detail-label">Publisher:</span>
                  <span className="detail-value">Publisher ID {book.publication_house_id}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default IndividualBook;
