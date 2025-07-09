import React, { useEffect, useState } from 'react';
import { useLocation } from 'react-router-dom';
import Homescroll from '../components/Homescroll';

function useQuery() {
  return new URLSearchParams(useLocation().search);
}

function SearchResults() {
  const query = useQuery().get('q') || '';
  const [sections, setSections] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!query.trim()) {
      setSections([]);
      return;
    }

    const fetchResults = async () => {
      setLoading(true);
      try {
        const res = await fetch(`http://localhost:3000/search?q=${encodeURIComponent(query)}`);
        const data = await res.json();

        if (data.success && data.books) {
          setSections([{ title: `Search Results for "${query}"`, books: data.books }]);
        } else {
          setSections([]);
        }
      } catch (err) {
        console.error('Error fetching search results:', err);
        setSections([]);
      } finally {
        setLoading(false);
      }
    };

    fetchResults();
  }, [query]);

  return (
    <div className="home-hero">
      <h2 style={{ color: 'white', marginBottom: '1.5rem' }}>
        Search Results for &quot;{query}&quot;
      </h2>

      {loading && <p style={{ color: 'white' }}>Loading...</p>}

      {!loading && sections.length === 0 && <p style={{ color: 'white' }}>No results found.</p>}

      {sections.map((section, i) => (
        <Homescroll key={i} title={section.title} books={section.books} />
      ))}
    </div>
  );
}

export default SearchResults;
