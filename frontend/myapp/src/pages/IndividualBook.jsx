import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { FaStar } from 'react-icons/fa';
import RatingComponent from '../components/RatingComponent';
import './IndividualBook.css';
import Review from '../components/Review';

function IndividualBook() {
  
  const { id } = useParams();
  const navigate = useNavigate();
  const [book, setBook] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [userRating, setUserRating] = useState(0);
  const [isRating, setIsRating] = useState(false);

  const [loggedIn, setLoggedIn] = useState(false);
  const [userId, setUserId] = useState(null);

  const [reviewTitle, setReviewTitle] = useState('');
  const [reviewBody, setReviewBody] = useState('');
  const [reviewMessage, setReviewMessage] = useState(null);

  // New state for reviews
  const [reviews, setReviews] = useState([]);
  const [reviewsLoading, setReviewsLoading] = useState(true);
  const [reviewsError, setReviewsError] = useState(null);

  // Load book details + login state
  useEffect(() => {
    const isLoggedIn = localStorage.getItem('loggedIn') === 'true';
    const storedUserId = localStorage.getItem('userId');

    setLoggedIn(isLoggedIn);
    setUserId(storedUserId ? parseInt(storedUserId) : null);

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

  // Fetch reviews for this book
  useEffect(() => {
    const fetchReviews = async () => {
      try {
        setReviewsLoading(true);
        const res = await fetch(`http://localhost:3000/reviews/book/${id}`);
        if (!res.ok) throw new Error('Failed to fetch reviews');
        const data = await res.json();
        setReviews(data);
      } catch (err) {
        setReviewsError(err.message);
      } finally {
        setReviewsLoading(false);
      }
    };

    fetchReviews();
  }, [id]);

  // Submit review
  const handleReviewSubmit = async (e) => {
    e.preventDefault();
    setReviewMessage(null);

    if (!reviewTitle.trim() || !reviewBody.trim()) {
      setReviewMessage('❌ Title and body are required.');
      return;
    }

    if (!userId) {
      setReviewMessage('❌ User not logged in.');
      return;
    }

    try {
      const currentDateTime = new Date().toISOString();
      
      const res = await fetch('http://localhost:3000/reviews', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          user_id: userId,
          book_id: parseInt(id),
          title: reviewTitle.trim(),
          body: reviewBody.trim(),
          created_at: currentDateTime,
        }),
      });

      if (!res.ok) {
        const err = await res.json();
        throw new Error(err.message || 'Failed to submit review');
      }

      setReviewMessage('✅ Review submitted successfully!');
      setReviewTitle('');
      setReviewBody('');
      
      // Refresh reviews after successful submission
      const refreshRes = await fetch(`http://localhost:3000/reviews/book/${id}`);
      if (refreshRes.ok) {
        const refreshedReviews = await refreshRes.json();
        setReviews(refreshedReviews);
      }
    } catch (err) {
      setReviewMessage(`❌ ${err.message}`);

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

  const rating = Math.round(parseFloat(book.average_rating) || 0);
  const stars = [1, 2, 3, 4, 5].map((num) => (
    <FaStar key={num} className={`star ${num <= rating ? '' : 'empty'}`} />
  ));

  return (
    <div className="individual-book">
      <div
        className="ind-book-cover"
        style={{ backgroundImage: `url(${book.cover_image || ''})` }}
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

        <p className="book-description">{book.description || 'No description available.'}</p>
      </div>

      {loggedIn && userId && (
        <div className="book-reviews">
          <h2>Write a Review</h2>
          <form onSubmit={handleReviewSubmit} className="review-form">
            <input
              type="text"
              value={reviewTitle}
              onChange={(e) => setReviewTitle(e.target.value)}
              placeholder="Review title"
              required
            />
            <textarea
              value={reviewBody}
              onChange={(e) => setReviewBody(e.target.value)}
              placeholder="Write your review..."
              required
            />
            <button type="submit">Submit Review</button>
          </form>

          {reviewMessage && (
            <p
              className="review-feedback"
              style={{
                marginTop: '1rem',
                color: reviewMessage.startsWith('✅') ? 'green' : 'red',
              }}
            >
              {reviewMessage}
            </p>
          )}
        </div>
      )}

      {/* Reviews Section */}
      <div className="reviews-section">
        <h2>Reviews</h2>
        {reviewsLoading && <p>Loading reviews...</p>}
        {reviewsError && <p>Error loading reviews: {reviewsError}</p>}
        {!reviewsLoading && !reviewsError && reviews.length === 0 && (
          <p>No reviews yet. Be the first to review this book!</p>
        )}
        {!reviewsLoading && !reviewsError && reviews.length > 0 && (
          <div className="reviews-list">
            {reviews.map((review) => (
              <Review
                key={review.id}
                id={review.id}
                title={review.title}
                body={review.body}
                reviewerName={review.user_name}
                rating={review.rating}
                created_at={review.created_at}
                initialUpvotes={0}
                initialDownvotes={0}
              />
            ))}
          </div>
        )}
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