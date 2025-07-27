import React, { useState } from 'react';
import './BookCard.css';
import { useNavigate } from 'react-router-dom';
import { FaStar, FaPlus, FaCheck, FaCheckCircle } from 'react-icons/fa';
import RatingComponent from './RatingComponent';

const BookCard = ({
  id,
  title = 'Sample Book Title',
  author = 'Author Name',
  authorId = null,
  onAuthorClick = null,
  averageRating = 4.5,
  coverUrl = '',
  userRating = 0,
  isInUserLibrary = false,
  shelf = null,
  isRead = false,
  isInWishlist: initialIsInWishlist = false,
}) => {
  const navigate = useNavigate();

  const [isAddingToWishlist, setIsAddingToWishlist] = useState(false);
  const [isInWishlist, setIsInWishlist] = useState(initialIsInWishlist || shelf === 'want-to-read');
  const [currentUserRating, setCurrentUserRating] = useState(userRating);
  const [currentAverageRating, setCurrentAverageRating] = useState(averageRating);
  const [isRating, setIsRating] = useState(false);
  const [currentReadStatus, setCurrentReadStatus] = useState(isRead);
  const [isMarkingAsRead, setIsMarkingAsRead] = useState(false);

  // New: track shelf locally for instant UI update
  const [currentShelf, setCurrentShelf] = useState(shelf);

  const isLoggedIn = () => {
    // Your existing isLoggedIn code...
    // (unchanged for brevity)
    // ...
    return true; // Simplify here, or keep your logic
  };

  const decodeJWT = (token) => {
    // Your existing decodeJWT code...
    // ...
  };

  const getUserId = () => {
    // Your existing getUserId code...
    // ...
  };

  const handleCardClick = () => {
    navigate(`/book/${id}`);
  };

  const handleAuthorClick = (e) => {
    e.stopPropagation();
    if (authorId && onAuthorClick) {
      onAuthorClick(authorId);
    } else if (authorId) {
      navigate(`/author/${authorId}`);
    }
  };

  const addToWishlist = async (userId, bookId) => {
    // Your existing API call...
  };

  const removeFromWishlist = async (userId, bookId) => {
    // Your existing API call...
  };

  const handleWishlistClick = async () => {
    if (isAddingToWishlist || currentShelf === 'currently-reading' || currentShelf === 'read') return;

    setIsAddingToWishlist(true);

    try {
      if (isInWishlist) {
        await removeFromWishlist(getUserId(), id);
        setIsInWishlist(false);
        setCurrentShelf(null);  // Remove from wishlist means no shelf
      } else {
        await addToWishlist(getUserId(), id);
        setIsInWishlist(true);
        setCurrentShelf('want-to-read');  // Added to wishlist
      }
    } catch (error) {
      console.error('Error updating wishlist:', error);
    } finally {
      setIsAddingToWishlist(false);
    }
  };

  const handleRatingChange = async (rating) => {
    if (!isLoggedIn()) {
      navigate('/login');
      return;
    }

    if (!isInUserLibrary) {
      await addBookToLibrary(rating);
      return;
    }

    setIsRating(true);
    try {
      const token = localStorage.getItem('token') || localStorage.getItem('authToken');

      const response = await fetch(`http://localhost:3000/myBooks/books/${id}/rate`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify({ rating }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.message || 'Failed to update rating');
      }

      const data = await response.json();
      setCurrentUserRating(rating);
      
      // Update average rating if provided by backend
      if (data.newAverageRating) {
        setCurrentAverageRating(data.newAverageRating);
      }
      
      console.log('✅ Rating updated successfully!');
    } catch (error) {
      console.error('Failed to update rating:', error);
      alert('Failed to update rating. Please try again.');
    } finally {
      setIsRating(false);
    }
  };

  const addBookToLibrary = async (rating) => {
    setIsRating(true);
    try {
      const token = localStorage.getItem('token') || localStorage.getItem('authToken');

      const addResponse = await fetch('http://localhost:3000/myBooks/books', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify({ bookId: id, shelf: 'want-to-read' }),
      });

      if (!addResponse.ok) {
        const errorData = await addResponse.json();
        throw new Error(errorData.message || 'Failed to add book to library');
      }

      const rateResponse = await fetch(`http://localhost:3000/myBooks/books/${id}/rate`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify({ rating }),
      });

      if (!rateResponse.ok) {
        const errorData = await rateResponse.json();
        throw new Error(errorData.message || 'Failed to update rating');
      }

      const data = await rateResponse.json();
      setCurrentUserRating(rating);
      
      // Update average rating if provided by backend
      if (data.newAverageRating) {
        setCurrentAverageRating(data.newAverageRating);
      }
      
      console.log('✅ Book added to library and rated successfully!');
      setCurrentShelf('want-to-read'); // Keep shelf in sync
    } catch (error) {
      console.error('Failed to add book and rate:', error);
      alert('Failed to add book and rate. Please try again.');
    } finally {
      setIsRating(false);
    }
  };

  const handleMarkAsRead = async (e) => {
    e.stopPropagation();

    if (!isLoggedIn()) {
      navigate('/login');
      return;
    }

    setIsMarkingAsRead(true);
    try {
      const token = localStorage.getItem('token') || localStorage.getItem('authToken');

      if (currentReadStatus) {
        // Mark unread - remove shelf
        const updateResponse = await fetch(`http://localhost:3000/myBooks/books/${id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`,
          },
          body: JSON.stringify({
            shelf: null,
            dateRead: null,
          }),
        });

        if (!updateResponse.ok) {
          const errorData = await updateResponse.json();
          throw new Error(errorData.message || 'Failed to mark book as unread');
        }

        setCurrentReadStatus(false);
        setCurrentShelf(null); // Update shelf locally
        console.log('✅ Book marked as unread and removed from library!');
      } else {
        let response;

        if (!isInUserLibrary) {
          response = await fetch('http://localhost:3000/myBooks/books', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${token}`,
            },
            body: JSON.stringify({
              bookId: id,
              shelf: 'read',
            }),
          });
        } else {
          response = await fetch(`http://localhost:3000/myBooks/books/${id}`, {
            method: 'PUT',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${token}`,
            },
            body: JSON.stringify({
              shelf: 'read',
            }),
          });
        }

        if (!response.ok && response.status === 404) {
          response = await fetch('http://localhost:3000/myBooks/books', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${token}`,
            },
            body: JSON.stringify({
              bookId: id,
              shelf: 'read',
            }),
          });
        }

        if (!response.ok) {
          const errorData = await response.json();
          throw new Error(errorData.message || 'Failed to mark book as read');
        }

        setCurrentReadStatus(true);
        setCurrentShelf('read'); // update shelf instantly

        if (isInWishlist) {
          setIsInWishlist(false);
          console.log('✅ Book moved from wishlist to read status');
        }

        console.log('✅ Book marked as read successfully!');
      }
    } catch (error) {
      console.error('Failed to update read status:', error);
      alert('Failed to update read status. Please try again.');
    } finally {
      setIsMarkingAsRead(false);
    }
  };

  return (
    <div className="book-card" onClick={handleCardClick}>
      <div
        className="book-image"
        style={{
          backgroundImage: coverUrl ? `url(${coverUrl})` : undefined,
        }}
      >
        <div
          className={`read-button ${currentReadStatus ? 'is-read' : ''} ${isMarkingAsRead ? 'loading' : ''}`}
          onClick={handleMarkAsRead}
        >
          <FaCheckCircle className="read-icon" />
        </div>
      </div>

      <div className="book-details">
        <div className="rating-row">
          <span className="avg-rating">
            <FaStar className="star-icon yellow" /> {currentAverageRating}
          </span>
          <div onClick={(e) => e.stopPropagation()}>
            <RatingComponent
              currentRating={currentUserRating}
              onRatingChange={handleRatingChange}
              isInteractive={true}
              size="small"
            />
          </div>
        </div>

        <div className="book-title">{title}</div>
        <div
          className={`book-author ${authorId ? 'clickable' : ''}`}
          onClick={authorId ? handleAuthorClick : undefined}
        >
          {author}
        </div>
      </div>

      <div className="book-actions">
        <div
          className={`wishlist-section ${isInWishlist ? 'in-wishlist' : ''} ${isAddingToWishlist ? 'loading' : ''} ${(currentShelf === 'currently-reading' || currentShelf === 'read') ? 'disabled' : ''}`}
          onClick={(e) => {
            e.stopPropagation();
            e.preventDefault();
            if (!(currentShelf === 'currently-reading' || currentShelf === 'read') && !isAddingToWishlist) {
              handleWishlistClick();
            }
          }}
        >
          {isAddingToWishlist ? (
            <>
              <div className="loading-spinner" /> {isInWishlist ? 'Removing...' : 'Adding...'}
            </>
          ) : currentShelf === 'read' || currentShelf === 'currently-reading' ? (
            <>
              <FaCheck className="check-icon" /> Already Read
            </>
          ) : isInWishlist ? (
            <>
              <FaCheck className="check-icon" /> Remove from Wishlist
            </>
          ) : (
            <>
              <FaPlus className="plus-icon" /> Add to Wishlist
            </>
          )}
        </div>
      </div>
    </div>
  );
};

export default BookCard;
