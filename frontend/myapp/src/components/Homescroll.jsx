// src/components/Homescroll.jsx
import React, { useRef } from 'react';
import './Homescroll.css';
import BookCard from './BookCard';
import { FaChevronLeft, FaChevronRight } from 'react-icons/fa';

function Homescroll({ title, books }) {
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

  return (
    <div className="book-section">
      <h2 className="section-title">{title}</h2>
      <div className="scroll-container">
        <button className="scroll-btn left" onClick={() => scroll('left')}>
          <FaChevronLeft />
        </button>

        <div className="book-list" ref={scrollRef}>
          {books.map((book, idx) => (
            <div key={book.id} style={{ '--delay': `${idx * 0.15 + 0.6}s` }}>
              <BookCard
                id={book.id}
                title={book.title}
                author={book.author_name || 'Unknown Author'}
                averageRating={book.average_rating}
                coverUrl={book.cover_image}
                userRating={book.user_rating || 0}
                isRead={book.shelf === 'read'}
                isInUserLibrary={book.shelf !== null}
                shelf={book.shelf}
              />
            </div>
          ))}
        </div>

        <button className="scroll-btn right" onClick={() => scroll('right')}>
          <FaChevronRight />
        </button>
      </div>
    </div>
  );
}

export default Homescroll;
