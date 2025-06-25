import React, { useEffect } from 'react';

export default function MoviesList() {
  useEffect(() => {
    console.log('🎬 MoviesList component mounted');

    const fetchMovies = async () => {
      try {
        const res = await fetch('http://localhost:3000/'); // updated path
        if (!res.ok) throw new Error('Failed to fetch movies');
        const data = await res.json();
        console.log('🎬 Received from backend:', data);
      } catch (err) {
        console.error('❌ Error fetching movies:', err);
      }
    };

    fetchMovies();
  }, []);

  return (
    <div>
      <p>Check your browser console (F12) for movie data.</p>
    </div>
  );
}
