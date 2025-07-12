// src/pages/Profile.jsx
import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './Profile.css';

const Profile = () => {
  const [user, setUser] = useState(null);
  const [message, setMessage] = useState('');
  const [isLoading, setIsLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchUser = async () => {
      try {
        const token = localStorage.getItem('token');
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
  setIsLoading(false);
} else {
  localStorage.removeItem('token');
  localStorage.removeItem('loggedIn');
  setMessage(data.message || 'Session expired. Please login again.');
  setIsLoading(false);
  setTimeout(() => navigate('/login'), 2000);
}
      } catch (err) {
        localStorage.removeItem('token');
        localStorage.removeItem('loggedIn');
        setMessage('Network error. Please try again.');
        setIsLoading(false);
        console.error(err);
        setTimeout(() => navigate('/login'), 2000);
      }
    };

    fetchUser();
  }, [navigate]);

  const handleLogout = async () => {
    const sidebar = document.querySelector('.profile-sidebar');
    const main = document.querySelector('.profile-main');

    if (sidebar && main) {
      sidebar.style.transform = 'translateX(-100%)';
      main.style.transform = 'translateX(100%)';
      sidebar.style.opacity = '0';
      main.style.opacity = '0';
    }

    // Call backend logout endpoint to update login history
    try {
      const token = localStorage.getItem('token');
      if (token) {
        console.log('Calling logout endpoint...');
        const response = await fetch('http://localhost:3000/auth/logout', {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });
        const data = await response.json();
        console.log('Logout response:', data);
      } else {
        console.log('No token found for logout');
      }
    } catch (error) {
      console.error('Error during logout:', error);
      // Continue with logout even if backend call fails
    }

    setTimeout(() => {
      localStorage.removeItem('token');
      localStorage.removeItem('loggedIn');
      navigate('/');
      window.location.reload();
    }, 500);
  };

  const handleViewWishlist = () => {
    navigate('/wishlist');
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

  const getReadingStats = () => ({
    booksRead: 12,
    currentlyReading: 3,
    toRead: 47,
    reviews: 8,
  });

  if (isLoading) {
    return (
      <div className="profile-page">
        <div className="profile-loading">
          <div>
            <h2>Loading your dashboard...</h2>
            <div className="placeholder-content wide"></div>
            <div className="placeholder-content medium"></div>
            <div className="placeholder-content narrow"></div>
          </div>
        </div>
      </div>
    );
  }

  if (!user) {
    return (
      <div className="profile-page">
        <div className="profile-loading">
          <div>
            <h2>{message || 'Something went wrong...'}</h2>
            <p>Redirecting to login...</p>
          </div>
        </div>
      </div>
    );
  }

  const stats = getReadingStats();

  return (
    <div className="profile-page">
      <div className="profile-container">
        <div className="profile-sidebar">
          <div className="profile-header">
            <div className="profile-avatar">
              {getUserInitials(user)}
            </div>
            <h1 className="profile-name">{getFullName(user)}</h1>
            <p className="profile-username">@{user.username}</p>
          </div>

          <div className="profile-stats">
            <div className="stat-item">
              <span className="stat-number">{stats.booksRead}</span>
              <span className="stat-label">Books Read</span>
            </div>
            <div className="stat-item">
              <span className="stat-number">{stats.currentlyReading}</span>
              <span className="stat-label">Reading</span>
            </div>
            <div className="stat-item">
              <span className="stat-number">{stats.toRead}</span>
              <span className="stat-label">To Read</span>
            </div>
            <div className="stat-item">
              <span className="stat-number">{stats.reviews}</span>
              <span className="stat-label">Reviews</span>
            </div>
          </div>

          <div className="profile-info">
            <div className="info-section">
              <div className="info-title">
                📧 Contact
              </div>
              <div className="info-content">
                {user.email}
              </div>
            </div>

            {user.bio && (
              <div className="info-section">
                <div className="info-title">
                  📝 About
                </div>
                <div className="info-content">
                  {user.bio}
                </div>
              </div>
            )}
          </div>

          <div className="profile-actions">
            <button className="action-btn wishlist-btn" onClick={handleViewWishlist}>
              📚 View Wishlist
            </button>
            <button className="action-btn logout-btn" onClick={handleLogout}>
              🚪 Sign Out
            </button>
          </div>
        </div>

        <div className="profile-main">
          <div className="main-header">
            <h1 className="main-title">Welcome back, {user.first_name || user.username}!</h1>
            <p className="main-subtitle">Here's your reading dashboard</p>
          </div>

          <div className="dashboard-grid">
           {user.is_moderator && (
  <>
    <div className="dashboard-card">
      <div className="card-header">
        <h3 className="card-title">🛡️ Moderator Access</h3>
      </div>
      <div className="card-content">
        <button className="action-btn moderator-btn">
          👑 MODERATOR
        </button>
      </div>
    </div>

    <div className="dashboard-card">
      <div className="card-header">
        <h3 className="card-title">➕ Add Book</h3>
      </div>
      <div className="card-content">
        <button
          className="action-btn add-book-btn"
          onClick={() => navigate('/addbook')}
        >
          ➕ Add Book
        </button>
      </div>
    </div>
  </>
)}


            <div className="dashboard-card">
              <div className="card-header">
                <h3 className="card-title">📖 Currently Reading</h3>
              </div>
              <div className="card-content">
                <p>Your active books will appear here. Start reading to see your progress!</p>
                <div className="placeholder-content wide"></div>
                <div className="placeholder-content medium"></div>
              </div>
            </div>

            <div className="dashboard-card">
              <div className="card-header">
                <h3 className="card-title">🎯 Reading Goals</h3>
              </div>
              <div className="card-content">
                <p>Set and track your reading goals for the year.</p>
                <div className="placeholder-content narrow"></div>
                <div className="placeholder-content wide"></div>
              </div>
            </div>

            <div className="dashboard-card">
              <div className="card-header">
                <h3 className="card-title">⭐ Recent Reviews</h3>
              </div>
              <div className="card-content">
                <p>Your latest book reviews and ratings will be displayed here.</p>
                <div className="placeholder-content medium"></div>
                <div className="placeholder-content wide"></div>
              </div>
            </div>

            <div className="dashboard-card">
              <div className="card-header">
                <h3 className="card-title">📊 Reading Stats</h3>
              </div>
              <div className="card-content">
                <p>Detailed analytics about your reading habits and progress.</p>
                <div className="placeholder-content narrow"></div>
                <div className="placeholder-content medium"></div>
                <div className="placeholder-content wide"></div>
              </div>
            </div>
          </div>

          <div className="coming-soon">
            <h3>🚀 More Features Coming Soon</h3>
            <p>Reading challenges, book recommendations, social features, and much more!</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Profile;
