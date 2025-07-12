import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './Home.css';
import Homescroll from '../components/Homescroll';
import Navbar from '../components/Navbar';
import '../components/Navbar.css';
import FilterBar from '../components/FilterBar';



function Home() {
  const navigate = useNavigate();

  const [sections, setSections] = useState([]);
  const [loggedIn, setLoggedIn] = useState(false);
  const [isFilterOpen, setIsFilterOpen] = useState(false);
  
  // Updated filters state to use arrays for multi-select
  const [filters, setFilters] = useState({
    language: [],
    genre: [],
    author: [],
    publisher: [],
    country: [],
    pubDateRange: [1800, 2025],
    ratingRange: [0, 5]
  });

  // Check if any filters are active
  const hasActiveFilters = () => {
    return (
      filters.language.length > 0 ||
      filters.genre.length > 0 ||
      filters.author.length > 0 ||
      filters.publisher.length > 0 ||
      filters.country.length > 0 ||
      (filters.pubDateRange && (filters.pubDateRange[0] !== 1800 || filters.pubDateRange[1] !== 2025)) ||
      (filters.ratingRange && (filters.ratingRange[0] !== 0 || filters.ratingRange[1] !== 5))
    );
  };

  // Toggle filter bar
  const toggleFilters = () => setIsFilterOpen(prev => !prev);

  useEffect(() => {
    // ✅ Check login state
    const isLoggedIn = localStorage.getItem('loggedIn') === 'true';
    setLoggedIn(isLoggedIn);

    // ✅ Fetch homepage sections
    const fetchSections = async () => {
      try {
        // Check if user is logged in and get token
        const token = localStorage.getItem('token') || localStorage.getItem('authToken');
        
        const headers = {
          'Content-Type': 'application/json'
        };
        
        // Add authorization header if token exists
        if (token) {
          headers['Authorization'] = `Bearer ${token}`;
        }

        const res = await fetch('http://localhost:3000/', { headers });
        const data = await res.json();
        if (!data.success || !data.data) throw new Error('Invalid response format');

        const sectionsArray = Object.values(data.data).map((section) => ({
          title: section.title,
          books: section.books,
        }));

        setSections(sectionsArray);
      } catch (err) {
        console.error('❌ Error fetching homepage data:', err.message);
      }
    };

    fetchSections();
  }, []);

  // REMOVED: The conflicting filter options fetch - FilterBar will handle this

  const handleSearch = (query) => {
    if (query.trim()) {
      navigate(`/search?q=${encodeURIComponent(query.trim())}`);
    }
  };

  return (
    <div className="home-hero">
      <Navbar 
        loggedIn={loggedIn} 
        onSearch={handleSearch} 
        onFilterToggle={toggleFilters}
        hasActiveFilters={hasActiveFilters()}
      />

      {/* Filter container positioned right after navbar */}
      <div className="filter-container">
        <FilterBar
          filters={filters}
          setFilters={setFilters}
          isOpen={isFilterOpen}
          setIsOpen={setIsFilterOpen}
        />
      </div>

      <div className="home-content">
        {/* ✅ Render all book sections (no filtering applied on home page) */}
        {sections.map((section, index) => (
          <Homescroll key={index} title={section.title} books={section.books} />
        ))}
      </div>
    </div>
  );
}

export default Home;