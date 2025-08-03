import React from 'react';
import { useNavigate } from 'react-router-dom';
import { FaUser } from 'react-icons/fa';
import './AuthorCard.css';

function AuthorCard({ id, name, bio, authorImage, firstBookCover, onClick }) {
  const navigate = useNavigate();

  const handleClick = () => {
    if (onClick) {
      onClick(id);
    } else {
      navigate(`/author/${id}`);
    }
  };

  const getInitials = (name) => {
    if (!name) return '?';
    const words = name.split(' ');
    if (words.length >= 2) {
      return `${words[0].charAt(0)}${words[words.length - 1].charAt(0)}`.toUpperCase();
    }
    return name.charAt(0).toUpperCase();
  };

  return (
    <div className="author-card" onClick={handleClick}>
      <div className="author-profile-section">
        <div className="author-avatar">
          {authorImage || firstBookCover ? (
            <>
              <img 
                src={authorImage || firstBookCover} 
                alt={name}
                className="author-avatar-img"
                onError={(e) => {
                  // If primary image fails and we have a fallback, try the fallback
                  if (authorImage && firstBookCover && e.target.src === authorImage) {
                    e.target.src = firstBookCover;
                  } else {
                    // If all images fail, hide the img and show placeholder
                    e.target.style.display = 'none';
                    e.target.nextSibling.style.display = 'flex';
                  }
                }}
              />
              <div className="author-avatar-fallback" style={{ display: 'none' }}>
                {getInitials(name)}
              </div>
            </>
          ) : (
            <div className="author-avatar-fallback">
              <FaUser className="author-icon" />
            </div>
          )}
        </div>
        
        <div className="author-info">
          <h3 className="author-name">{name}</h3>
          <p className="author-bio">
            {bio ? (bio.length > 100 ? `${bio.substring(0, 100)}...` : bio) : 'No biography available'}
          </p>
        </div>
      </div>
      
      <div className="author-card-hover-overlay">
        <span>View Profile</span>
      </div>
    </div>
  );
}

export default AuthorCard;