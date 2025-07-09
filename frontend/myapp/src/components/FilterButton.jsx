import React from 'react';
import './FilterButton.css';

function FilterButton({ onClick, hasActiveFilters = false }) {
  return (
    <button className={`filter-button ${hasActiveFilters ? 'active' : ''}`} onClick={onClick}>
      <svg 
        className="filter-icon" 
        viewBox="0 0 24 24" 
        fill="none" 
        stroke="currentColor" 
        strokeWidth="2"
      >
        <path d="M3 4h18v2l-6 6v8l-4-2v-6l-6-6z"/>
      </svg>
      <span>Filter</span>
      {hasActiveFilters && <div className="active-indicator"></div>}
    </button>
  );
}

export default FilterButton;