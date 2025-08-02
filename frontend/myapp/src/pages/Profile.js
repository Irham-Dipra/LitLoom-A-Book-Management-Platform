// src/pages/Profile.jsx
import React, { useEffect, useState } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import './Profile.css';
import BookCard from '../components/BookCard';
import Navbar from '../components/Navbar';
import { FilterProvider } from '../contexts/FilterContext';
import { FaBook, FaCalendarAlt, FaStar, FaChartBar, FaBullseye, FaFire, FaUser, FaBookOpen, FaTrophy, FaChartPie } from 'react-icons/fa';

const Profile = () => {
  const { userId } = useParams(); // Get userId from URL params
  const [user, setUser] = useState(null);
  const [message, setMessage] = useState('');
  const [isLoading, setIsLoading] = useState(true);
  const [myBooks, setMyBooks] = useState([]);
  const [reviews, setReviews] = useState([]);
  const [isEditing, setIsEditing] = useState(false);
  const [editForm, setEditForm] = useState({});
  const [stats, setStats] = useState(null);
  const [monthlyStats, setMonthlyStats] = useState([]);
  const [genreStats, setGenreStats] = useState([]);
  const [authorStats, setAuthorStats] = useState([]);
  const [bookLengthStats, setBookLengthStats] = useState([]);
  const [ratingDistribution, setRatingDistribution] = useState({});
  const [currentUserId, setCurrentUserId] = useState(null); // Track current logged-in user
  const navigate = useNavigate();

  // Determine if this is a public profile view or personal profile
  const isPublicProfile = !!userId;
  const isOwnProfile = currentUserId && userId && parseInt(currentUserId) === parseInt(userId);

  useEffect(() => {
    const fetchUser = async () => {
      try {
        const token = localStorage.getItem('token');
        const loggedInUserId = localStorage.getItem('userId');
        setCurrentUserId(loggedInUserId);

        if (isPublicProfile) {
          // Fetching public profile
          const res = await fetch(`http://localhost:3000/users/${userId}/public`);
          const data = await res.json();

          if (data.success && data.user) {
            setUser(data.user);
            setIsLoading(false);
            await fetchUserBooks(userId);
            await fetchUserReviews(userId);
            await fetchUserStats(userId);
          } else {
            setMessage(data.message || 'User not found or account is deactivated.');
            setIsLoading(false);
          }
        } else {
          // Fetching own profile (existing logic)
          if (!token) {
            localStorage.removeItem('loggedIn');
            setMessage('Not logged in.');
            setIsLoading(false);
            setTimeout(() => navigate('/login'), 1500);
            return;
          }

          const res = await fetch('http://localhost:3000/auth/profile', {
            headers: {
              Authorization: `Bearer ${token}`,
            },
          });

          const data = await res.json();

          if (data.success && data.user) {
            setUser(data.user);
            setEditForm({
              first_name: data.user.first_name || '',
              last_name: data.user.last_name || '',
              bio: data.user.bio || '',
              profile_picture_url: data.user.profile_picture_url || ''
            });
            setIsLoading(false);
            await fetchMyBooks();
            await fetchMyReviews();
            await fetchReadingStats();
          } else {
            localStorage.removeItem('token');
            localStorage.removeItem('loggedIn');
            setMessage(data.message || 'Session expired. Please login again.');
            setIsLoading(false);
            setTimeout(() => navigate('/login'), 2000);
          }
        }
      } catch (err) {
        if (!isPublicProfile) {
          localStorage.removeItem('token');
          localStorage.removeItem('loggedIn');
        }
        setMessage('Network error. Please try again.');
        setIsLoading(false);
        console.error(err);
        if (!isPublicProfile) {
          setTimeout(() => navigate('/login'), 2000);
        }
      }
    };

    fetchUser();
  }, [navigate, userId, isPublicProfile]);

  const fetchMyBooks = async () => {
    try {
      const token = localStorage.getItem('token');
      const response = await fetch('http://localhost:3000/myBooks/books?limit=6', {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      const data = await response.json();
      if (data.success) {
        setMyBooks(data.books);
      }
    } catch (error) {
      console.error('Error fetching books:', error);
    }
  };

  const fetchUserBooks = async (targetUserId) => {
    try {
      const response = await fetch(`http://localhost:3000/myBooks/user/${targetUserId}/books?limit=6`);
      const data = await response.json();
      if (data.success) {
        setMyBooks(data.books);
      }
    } catch (error) {
      console.error('Error fetching user books:', error);
    }
  };

  const fetchMyReviews = async () => {
    try {
      const token = localStorage.getItem('token');
      const response = await fetch('http://localhost:3000/reviews/user', {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      const data = await response.json();
      if (data.success) {
        setReviews(data.reviews.slice(0, 5));
      }
    } catch (error) {
      console.error('Error fetching reviews:', error);
    }
  };

  const fetchUserReviews = async (targetUserId) => {
    try {
      const response = await fetch(`http://localhost:3000/reviews/user/${targetUserId}`);
      const data = await response.json();
      if (data.success) {
        setReviews(data.reviews.slice(0, 5));
      }
    } catch (error) {
      console.error('Error fetching user reviews:', error);
    }
  };

  const fetchReadingStats = async () => {
    try {
      const token = localStorage.getItem('token');
      const response = await fetch('http://localhost:3000/myBooks/stats', {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });
      const data = await response.json();
      if (data.success) {
        setStats(data.stats);
        setMonthlyStats(data.monthlyStats || []);
        setGenreStats(data.genreStats || []);
        setAuthorStats(data.authorStats || []);
        setBookLengthStats(data.bookLengthStats || []);
        setRatingDistribution(data.ratingDistribution || {});
      }
    } catch (error) {
      console.error('Error fetching reading stats:', error);
    }
  };

  const fetchUserStats = async (targetUserId) => {
    try {
      const response = await fetch(`http://localhost:3000/myBooks/user/${targetUserId}/stats`);
      const data = await response.json();
      if (data.success) {
        setStats(data.stats);
        setMonthlyStats(data.monthlyStats || []);
        setGenreStats(data.genreStats || []);
        setAuthorStats(data.authorStats || []);
        setBookLengthStats(data.bookLengthStats || []);
        setRatingDistribution(data.ratingDistribution || {});
      }
    } catch (error) {
      console.error('Error fetching user stats:', error);
    }
  };

  const handleEditProfile = () => {
    setIsEditing(true);
  };

  const handleSaveProfile = async () => {
    try {
      const token = localStorage.getItem('token');
      const response = await fetch('http://localhost:3000/users/profile', {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(editForm),
      });

      const data = await response.json();
      if (data.success) {
        setUser({ ...user, ...editForm });
        setIsEditing(false);
      }
    } catch (error) {
      console.error('Error updating profile:', error);
    }
  };

  const handleLogout = async () => {
    try {
      const token = localStorage.getItem('token');
      if (token) {
        await fetch('http://localhost:3000/auth/logout', {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
      }
    } catch (error) {
      console.error('Error during logout:', error);
    }

    localStorage.removeItem('token');
    localStorage.removeItem('loggedIn');
    navigate('/');
    window.location.reload();
  };

  const handleSearch = (searchTerm) => {
    navigate(`/search?q=${encodeURIComponent(searchTerm)}`);
  };

  const getUserFirstName = (user) => {
    if (!user) return 'User';
    return user.first_name || user.username || 'User';
  };

  const getFullName = (user) => {
    if (!user) return '';
    const firstName = user.first_name || '';
    const lastName = user.last_name || '';
    if (firstName && lastName) {
      return `${firstName} ${lastName}`;
    } else if (firstName) {
      return firstName;
    }
    return user.username || 'User';
  };

  const getUserInitials = (user) => {
    if (!user) return '👤';
    const firstName = user.first_name || '';
    const lastName = user.last_name || '';
    if (firstName && lastName) {
      return `${firstName.charAt(0)}${lastName.charAt(0)}`.toUpperCase();
    } else if (firstName) {
      return firstName.charAt(0).toUpperCase();
    } else if (user.username) {
      return user.username.charAt(0).toUpperCase();
    }
    return '👤';
  };

  if (isLoading) {
    return (
      <div className="profile-page">
        <div className="profile-loading">
          <h2>Loading your profile...</h2>
        </div>
      </div>
    );
  }

  if (!user) {
    return (
      <div className="profile-page">
        <div className="profile-loading">
          <h2>{message || 'Something went wrong...'}</h2>
          <p>Redirecting to login...</p>
        </div>
      </div>
    );
  }

  // Stats helper functions from ReadingStats
  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { 
      year: 'numeric', 
      month: 'short'
    });
  };

  const getAverageRating = () => {
    if (!stats || !stats.books_with_ratings || stats.books_with_ratings === 0) return 0;
    return parseFloat(stats.library_avg_rating) || 0;
  };

  const getUserPersonalRating = () => {
    if (!stats || !stats.rated_books || stats.rated_books === 0) return 0;
    return parseFloat(stats.user_avg_rating) || 0;
  };

  const getThisYearProgress = () => {
    return stats?.books_read_this_year || 0;
  };

  const getThisYearPages = () => {
    return stats?.pages_read_this_year || 0;
  };

  const getReadingStreak = () => {
    if (!monthlyStats.length) return 0;
    let streak = 0;
    const sortedStats = [...monthlyStats].sort((a, b) => b.month.localeCompare(a.month));
    for (const stat of sortedStats) {
      if (parseInt(stat.books_read) > 0) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  };

  const getTopGenres = () => {
    return genreStats.slice(0, 5);
  };

  const getTopAuthors = () => {
    return authorStats.slice(0, 5);
  };

  const getUserGoal = () => {
    return stats?.reading_goal || 12;
  };

  return (
    <FilterProvider>
      <div className="profile-page">
        <Navbar 
          loggedIn={!isPublicProfile || !!localStorage.getItem('token')} 
          onSearch={handleSearch}
          showFilters={true}
        />
        
        {/* Profile Header */}
        <div className="profile-header-section">
          <div className="profile-container">
            <div className="profile-picture-section">
              <div className="profile-picture">
                {user.profile_picture_url ? (
                  <img src={user.profile_picture_url} alt="Profile" />
                ) : (
                  <div className="profile-initials">{getUserInitials(user)}</div>
                )}
              </div>
              <div className="profile-info">
                <h1 className="profile-name">{getFullName(user)}</h1>
                <p className="profile-username">@{user.username}</p>
                {user.is_moderator && (
                  <p className="profile-moderator-badge">Moderator</p>
                )}
                {user.bio && <p className="profile-bio">{user.bio}</p>}
                
                {/* Only show deactivation status for own profile */}
                {!isPublicProfile && !user.is_active && (
                  <div className="deactivation-status">
                    <div className="deactivation-header">
                      <span className="deactivation-badge">🚫 Account Deactivated</span>
                      {user.days_until_reactivation !== null && user.days_until_reactivation > 0 && (
                        <span className="reactivation-countdown">
                          Reactivates in {user.days_until_reactivation} days
                        </span>
                      )}
                    </div>
                    {user.deactivation_reason && (
                      <div className="deactivation-reason">
                        <strong>Reason:</strong> {user.deactivation_reason}
                      </div>
                    )}
                    {user.deactivated_at && (
                      <div className="deactivation-date">
                        <strong>Deactivated on:</strong> {new Date(user.deactivated_at).toLocaleDateString()}
                      </div>
                    )}
                  </div>
                )}
              </div>
            </div>
            
            {/* Only show actions for own profile */}
            {!isPublicProfile && (
              <div className="profile-actions">
                <button className="edit-profile-btn" onClick={handleEditProfile}>
                  ✏️ Edit Profile
                </button>
                {user.is_moderator && (
                  <button className="moderator-dashboard-btn" onClick={() => navigate('/moderator-dashboard')}>
                    🔧 Moderator Dashboard
                  </button>
                )}
                <button className="logout-btn" onClick={handleLogout}>
                  🚪 Logout
                </button>
              </div>
            )}
          </div>
        </div>

        {/* Main Content Area */}
        <div className="profile-content">
          {/* Sidebar with Reading Stats */}
          <div className="profile-sidebar">
            <div className="sidebar-section">
              <h3>📊 Reading Statistics</h3>
              {stats ? (
                <div className="profile-stats-container">
                  {/* Overview Card */}
                  <div className="profile-stats-card">
                    <div className="stats-card-header">
                      <FaBook className="card-icon" />
                      <h4>Library Overview</h4>
                    </div>
                    <div className="overview-grid">
                      <div className="overview-item">
                        <span className="overview-number">{stats.total_books || 0}</span>
                        <span className="overview-label">Total Books</span>
                      </div>
                      <div className="overview-item">
                        <span className="overview-number">{stats.books_read || 0}</span>
                        <span className="overview-label">Read</span>
                      </div>
                      <div className="overview-item">
                        <span className="overview-number">{stats.currently_reading || 0}</span>
                        <span className="overview-label">Reading</span>
                      </div>
                      <div className="overview-item">
                        <span className="overview-number">{stats.want_to_read || 0}</span>
                        <span className="overview-label">Want to Read</span>
                      </div>
                    </div>
                  </div>

                  {/* This Year Progress */}
                  <div className="profile-stats-card">
                    <div className="stats-card-header">
                      <FaBullseye className="card-icon" />
                      <h4>This Year Progress</h4>
                    </div>
                    <div className="progress-display">
                      <div className="progress-number">
                        <span className="big-stat-number">{getThisYearProgress()}</span>
                        <span className="stat-label">/ {getUserGoal()} books</span>
                      </div>
                      <div className="progress-bar">
                        <div 
                          className="progress-fill" 
                          style={{ width: `${Math.min((getThisYearProgress() / getUserGoal()) * 100, 100)}%` }}
                        ></div>
                      </div>
                      <p className="progress-text">
                        {getThisYearProgress() >= getUserGoal() ? 
                          '🎉 Goal achieved!' : 
                          `${getUserGoal() - getThisYearProgress()} books to go`
                        }</p>
                    </div>
                  </div>

                  {/* Reading Streak */}
                  <div className="profile-stats-card">
                    <div className="stats-card-header">
                      <FaFire className="card-icon" />
                      <h4>Reading Streak</h4>
                    </div>
                    <div className="streak-display">
                      <span className="big-stat-number">{getReadingStreak()}</span>
                      <span className="stat-label">consecutive months</span>
                    </div>
                  </div>

                  {/* Average Rating */}
                  <div className="profile-stats-card">
                    <div className="stats-card-header">
                      <FaStar className="card-icon" />
                      <h4>Average Rating</h4>
                    </div>
                    <div className="rating-content">
                      <div className="rating-display">
                        <span className="big-stat-number">{(getAverageRating() || 0).toFixed(1)}</span>
                        <div className="profile-review-stars">
                          {[1, 2, 3, 4, 5].map(star => (
                            <span 
                              key={star} 
                              className={`star ${star <= getAverageRating() ? 'filled' : 'empty'}`}
                            >⭐</span>
                          ))}
                        </div>
                      </div>
                      <p className="progress-text">
                        Based on {stats?.books_with_ratings || 0} books
                      </p>
                    </div>
                  </div>

                  {/* Top Genres */}
                  <div className="profile-stats-card">
                    <div className="stats-card-header">
                      <FaChartPie className="card-icon" />
                      <h4>Top Genres</h4>
                    </div>
                    <div className="top-items-list">
                      {getTopGenres().map((genre, index) => (
                        <div key={index} className="top-item">
                          <span className="item-name">{genre.genre}</span>
                          <span className="item-count">{genre.book_count}</span>
                        </div>
                      ))}
                      {getTopGenres().length === 0 && (
                        <p className="no-data-text">No genre data available</p>
                      )}
                    </div>
                  </div>

                  {/* Top Authors */}
                  <div className="profile-stats-card">
                    <div className="stats-card-header">
                      <FaUser className="card-icon" />
                      <h4>Top Authors</h4>
                    </div>
                    <div className="top-items-list">
                      {getTopAuthors().map((author, index) => (
                        <div key={index} className="top-item">
                          <span className="item-name">{author.author}</span>
                          <span className="item-count">{author.book_count}</span>
                        </div>
                      ))}
                      {getTopAuthors().length === 0 && (
                        <p className="no-data-text">No author data available</p>
                      )}
                    </div>
                  </div>

                  {/* Pages Read */}
                  <div className="profile-stats-card">
                    <div className="stats-card-header">
                      <FaBookOpen className="card-icon" />
                      <h4>Pages Read</h4>
                    </div>
                    <div className="pages-content">
                      <div className="pages-stats">
                        <div className="stat-item">
                          <span className="stat-number">{stats?.total_pages_read || 0}</span>
                          <span className="stat-label">Total Pages</span>
                        </div>
                        <div className="stat-item">
                          <span className="stat-number">{getThisYearPages()}</span>
                          <span className="stat-label">This Year</span>
                        </div>
                        <div className="stat-item">
                          <span className="stat-number">{Math.round(stats?.avg_pages_per_book || 0)}</span>
                          <span className="stat-label">Avg per Book</span>
                        </div>
                      </div>
                    </div>
                  </div>

                  {/* Only show Quick Actions for own profile */}
                  {!isPublicProfile && (
                    <div className="profile-stats-card">
                      <div className="stats-card-header">
                        <h4>⚡ Quick Actions</h4>
                      </div>
                      <ul className="sidebar-menu">
                        <li onClick={() => navigate('/my-books')}>📚 My Library</li>
                        <li onClick={() => navigate('/my-books/stats')}>📈 Full Stats</li>
                        <li onClick={() => navigate('/')}>🔍 Browse Books</li>
                      </ul>
                    </div>
                  )}
                </div>
              ) : (
                <div className="stats-loading">
                  <p>Loading statistics...</p>
                </div>
              )}
            </div>
          </div>

          {/* Main Feed */}
          <div className="profile-main">
            {/* Books Section */}
            <div className="content-section">
              <div className="section-header">
                <h2>📚 {isPublicProfile ? `${getUserFirstName(user)}'s Books` : 'My Books'}</h2>
                {!isPublicProfile && (
                  <button className="view-all-btn" onClick={() => navigate('/my-books')}>
                    View All
                  </button>
                )}
              </div>
              <div className="books-grid">
                {myBooks.length > 0 ? (
                  myBooks.map((book) => (
                    <BookCard
                      key={book.id}
                      id={book.id}
                      title={book.title}
                      author={book.author}
                      averageRating={book.avg_rating}
                      coverUrl={book.cover_url}
                      userRating={book.user_rating || 0}
                      isRead={book.shelf === 'read'}
                      isInUserLibrary={!isPublicProfile}
                      shelf={book.shelf}
                      isInWishlist={book.shelf === 'want-to-read'}
                      disableActions={isPublicProfile} // Disable actions for public profiles
                    />
                  ))
                ) : (
                  <div className="empty-state">
                    <p>{isPublicProfile ? `${getUserFirstName(user)} hasn't added any books yet.` : 'No books in your library yet. Start building your collection!'}</p>
                    {!isPublicProfile && (
                      <button onClick={() => navigate('/')}>Browse Books</button>
                    )}
                  </div>
                )}
              </div>
            </div>

            {/* Reviews Section */}
            <div className="content-section">
              <div className="section-header">
                <h2>⭐ {isPublicProfile ? `${getUserFirstName(user)}'s Reviews` : 'My Reviews'}</h2>
                {!isPublicProfile && (
                  <button className="view-all-btn">View All</button>
                )}
              </div>
              <div className="reviews-list">
                {reviews.length > 0 ? (
                  reviews.map((review) => (
                    <div key={review.id} className="review-card">
                      <div className="profile-review-header">
                        <img 
                          src={review.cover_image || '/default-book-cover.jpg'} 
                          alt={review.book_title}
                          className="book-cover-mini"
                        />
                        <div className="review-book-info">
                          <h4 className="review-book-title">{review.book_title}</h4>
                          <p className="review-book-author">by {review.author_name}</p>
                          <div className="profile-review-rating">
                            <div className="profile-review-stars">
                              {[1, 2, 3, 4, 5].map((star) => (
                                <span 
                                  key={star} 
                                  className={`star ${star <= review.rating ? 'filled' : 'empty'}`}
                                >
                                  ⭐
                                </span>
                              ))}
                            </div>
                            <span className="profile-review-value">({review.rating}/5)</span>
                          </div>
                        </div>
                        <div className="profile-review-date">
                          {new Date(review.created_at).toLocaleDateString()}
                        </div>
                      </div>
                      <div className="review-content-section">
                        <h5 className="profile-review-title">{review.review_title}</h5>
                        <p className="profile-review-body">{review.body}</p>
                      </div>
                    </div>
                  ))
                ) : (
                  <div className="empty-state">
                    <p>{isPublicProfile ? `${getUserFirstName(user)} hasn't written any reviews yet.` : 'No reviews yet. Share your thoughts on books you\'ve read!'}</p>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>

        {/* Only show Edit Profile Modal for own profile */}
        {!isPublicProfile && isEditing && (
          <div className="modal-overlay" onClick={() => setIsEditing(false)}>
            <div className="modal-content" onClick={(e) => e.stopPropagation()}>
              <h2>Edit Profile</h2>
              <div className="edit-form">
                <div className="form-group">
                  <label>First Name</label>
                  <input
                    type="text"
                    value={editForm.first_name}
                    onChange={(e) => setEditForm({...editForm, first_name: e.target.value})}
                  />
                </div>
                <div className="form-group">
                  <label>Last Name</label>
                  <input
                    type="text"
                    value={editForm.last_name}
                    onChange={(e) => setEditForm({...editForm, last_name: e.target.value})}
                  />
                </div>
                <div className="form-group">
                  <label>Bio</label>
                  <textarea
                    value={editForm.bio}
                    onChange={(e) => setEditForm({...editForm, bio: e.target.value})}
                    rows="4"
                  />
                </div>
                <div className="form-group">
                  <label>Profile Picture URL</label>
                  <input
                    type="url"
                    value={editForm.profile_picture_url}
                    onChange={(e) => setEditForm({...editForm, profile_picture_url: e.target.value})}
                  />
                </div>
                <div className="modal-actions">
                  <button className="cancel-btn" onClick={() => setIsEditing(false)}>
                    Cancel
                  </button>
                  <button className="save-btn" onClick={handleSaveProfile}>
                    Save Changes
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
    </FilterProvider>
  );
};

export default Profile;