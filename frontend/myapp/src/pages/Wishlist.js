// src/pages/Wishlist.js
import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { FaStar, FaArrowLeft, FaEye, FaTrash, FaCalendarAlt } from 'react-icons/fa';
import './Wishlist.css';

const Wishlist = () => {
  const [wishlist, setWishlist] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    fetchWishlist();
  }, []);

  const fetchWishlist = async () => {
    try {
      const token = localStorage.getItem('token');
      if (!token) {
        navigate('/login');
        return;
      }

      // Try both possible endpoints
      const endpoints = ['/wishlist', '/api/wishlist'];
      let response = null;
      
      for (const endpoint of endpoints) {
        try {
          console.log(`Trying wishlist endpoint: ${endpoint}`);
          response = await fetch(`http://localhost:3000/wishlist`, {
            method: 'GET',
            headers: {
              'Authorization': `Bearer ${token}`,
              'Content-Type': 'application/json',
            },
          });
          
          if (response.ok) {
            console.log(`✅ Successfully connected to ${endpoint}`);
            break;
          } else if (response.status === 404) {
            console.log(`❌ ${endpoint} not found, trying next...`);
            continue;
          }
        } catch (fetchError) {
          console.log(`❌ ${endpoint} failed:`, fetchError.message);
          continue;
        }
      }

      if (!response || !response.ok) {
        throw new Error('Wishlist endpoint not found or server error');
      }

      const data = await response.json();
      console.log('Wishlist API response:', data);

      if (data.success) {
        setWishlist(data.wishlist || []);
      } else {
        setError(data.message || 'Failed to fetch wishlist');
      }
    } catch (err) {
      console.error('Error fetching wishlist:', err);
      setError('Failed to load wishlist. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const removeFromWishlist = async (bookId) => {
    try {
      const token = localStorage.getItem('token');
      
      const response = await fetch(`http://localhost:3000/wishlist`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ book_id: bookId }),
      });

      const data = await response.json();

      if (data.success) {
        // Remove from local state with animation
        const itemElement = document.querySelector(`[data-book-id="${bookId}"]`);
        if (itemElement) {
          itemElement.style.transform = 'translateX(-100%)';
          itemElement.style.opacity = '0';
          setTimeout(() => {
            setWishlist(prev => prev.filter(item => item.book_id !== bookId));
          }, 300);
        } else {
          setWishlist(prev => prev.filter(item => item.book_id !== bookId));
        }
      } else {
        alert(data.message || 'Failed to remove from wishlist');
      }
    } catch (err) {
      console.error('Error removing from wishlist:', err);
      alert('Failed to remove from wishlist. Please try again.');
    }
  };

  const handleBookClick = (bookId) => {
    navigate(`/book/${bookId}`);
  };

  const handleBackToProfile = () => {
    navigate('/profile');
  };

  // Function to render star ratings
  const renderStars = (rating) => {
    const numRating = Math.round(parseFloat(rating) || 0);
    return [1, 2, 3, 4, 5].map((num) => (
      <FaStar 
        key={num} 
        className={`wishlist-star ${num <= numRating ? '' : 'empty'}`} 
      />
    ));
  };

  // Function to format date
  const formatDate = (dateString) => {
    try {
      return new Date(dateString).toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      });
    } catch (error) {
      return 'Unknown date';
    }
  };

  if (loading) {
    return (
      <div className="wishlist-page">
        <div className="wishlist-container">
          <div className="loading">
            <h2>✨ Loading your wishlist...</h2>
            <p>Gathering your favorite books</p>
          </div>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="wishlist-page">
        <div className="wishlist-container">
          <div className="error-message">
            <h2>😞 Oops! Something went wrong</h2>
            <p>{error}</p>
            <button className="browse-btn" onClick={handleBackToProfile} style={{ marginTop: '1rem' }}>
              <FaArrowLeft /> Back to Profile
            </button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="wishlist-page">
      <div className="wishlist-container">
        <div className="wishlist-header">
          <button className="back-btn" onClick={handleBackToProfile}>
            <FaArrowLeft /> Back to Profile
          </button>
          <h1>📚 My Reading Wishlist</h1>
          <p>
            {wishlist.length === 0 
              ? "No books in your wishlist yet" 
              : `${wishlist.length} amazing book${wishlist.length !== 1 ? 's' : ''} waiting to be read`
            }
          </p>
        </div>

        {wishlist.length === 0 ? (
          <div className="empty-wishlist">
            <div className="empty-icon">📚</div>
            <h2>Your wishlist is empty</h2>
            <p>Discover amazing books and add them to your wishlist.<br />Start building your personal reading collection today!</p>
            <button className="browse-btn" onClick={() => navigate('/')}>
              <span>🔍 Explore Books</span>
            </button>
          </div>
        ) : (
          <div className="wishlist-content">
            {wishlist.map((item, index) => (
              <div 
                key={item.book_id} 
                className="wishlist-item"
                data-book-id={item.book_id}
                style={{ animationDelay: `${index * 0.1}s` }}
              >
                {/* Book Cover Section */}
                <div 
                  className="wishlist-book-cover"
                  style={{
                    backgroundImage: item.cover_url ? `url(${item.cover_url})` : undefined,
                  }}
                  onClick={() => handleBookClick(item.book_id)}
                >
                  {!item.cover_url && (
                    <div className="no-cover">📖</div>
                  )}
                </div>
                
                {/* Book Details Section */}
                <div className="wishlist-book-details">
                  <div>
                    <h2 
                      className="wishlist-book-title" 
                      onClick={() => handleBookClick(item.book_id)}
                    >
                      {item.title || 'Unknown Title'}
                    </h2>
                    
                    <p className="wishlist-book-author">
                      {item.author || 'Unknown Author'}
                    </p>
                    
                    {item.average_rating && (
                      <div className="wishlist-book-rating">
                        {renderStars(item.average_rating)}
                        <span className="rating-text">
                          {parseFloat(item.average_rating).toFixed(1)}
                        </span>
                      </div>
                    )}
                    
                    {item.genre && (
                      <div className="wishlist-book-genre">
                        {item.genre}
                      </div>
                    )}
                    
                    {item.description && (
                      <p className="wishlist-book-description">
                        {item.description}
                      </p>
                    )}
                  </div>
                  
                  <div>
                    <p className="added-date">
                      Added on {formatDate(item.created_at)}
                    </p>
                    
                    <div className="wishlist-item-actions">
                      <button 
                        className="wishlist-action-btn view-details-btn"
                        onClick={() => handleBookClick(item.book_id)}
                      >
                        <FaEye />
                        <span>View Details</span>
                      </button>
                      <button 
                        className="wishlist-action-btn remove-from-wishlist-btn"
                        onClick={() => removeFromWishlist(item.book_id)}
                      >
                        <FaTrash />
                        <span>Remove</span>
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default Wishlist;