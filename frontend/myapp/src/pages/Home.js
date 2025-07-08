import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { FaUser, FaRegUserCircle } from 'react-icons/fa';
import './Home.css';
import Homescroll from '../components/Homescroll';


function Home() {
  const navigate = useNavigate();
  const [sections, setSections] = useState([]);
  const [loggedIn, setLoggedIn] = useState(false); // 🔑 login state

  useEffect(() => {
    const initializeHome = async () => {
      // ✅ Check login status from localStorage
      const isLoggedIn = localStorage.getItem('loggedIn') === 'true';
      setLoggedIn(isLoggedIn);

      // ✅ Fetch homepage book sections
      try {
        const res = await fetch('http://localhost:3000/');
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

    initializeHome();
  }, []);

  const handleIconClick = () => {
    if (loggedIn) navigate('/profile');
    else navigate('/login');
  };

  const handleSearch = async (query) => {
    try {
      const res = await fetch(`http://localhost:3000/search?q=${encodeURIComponent(query)}`);
      const data = await res.json();

      if (!data.success || !data.books) throw new Error('Invalid search response');

      setSections([{ title: `Search Results for "${query}"`, books: data.books }]);
    } catch (err) {
      console.error('❌ Error during search:', err.message);
    }
  };

  return (
    <div className="home-hero">
      <div className="home-header">
        <h1 className="home-logo">LitLoom</h1>
        <button
          className="home-login-btn icon-only"
          onClick={handleIconClick}
          title={loggedIn ? 'Profile' : 'Login'}
        >
          {loggedIn ? <FaRegUserCircle /> : <FaUser />}
        </button>
      </div>

      

      {sections.map((section, index) => (
        <Homescroll key={index} title={section.title} books={section.books} />
      ))}
    </div>
  );
}

export default Home;