import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { FaStar } from 'react-icons/fa';
import RatingComponent from '../components/RatingComponent';
import './IndividualBook.css';

function IndividualBook() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [book, setBook] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [userRating, setUserRating] = useState(0);
  const [isRating, setIsRating] = useState(false);

  useEffect(() => {
    const fetchBook = async () => {
      try {
        const res = await fetch(`http://localhost:3000/books/${id}`);
        if (!res.ok) throw new Error('Failed to fetch book details');
        const data = await res.json();
        setBook(data);
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
      
      // First add book to library if not already added (without shelf)
      const addResponse = await fetch('http://localhost:3000/myBooks/books', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify({
          bookId: id
          // No shelf specified - will be null
        })
      });

      // It's okay if this fails (book might already be in library)
      
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
      alert('Rating submitted successfully!');
      
    } catch (error) {
      console.error('Failed to rate book:', error);
      alert('Failed to rate book. Please try again.');
    } finally {
      setIsRating(false);
    }
  };

  if (loading) return <p>Loading book details...</p>;
  if (error) return <p>Error: {error}</p>;
  if (!book) return <p>No book found.</p>;

  // Calculate stars for rating (round to nearest integer)
  const rating = Math.round(parseFloat(book.average_rating) || 0);
  const stars = [1, 2, 3, 4, 5].map((num) => (
    <FaStar key={num} className={`star ${num <= rating ? '' : 'empty'}`} />
  ));

  return (
    <div className="individual-book">
      <div
        className="ind-book-cover"
        style={{
          backgroundImage: `url(${book.cover_image || ''})`,
        }}
        aria-label={`Cover of ${book.title}`}
      />
      <div className="book-info">
        <h1 className="book-title">{book.title}</h1>
        <p className="book-author">{book.author_name || 'Unknown'}</p>
        <div className="book-rating" aria-label={`Rating: ${rating} out of 5 stars`}>
          {stars}
          <span style={{ marginLeft: 8, fontWeight: '600', color: '#a0c4ff' }}>
            {rating}.0
          </span>
        </div>
        <div className="user-rating-section">
          <h3>Rate this book:</h3>
          <RatingComponent
            currentRating={userRating}
            onRatingChange={handleRatingChange}
            isInteractive={true}
            size="large"
          />
        </div>
        <p className="book-description">{book.description || 'No description available'}</p>
      </div>
    </div>
  );
}

export default IndividualBook;
