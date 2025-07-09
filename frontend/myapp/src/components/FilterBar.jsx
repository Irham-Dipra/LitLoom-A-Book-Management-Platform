import React, { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import './FilterBar.css';

function FilterBar({ filters, setFilters, isOpen, setIsOpen }) {
  const navigate = useNavigate();
  
  // State for filter options from API
  const [filterOptions, setFilterOptions] = useState({
    languages: [],
    genres: [],
    authors: [],
    publishers: [],
    countries: [],
    dateRange: { min: 1800, max: 2025 },
    ratingRange: { min: 0, max: 5 }
  });

  // State for loading filter options
  const [optionsLoading, setOptionsLoading] = useState(false);
  const [optionsError, setOptionsError] = useState(null);
  
  // State for search terms in each category
  const [searchTerms, setSearchTerms] = useState({
    language: '',
    genre: '',
    author: '',
    publisher: '',
    country: ''
  });

  // Fetch filter options from API
  const fetchFilterOptions = useCallback(async () => {
    if (optionsLoading) return; // Prevent multiple simultaneous requests
    
    setOptionsLoading(true);
    setOptionsError(null);
    
    try {
      const response = await fetch('http://localhost:3000/filter-options');
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      const result = await response.json();
      
      if (result.success && result.data) {
        setFilterOptions(result.data);
        
        // Initialize filters with default ranges if not already set
        setFilters(prev => ({
          ...prev,
          pubDateRange: prev.pubDateRange || [result.data.dateRange.min, result.data.dateRange.max],
          ratingRange: prev.ratingRange || [result.data.ratingRange.min, result.data.ratingRange.max]
        }));
      } else {
        throw new Error(result.message || 'Failed to fetch filter options');
      }
    } catch (error) {
      console.error('Error fetching filter options:', error);
      setOptionsError('Failed to load filter options. Please try again.');
    } finally {
      setOptionsLoading(false);
    }
  }, [optionsLoading, setFilters]);

  useEffect(() => {
    if (isOpen && filterOptions.languages.length === 0) {
      fetchFilterOptions();
    }
  }, [isOpen, filterOptions.languages.length, fetchFilterOptions]);

  // Handle search input changes
  const handleSearchChange = useCallback((field) => (e) => {
    setSearchTerms(prev => ({ ...prev, [field]: e.target.value }));
  }, []);

  // Handle multi-select checkbox changes
  const handleCheckboxChange = useCallback((field, value) => {
    setFilters(prev => {
      const currentSelection = prev[field] || [];
      const newSelection = currentSelection.includes(value)
        ? currentSelection.filter(item => item !== value)
        : [...currentSelection, value];
      
      return { ...prev, [field]: newSelection };
    });
  }, [setFilters]);

  // Handle range inputs (two inputs for min and max)
  const handleRangeChange = useCallback((field, index) => (e) => {
    const val = Number(e.target.value);
    setFilters(prev => {
      const currentRange = prev[field] || [null, null];
      const newRange = [...currentRange];
      newRange[index] = val;
      return { ...prev, [field]: newRange };
    });
  }, [setFilters]);

  // Handle slider changes for rating
  const handleRatingSliderChange = useCallback((index) => (e) => {
    const val = Number(e.target.value);
    setFilters(prev => {
      const currentRange = prev.ratingRange || [filterOptions.ratingRange.min, filterOptions.ratingRange.max];
      const newRange = [...currentRange];
      newRange[index] = val;
      return { ...prev, ratingRange: newRange };
    });
  }, [setFilters, filterOptions.ratingRange]);

  // Handle slider changes for publication date
  const handleDateSliderChange = useCallback((index) => (e) => {
    const val = Number(e.target.value);
    setFilters(prev => {
      const currentRange = prev.pubDateRange || [filterOptions.dateRange.min, filterOptions.dateRange.max];
      const newRange = [...currentRange];
      newRange[index] = val;
      return { ...prev, pubDateRange: newRange };
    });
  }, [setFilters, filterOptions.dateRange]);

  // Filter options based on search terms
  const getFilteredOptions = useCallback((field) => {
    const searchTerm = searchTerms[field].toLowerCase();
    const optionsArray = filterOptions[field === 'country' ? 'countries' : `${field}s`] || [];
    
    return optionsArray.filter(option => 
      option.label && option.label.toLowerCase().includes(searchTerm)
    );
  }, [searchTerms, filterOptions]);

  // Clear all filters
  const clearAllFilters = useCallback(() => {
    setFilters({
      language: [],
      genre: [],
      author: [],
      publisher: [],
      country: [],
      pubDateRange: [filterOptions.dateRange.min, filterOptions.dateRange.max],
      ratingRange: [filterOptions.ratingRange.min, filterOptions.ratingRange.max]
    });
    setSearchTerms({
      language: '',
      genre: '',
      author: '',
      publisher: '',
      country: ''
    });
  }, [setFilters, filterOptions]);

  // Handle filter search - navigate to SearchResults with filter parameters
  const handleFilterSearch = useCallback(() => {
    const params = new URLSearchParams();
    
    // Add active filters to URL params
    if (filters.language && filters.language.length > 0) {
      params.append('language', filters.language.join(','));
    }
    if (filters.genre && filters.genre.length > 0) {
      params.append('genre', filters.genre.join(','));
    }
    if (filters.author && filters.author.length > 0) {
      params.append('author', filters.author.join(','));
    }
    if (filters.publisher && filters.publisher.length > 0) {
      params.append('publisher', filters.publisher.join(','));
    }
    if (filters.country && filters.country.length > 0) {
      params.append('country', filters.country.join(','));
    }
    if (filters.pubDateRange && (filters.pubDateRange[0] !== filterOptions.dateRange.min || filters.pubDateRange[1] !== filterOptions.dateRange.max)) {
      params.append('pubDateFrom', filters.pubDateRange[0]);
      params.append('pubDateTo', filters.pubDateRange[1]);
    }
    if (filters.ratingRange && (filters.ratingRange[0] !== filterOptions.ratingRange.min || filters.ratingRange[1] !== filterOptions.ratingRange.max)) {
      params.append('ratingFrom', filters.ratingRange[0]);
      params.append('ratingTo', filters.ratingRange[1]);
    }
    
    // Add a filter indicator
    params.append('filtered', 'true');
    
    // Navigate to search results with filter parameters
    navigate(`/search?${params.toString()}`);
    
    // Close the filter bar
    setIsOpen(false);
  }, [filters, filterOptions, navigate, setIsOpen]);

  // Check if any filters are applied
  const hasActiveFilters = useCallback(() => {
    return (
      (filters.language && filters.language.length > 0) ||
      (filters.genre && filters.genre.length > 0) ||
      (filters.author && filters.author.length > 0) ||
      (filters.publisher && filters.publisher.length > 0) ||
      (filters.country && filters.country.length > 0) ||
      (filters.pubDateRange && (filters.pubDateRange[0] !== filterOptions.dateRange.min || filters.pubDateRange[1] !== filterOptions.dateRange.max)) ||
      (filters.ratingRange && (filters.ratingRange[0] !== filterOptions.ratingRange.min || filters.ratingRange[1] !== filterOptions.ratingRange.max))
    );
  }, [filters, filterOptions]);

  // Render a multi-select filter section
  const renderMultiSelectFilter = useCallback((field, title) => {
    const filteredOptions = getFilteredOptions(field);
    const selectedValues = filters[field] || [];
    
    return (
      <div className="filter-section" key={field}>
        <h3>{title}</h3>
        <div className="search-box">
          <input
            type="text"
            placeholder={`Search ${title.toLowerCase()}...`}
            value={searchTerms[field]}
            onChange={handleSearchChange(field)}
            className="search-input"
          />
        </div>
        <div className="checkbox-container">
          {optionsLoading ? (
            <div className="loading">Loading {title.toLowerCase()}...</div>
          ) : optionsError ? (
            <div className="error">Error loading {title.toLowerCase()}</div>
          ) : filteredOptions.length > 0 ? (
            filteredOptions.map(option => (
              <label key={option.value} className="checkbox-label">
                <input
                  type="checkbox"
                  checked={selectedValues.includes(option.value)}
                  onChange={() => handleCheckboxChange(field, option.value)}
                />
                <span className="checkbox-text">{option.label}</span>
              </label>
            ))
          ) : (
            <div className="no-options">
              {searchTerms[field] ? `No ${title.toLowerCase()} found matching "${searchTerms[field]}"` : `No ${title.toLowerCase()} available`}
            </div>
          )}
        </div>
      </div>
    );
  }, [filters, searchTerms, optionsLoading, optionsError, getFilteredOptions, handleSearchChange, handleCheckboxChange]);

  if (!isOpen) return null;

  return (
    <div className="filter-bar">
      <div className="filter-header">
        <h2>Filter Books</h2>
        <div className="filter-actions">
          <button className="clear-btn" onClick={clearAllFilters}>
            Clear All
          </button>
          <button className="close-btn" onClick={() => setIsOpen(false)}>
            ×
          </button>
        </div>
      </div>

      <div className="filter-content">
        {optionsError ? (
          <div className="error-container">
            <p>{optionsError}</p>
            <button onClick={fetchFilterOptions}>Retry</button>
          </div>
        ) : (
          <>
            <div className="filter-grid">
              {renderMultiSelectFilter('language', 'Languages')}
              {renderMultiSelectFilter('genre', 'Genres')}
              {renderMultiSelectFilter('author', 'Authors')}
              {renderMultiSelectFilter('publisher', 'Publishers')}
              {renderMultiSelectFilter('country', 'Original Countries')}
            </div>

            <div className="range-filters">
              <div className="range-section">
                <h3>Publication Date Range</h3>
                <div className="range-slider-container">
                  <div className="slider-group">
                    <label>From: {filters.pubDateRange ? filters.pubDateRange[0] || filterOptions.dateRange.min : filterOptions.dateRange.min}</label>
                    <input
                      type="range"
                      min={filterOptions.dateRange.min}
                      max={filterOptions.dateRange.max}
                      value={filters.pubDateRange ? filters.pubDateRange[0] || filterOptions.dateRange.min : filterOptions.dateRange.min}
                      onChange={handleDateSliderChange(0)}
                      className="range-slider"
                    />
                  </div>
                  <div className="slider-group">
                    <label>To: {filters.pubDateRange ? filters.pubDateRange[1] || filterOptions.dateRange.max : filterOptions.dateRange.max}</label>
                    <input
                      type="range"
                      min={filterOptions.dateRange.min}
                      max={filterOptions.dateRange.max}
                      value={filters.pubDateRange ? filters.pubDateRange[1] || filterOptions.dateRange.max : filterOptions.dateRange.max}
                      onChange={handleDateSliderChange(1)}
                      className="range-slider"
                    />
                  </div>
                </div>
                <div className="range-inputs">
                  <div className="range-input-group">
                    <label>From:</label>
                    <input
                      type="number"
                      min={filterOptions.dateRange.min}
                      max={filterOptions.dateRange.max}
                      value={filters.pubDateRange ? filters.pubDateRange[0] || filterOptions.dateRange.min : filterOptions.dateRange.min}
                      onChange={handleRangeChange('pubDateRange', 0)}
                      className="range-input"
                    />
                  </div>
                  <div className="range-input-group">
                    <label>To:</label>
                    <input
                      type="number"
                      min={filterOptions.dateRange.min}
                      max={filterOptions.dateRange.max}
                      value={filters.pubDateRange ? filters.pubDateRange[1] || filterOptions.dateRange.max : filterOptions.dateRange.max}
                      onChange={handleRangeChange('pubDateRange', 1)}
                      className="range-input"
                    />
                  </div>
                </div>
              </div>

              <div className="range-section">
                <h3>Average Rating Range</h3>
                <div className="range-slider-container">
                  <div className="slider-group">
                    <label>From: {filters.ratingRange ? (filters.ratingRange[0] || filterOptions.ratingRange.min).toFixed(1) : filterOptions.ratingRange.min.toFixed(1)}</label>
                    <input
                      type="range"
                      min={filterOptions.ratingRange.min}
                      max={filterOptions.ratingRange.max}
                      step={0.1}
                      value={filters.ratingRange ? filters.ratingRange[0] || filterOptions.ratingRange.min : filterOptions.ratingRange.min}
                      onChange={handleRatingSliderChange(0)}
                      className="range-slider"
                    />
                  </div>
                  <div className="slider-group">
                    <label>To: {filters.ratingRange ? (filters.ratingRange[1] || filterOptions.ratingRange.max).toFixed(1) : filterOptions.ratingRange.max.toFixed(1)}</label>
                    <input
                      type="range"
                      min={filterOptions.ratingRange.min}
                      max={filterOptions.ratingRange.max}
                      step={0.1}
                      value={filters.ratingRange ? filters.ratingRange[1] || filterOptions.ratingRange.max : filterOptions.ratingRange.max}
                      onChange={handleRatingSliderChange(1)}
                      className="range-slider"
                    />
                  </div>
                </div>
                <div className="range-inputs">
                  <div className="range-input-group">
                    <label>From:</label>
                    <input
                      type="number"
                      min={filterOptions.ratingRange.min}
                      max={filterOptions.ratingRange.max}
                      step={0.1}
                      value={filters.ratingRange ? filters.ratingRange[0] || filterOptions.ratingRange.min : filterOptions.ratingRange.min}
                      onChange={handleRangeChange('ratingRange', 0)}
                      className="range-input"
                    />
                  </div>
                  <div className="range-input-group">
                    <label>To:</label>
                    <input
                      type="number"
                      min={filterOptions.ratingRange.min}
                      max={filterOptions.ratingRange.max}
                      step={0.1}
                      value={filters.ratingRange ? filters.ratingRange[1] || filterOptions.ratingRange.max : filterOptions.ratingRange.max}
                      onChange={handleRangeChange('ratingRange', 1)}
                      className="range-input"
                    />
                  </div>
                </div>
              </div>
            </div>

            {/* Filter Search Button */}
            <div className="filter-search-section">
              <button 
                className="filter-search-btn" 
                onClick={handleFilterSearch}
                disabled={!hasActiveFilters()}
              >
                Search with Filters
              </button>
            </div>
          </>
        )}
      </div>
    </div>
  );
}

export default FilterBar;