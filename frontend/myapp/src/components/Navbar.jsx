// src/components/Navbar.jsx
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { FaUser, FaRegUserCircle } from 'react-icons/fa';
import './Navbar.css';
import SearchBar from './SearchBar';
import { FiFilter } from 'react-icons/fi';

function Navbar({ loggedIn, onSearch, onFilterToggle, hasActiveFilters = false }) {
  const navigate = useNavigate();

  const handleIconClick = () => {
    navigate(loggedIn ? '/profile' : '/login');
  };

  const defaultSearchHandler = (searchTerm) => {
    navigate(`/search?q=${encodeURIComponent(searchTerm)}`);
  };

  const defaultFilterHandler = () => {
    // Default filter behavior - could be enhanced later
    console.log('Filter button clicked');
  };
  
  return (
    <div className="navbar">
      <div className="navbar-logo" onClick={() => navigate('/')}>
        LitLoom
      </div>

      <div className="navbar-center">
        <span onClick={() => navigate('/my-books')}>My Books</span>
        <span onClick={() => navigate('/browse')}>Browse</span>
        <span onClick={() => navigate('/community')}>Community</span>
      </div>

      <div className="navbar-right">
        <div className="search-bar-wrapper">
          <SearchBar onSearch={onSearch || defaultSearchHandler} />
        </div>
        <button 
          className={`navbar-filter-btn ${hasActiveFilters ? 'active' : ''}`} 
          onClick={onFilterToggle || defaultFilterHandler}
        >
          <FiFilter />
          {hasActiveFilters && <div className="filter-active-indicator"></div>}
        </button>
        <button className="navbar-profile-btn" onClick={handleIconClick}>
          {loggedIn ? <FaUser /> : <FaRegUserCircle />}
        </button>
      </div>
    </div>
  );
}

export default Navbar;