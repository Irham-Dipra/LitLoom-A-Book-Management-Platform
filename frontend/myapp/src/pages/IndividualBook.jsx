import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { FaStar } from 'react-icons/fa';
import './IndividualBook.css';

function IndividualBook() {
  const { id } = useParams();
  const [book, setBook] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

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
        <p className="book-description">{book.description || 'No description available'}</p>
      </div>
    </div>
  );
}

export default IndividualBook;
