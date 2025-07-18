import React, { useRef } from 'react';
import { FaChevronLeft, FaChevronRight } from 'react-icons/fa';
import BookCard from './BookCard';
import AuthorCard from './AuthorCard';
import CharacterCard from './CharacterCard';
import './SearchResultsScroll.css';

function SearchResultsScroll({ title, items, type }) {
  const scrollRef = useRef(null);

  const scroll = (direction) => {
    const scrollAmount = 300;
    if (scrollRef.current) {
      scrollRef.current.scrollBy({
        left: direction === 'left' ? -scrollAmount : scrollAmount,
        behavior: 'smooth',
      });
    }
  };

  const renderItem = (item, idx) => {
    switch (type) {
      case 'authors':
        return (
          <div 
            key={item.id} 
            style={{ 
              '--delay': `${idx * 0.15 + 0.6}s`,
              flex: '0 0 auto',
              width: '300px',
              display: 'inline-block'
            }}
          >
            <AuthorCard
              id={item.id.replace('author-', '')}
              name={item.title}
              bio={item.description}
              authorImage={item.author_image}
            />
          </div>
        );
      
      case 'characters':
        return (
          <div key={item.id} style={{ '--delay': `${idx * 0.15 + 0.6}s` }}>
            <CharacterCard
              id={item.id.replace('character-', '')}
              name={item.title}
              description={item.description}
            />
          </div>
        );
      
      case 'books':
      default:
        return (
          <div key={item.id} style={{ '--delay': `${idx * 0.15 + 0.6}s` }}>
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
            overflowY: 'hidden',
            gap: '16px'
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