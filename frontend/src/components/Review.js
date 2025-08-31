import React, { useState } from 'react';
import './Review.css';
import { FaThumbsUp, FaThumbsDown, FaStar } from 'react-icons/fa';

const Review = ({
  id,
  title = 'Review Title',
  body = 'This is the review body content...',
  reviewerName = 'Anonymous',
  firstName = '',
  lastName = '',
  profilePictureUrl = '',
  rating = 5,
  created_at = new Date().toISOString(),
  initialUpvotes = 0,
  initialDownvotes = 0,
}) => {
  const [upvotes, setUpvotes] = useState(initialUpvotes);
  const [downvotes, setDownvotes] = useState(initialDownvotes);
  const [userVote, setUserVote] = useState(null); // null, 'up', or 'down'

  // Format the date from created_at timestamp
  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString();
  };

  // Get display name for reviewer
  const getDisplayName = () => {
    if (firstName && lastName) {
      return `${firstName} ${lastName}`;
    } else if (firstName) {
      return firstName;
    }
    return reviewerName;
  };

  // Get user initials for avatar
  const getUserInitials = () => {
    if (firstName && lastName) {
      return `${firstName.charAt(0)}${lastName.charAt(0)}`.toUpperCase();
    } else if (firstName) {
      return firstName.charAt(0).toUpperCase();
    } else if (reviewerName) {
      return reviewerName.charAt(0).toUpperCase();
    }
    return '👤';
  };

  // Check if user is logged in (you might need to adjust this based on your auth implementation)
  const isLoggedIn = () => {
    const token = localStorage.getItem('token') || localStorage.getItem('authToken');
    return token && token !== 'null' && token !== 'undefined';
  };

  const handleUpvote = async (e) => {
    e.stopPropagation();
    
    if (!isLoggedIn()) {
      alert('Please login to vote on reviews');
      return;
    }

    if (userVote === 'up') {
      // Remove upvote
      setUpvotes(prev => prev - 1);
      setUserVote(null);
    } else if (userVote === 'down') {
      // Switch from downvote to upvote
      setUpvotes(prev => prev + 1);
      setDownvotes(prev => prev - 1);
      setUserVote('up');
    } else {
      // Add upvote
      setUpvotes(prev => prev + 1);
      setUserVote('up');
    }

    // TODO: Add API call to update vote on backend
    // await updateReviewVote(id, 'up');
  };

  const handleDownvote = async (e) => {
    e.stopPropagation();
    
    if (!isLoggedIn()) {
      alert('Please login to vote on reviews');
      return;
    }

    if (userVote === 'down') {
      // Remove downvote
      setDownvotes(prev => prev - 1);
      setUserVote(null);
    } else if (userVote === 'up') {
      // Switch from upvote to downvote
      setDownvotes(prev => prev + 1);
      setUpvotes(prev => prev - 1);
      setUserVote('down');
    } else {
      // Add downvote
      setDownvotes(prev => prev + 1);
      setUserVote('down');
    }

    // TODO: Add API call to update vote on backend
    // await updateReviewVote(id, 'down');
  };

  const renderStars = (rating) => {
    const stars = [];
    const fullStars = Math.floor(rating);
    const hasHalfStar = rating % 1 !== 0;

    for (let i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.push(
          <FaStar key={i} className="star-icon" />
        );
      } else if (i === fullStars && hasHalfStar) {
        stars.push(
          <FaStar key={i} className="star-icon" style={{ opacity: 0.5 }} />
        );
      } else {
        stars.push(
          <FaStar key={i} className="star-icon empty" />
        );
      }
    }

    return stars;
  };

  return (
    <div className="review-card">
      <div className="review-header">
        <div className="reviewer-info">
          <div className="reviewer-avatar">
            {profilePictureUrl ? (
              <img src={profilePictureUrl} alt="Profile" className="avatar-image" />
            ) : (
              <div className="avatar-initials">{getUserInitials()}</div>
            )}
          </div>
          <div className="reviewer-details">
            <span className="reviewer-name">{getDisplayName()}</span>
            <span className="reviewer-username">@{reviewerName}</span>
            <div className="review-rating">
              <div className="rating-stars">
                {renderStars(rating)}
              </div>
              <span className="rating-value">({rating})</span>
            </div>
          </div>
        </div>
        <span className="review-date">{formatDate(created_at)}</span>
      </div>

      {title && (
        <div className="review-title-section">
          <h4 className="review-title">{title}</h4>
        </div>
      )}

      <div className="review-body">
        {body}
      </div>

      <div className="review-actions">
        <div className="review-meta">
          {/* Meta info moved to header */}
        </div>

        <div className="vote-section">
          <button 
            className={`vote-button upvote ${userVote === 'up' ? 'active' : ''}`}
            onClick={handleUpvote}
            title="Upvote this review"
          >
            <FaThumbsUp className="vote-icon" />
            <span className="vote-count">{upvotes}</span>
          </button>

          <button 
            className={`vote-button downvote ${userVote === 'down' ? 'active' : ''}`}
            onClick={handleDownvote}
            title="Downvote this review"
          >
            <FaThumbsDown className="vote-icon" />
            <span className="vote-count">{downvotes}</span>
          </button>
        </div>
      </div>
    </div>
  );
};

export default Review;