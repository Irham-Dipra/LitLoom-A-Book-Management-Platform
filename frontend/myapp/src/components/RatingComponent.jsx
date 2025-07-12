import React, { useState } from 'react';
import './RatingComponent.css';

const RatingComponent = ({ 
  currentRating = 0, 
  onRatingChange, 
  isInteractive = true, 
  size = 'medium',
  showValue = false 
}) => {
  const [hoveredRating, setHoveredRating] = useState(0);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleRatingClick = async (rating) => {
    if (!isInteractive || isSubmitting) return;
    
    setIsSubmitting(true);
    try {
      await onRatingChange(rating);
    } catch (error) {
      console.error('Error submitting rating:', error);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleMouseEnter = (rating) => {
    if (isInteractive) {
      setHoveredRating(rating);
    }
  };

  const handleMouseLeave = () => {
    if (isInteractive) {
      setHoveredRating(0);
    }
  };

  const getStarClass = (starIndex) => {
    const rating = hoveredRating || currentRating;
    const baseClass = `rating-star ${size}`;
    
    if (starIndex <= rating) {
      return `${baseClass} filled`;
    } else if (starIndex - 0.5 <= rating) {
      return `${baseClass} half-filled`;
    } else {
      return `${baseClass} empty`;
    }
  };

  return (
    <div className={`rating-component ${isInteractive ? 'interactive' : ''}`}>
      <div className="stars-container">
        {[1, 2, 3, 4, 5].map((star) => (
          <span
            key={star}
            className={getStarClass(star)}
            onClick={() => handleRatingClick(star)}
            onMouseEnter={() => handleMouseEnter(star)}
            onMouseLeave={handleMouseLeave}
            style={{ 
              cursor: isInteractive ? 'pointer' : 'default',
              opacity: isSubmitting ? 0.5 : 1
            }}
          >
            ★
          </span>
        ))}
      </div>
      
      {showValue && currentRating > 0 && (
        <span className="rating-value">
          {currentRating.toFixed(1)}
        </span>
      )}
      
      {isInteractive && (
        <div className="rating-tooltip">
          {hoveredRating > 0 ? (
            <span>Rate {hoveredRating} star{hoveredRating > 1 ? 's' : ''}</span>
          ) : currentRating > 0 ? (
            <span>Your rating: {currentRating} star{currentRating > 1 ? 's' : ''}</span>
          ) : (
            <span>Click to rate</span>
          )}
        </div>
      )}
    </div>
  );
};

export default RatingComponent;