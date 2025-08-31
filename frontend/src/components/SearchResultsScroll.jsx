import React, { useRef } from 'react';
import { FaChevronLeft, FaChevronRight, FaUser } from 'react-icons/fa';
import BookCard from './BookCard';
import { useNavigate } from 'react-router-dom';
import './SearchResultsScroll.css';

function SearchResultsScroll({ title, items, type }) {
  const scrollRef = useRef(null);
  const navigate = useNavigate();

  const scroll = (direction) => {
    const scrollAmount = 300;
    if (scrollRef.current) {
      scrollRef.current.scrollBy({
        left: direction === 'left' ? -scrollAmount : scrollAmount,
        behavior: 'smooth',
      });
    }
  };

  const handleAuthorClick = (authorId) => {
    navigate(`/author/${authorId}`);
  };

  const handleCharacterClick = (characterId) => {
    // Navigate to character page when implemented
    console.log('Character clicked:', characterId);
  };

  const handleUserClick = (userId) => {
    navigate(`/profile/${userId}`);
  };

  const getUserDisplayName = (user) => {
    if (user.first_name && user.last_name) {
      return `${user.first_name} ${user.last_name}`;
    } else if (user.first_name) {
      return user.first_name;
    }
    return user.username;
  };

  const getUserInitials = (user) => {
    if (user.first_name && user.last_name) {
      return `${user.first_name.charAt(0)}${user.last_name.charAt(0)}`.toUpperCase();
    } else if (user.first_name) {
      return user.first_name.charAt(0).toUpperCase();
    } else if (user.username) {
      return user.username.charAt(0).toUpperCase();
    }
    return '👤';
  };

  const renderItem = (item, idx) => {
    switch (type) {
      case 'authors':
        return (
          <div 
            key={item.id} 
            style={{ 
              flex: '0 0 auto',
              width: '160px', // Updated to match CSS
              display: 'inline-block'
            }}
          >
            <div 
              className="author-profile"
              onClick={() => handleAuthorClick(item.id.replace('author-', ''))}
            >
              <div 
                className="author-avatar"
                style={{
                  backgroundImage: item.author_image 
                    ? `url(${item.author_image})` 
                    : item.first_book_cover 
                      ? `url(${item.first_book_cover})`
                      : undefined,
                }}
              >
                {!item.author_image && !item.first_book_cover && <FaUser style={{ fontSize: '3.5rem', color: 'rgba(255,255,255,0.6)' }} />}
              </div>
              <div className="author-name-profile">
                {item.title}
              </div>
            </div>
          </div>
        );
      
      case 'characters':
        return (
          <div 
            key={item.id}
            style={{ 
              flex: '0 0 auto',
              width: '160px', // Updated to match CSS
              display: 'inline-block'
            }}
          >
            <div 
              className="character-profile"
              onClick={() => handleCharacterClick(item.id.replace('character-', ''))}
            >
              <div 
                className="character-avatar"
                style={{
                  backgroundImage: item.first_book_cover 
                    ? `url(${item.first_book_cover})`
                    : undefined,
                }}
              >
                {!item.first_book_cover && <FaUser />}
              </div>
              <div className="character-name-profile">
                {item.title}
              </div>
            </div>
          </div>
        );

      case 'users':
        return (
          <div 
            key={item.id}
            style={{ 
              flex: '0 0 auto',
              width: '160px',
              display: 'inline-block'
            }}
          >
            <div 
              className="user-profile"
              onClick={() => handleUserClick(item.id.replace('user-', ''))}
            >
              <div 
                className="user-avatar"
                style={{
                  backgroundImage: item.profile_picture_url 
                    ? `url(${item.profile_picture_url})`
                    : undefined,
                  backgroundSize: 'cover',
                  backgroundPosition: 'center',
                  backgroundRepeat: 'no-repeat'
                }}
              >
                {!item.profile_picture_url && (
                  <div className="user-initials">{item.initials}</div>
                )}
              </div>
              <div className="user-name-profile">
                {item.display_name}
                {item.is_moderator && <span className="mod-badge">MOD</span>}
              </div>
              <div className="user-username">@{item.username}</div>
            </div>
          </div>
        );
      
      case 'books':
      default:
        return (
          <div key={item.id}>
            <BookCard
              id={item.id}
              title={item.title}
              author={item.author_name || 'Unknown Author'}
              authorId={item.author_id}
              averageRating={item.average_rating}
              coverUrl={item.cover_image}
              userRating={item.user_rating || 0}
              isRead={item.shelf === 'read'}
              isInUserLibrary={item.shelf !== null}
              shelf={item.shelf}
              isInWishlist={item.shelf === 'want-to-read'}
            />
          </div>
        );
    }
  };

  return (
    <div className="search-results-section">
      <h2 className="section-title">{title}</h2>
      <div className="scroll-container">
        <button className="scroll-btn left" onClick={() => scroll('left')}>
          <FaChevronLeft />
        </button>

        <div 
          className={`results-list ${type}-list`} 
          ref={scrollRef}
          style={{
            display: 'flex',
            flexDirection: 'row',
            overflowX: 'auto',
            overflowY: 'hidden'
          }}
        >
          {items.map(renderItem)}
        </div>

        <button className="scroll-btn right" onClick={() => scroll('right')}>
          <FaChevronRight />
        </button>
      </div>
    </div>
  );
}

export default SearchResultsScroll;