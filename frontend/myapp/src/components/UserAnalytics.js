// src/components/UserAnalytics.js
import React, { useState, useEffect } from 'react';
import {
  BarChart, Bar, LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer,
  PieChart, Pie, Cell, AreaChart, Area
} from 'recharts';
import './Analytics.css';

const UserAnalytics = ({ activeTab, onUserClick }) => {
  const [loading, setLoading] = useState(true);
  const [data, setData] = useState([]);
  const [summary, setSummary] = useState({});
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');

  const COLORS = ['#4299e1', '#9f7aea', '#ed64a6', '#fbbf24', '#10b981', '#f59e0b', '#8b5cf6', '#06b6d4'];

  useEffect(() => {
    fetchData();
  }, [activeTab, startDate, endDate]);

  const fetchData = async () => {
    setLoading(true);
    try {
      const token = localStorage.getItem('token');
      const headers = {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      };

      const params = new URLSearchParams();
      if (startDate) params.append('startDate', startDate);
      if (endDate) params.append('endDate', endDate);

      let endpoint = '';
      switch (activeTab) {
        case 'user-activity':
          endpoint = '/analytics/user-activity-time';
          break;
        case 'user-engagement':
          endpoint = '/analytics/user-engagement';
          break;
        case 'user-base':
          endpoint = '/analytics/user-base-overview';
          break;
      }

      const response = await fetch(`http://localhost:3000${endpoint}?${params}`, { headers });
      const result = await response.json();

      if (result.success) {
        if (activeTab === 'user-base') {
          setData(result.users || []);
          setSummary(result.summary || {});
        } else {
          setData(result.data || []);
        }
      } else {
        console.error('Failed to fetch data:', result.message);
      }
    } catch (error) {
      console.error('Error fetching data:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleUserClick = async (userId) => {
    if (onUserClick) {
      onUserClick(userId);
    }
  };

  const renderUserActivityChart = () => {
    if (loading) return <div className="loading-spinner">Loading user activity data...</div>;

    const chartData = data.map(item => ({
      hour: `${item.hour}:00`,
      loginCount: item.login_count,
      uniqueUsers: item.unique_users,
      displayHour: item.hour
    }));

    return (
      <div style={{ width: '100%', height: 400 }}>
        <ResponsiveContainer>
          <AreaChart data={chartData}>
            <CartesianGrid strokeDasharray="3 3" stroke="rgba(255,255,255,0.1)" />
            <XAxis 
              dataKey="hour" 
              tick={{ fill: '#e2e8f0', fontSize: 12 }}
              axisLine={{ stroke: '#4299e1' }}
            />
            <YAxis 
              tick={{ fill: '#e2e8f0', fontSize: 12 }}
              axisLine={{ stroke: '#4299e1' }}
            />
            <Tooltip 
              contentStyle={{
                backgroundColor: '#1a1f24',
                border: '1px solid #4299e1',
                borderRadius: '8px',
                color: '#e2e8f0'
              }}
            />
            <Legend wrapperStyle={{ color: '#e2e8f0' }} />
            <Area 
              type="monotone" 
              dataKey="loginCount" 
              stackId="1"
              stroke="#4299e1" 
              fill="url(#colorGradient1)" 
              name="Total Logins"
            />
            <Area 
              type="monotone" 
              dataKey="uniqueUsers" 
              stackId="2"
              stroke="#9f7aea" 
              fill="url(#colorGradient2)" 
              name="Unique Users"
            />
            <defs>
              <linearGradient id="colorGradient1" x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor="#4299e1" stopOpacity={0.8}/>
                <stop offset="95%" stopColor="#4299e1" stopOpacity={0.3}/>
              </linearGradient>
              <linearGradient id="colorGradient2" x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor="#9f7aea" stopOpacity={0.8}/>
                <stop offset="95%" stopColor="#9f7aea" stopOpacity={0.3}/>
              </linearGradient>
            </defs>
          </AreaChart>
        </ResponsiveContainer>
      </div>
    );
  };

  const renderUserEngagementChart = () => {
    if (loading) return <div className="loading-spinner">Loading engagement data...</div>;

    const top10Users = data.slice(0, 10);

    return (
      <div style={{ width: '100%', height: 400 }}>
        <ResponsiveContainer>
          <BarChart data={top10Users}>
            <CartesianGrid strokeDasharray="3 3" stroke="rgba(255,255,255,0.1)" />
            <XAxis 
              dataKey="username" 
              tick={{ fill: '#e2e8f0', fontSize: 12 }}
              axisLine={{ stroke: '#4299e1' }}
              angle={-45}
              textAnchor="end"
              height={100}
            />
            <YAxis 
              tick={{ fill: '#e2e8f0', fontSize: 12 }}
              axisLine={{ stroke: '#4299e1' }}
            />
            <Tooltip 
              contentStyle={{
                backgroundColor: '#1a1f24',
                border: '1px solid #4299e1',
                borderRadius: '8px',
                color: '#e2e8f0'
              }}
            />
            <Legend wrapperStyle={{ color: '#e2e8f0' }} />
            <Bar 
              dataKey="engagement_score" 
              fill="url(#engagementGradient)" 
              name="Engagement Score"
              radius={[4, 4, 0, 0]}
            />
            <defs>
              <linearGradient id="engagementGradient" x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor="#fbbf24" stopOpacity={0.8}/>
                <stop offset="95%" stopColor="#f59e0b" stopOpacity={0.6}/>
              </linearGradient>
            </defs>
          </BarChart>
        </ResponsiveContainer>
      </div>
    );
  };

  const renderLeaderboard = () => {
    if (loading) return <div className="loading-spinner">Loading leaderboard...</div>;

    return (
      <div className="leaderboard-container">
        <h3>🏆 Top Contributors</h3>
        <div className="leaderboard-list">
          {data.slice(0, 10).map((user, index) => (
            <div 
              key={user.id} 
              className={`leaderboard-item ${index < 3 ? 'podium' : ''}`}
              onClick={() => handleUserClick(user.id)}
            >
              <div className="rank">
                {index === 0 ? '🥇' : index === 1 ? '🥈' : index === 2 ? '🥉' : `#${index + 1}`}
              </div>
              <div className="user-info">
                <div className="username">{user.username}</div>
                <div className="user-stats">
                  <span className="stat">📝 {user.reviews} reviews</span>
                  <span className="stat">💬 {user.comments} comments</span>
                  <span className="stat">👍 {user.votes} votes</span>
                </div>
              </div>
              <div className="engagement-score">
                <span className="score">{user.engagement_score}</span>
                <span className="label">pts</span>
              </div>
            </div>
          ))}\n        </div>
      </div>
    );
  };

  const renderUserBaseOverview = () => {
    if (loading) return <div className="loading-spinner">Loading user base data...</div>;

    return (
      <div className="user-base-container">
        <div className="user-summary-grid">
          <div className="summary-stat">
            <div className="stat-icon">👥</div>
            <div className="stat-info">
              <div className="stat-value">{summary.total_users || 0}</div>
              <div className="stat-label">Total Users</div>
            </div>
          </div>
          <div className="summary-stat">
            <div className="stat-icon">🟢</div>
            <div className="stat-info">
              <div className="stat-value">{summary.active_users || 0}</div>
              <div className="stat-label">Active Users</div>
            </div>
          </div>
          <div className="summary-stat">
            <div className="stat-icon">🔴</div>
            <div className="stat-info">
              <div className="stat-value">{summary.inactive_users || 0}</div>
              <div className="stat-label">Inactive Users</div>
            </div>
          </div>
          <div className="summary-stat">
            <div className="stat-icon">🆕</div>
            <div className="stat-info">
              <div className="stat-value">{summary.new_users_week || 0}</div>
              <div className="stat-label">New This Week</div>
            </div>
          </div>
        </div>

        <div className="user-list-container">
          <h3>👤 User Details</h3>
          <div className="user-list">
            {data.map(user => (
              <div 
                key={user.id} 
                className={`user-item ${user.active_status ? 'active' : 'inactive'}`}
                onClick={() => handleUserClick(user.id)}
              >
                <div className="user-avatar">
                  {user.first_name ? user.first_name.charAt(0) : user.username.charAt(0)}
                </div>
                <div className="user-details">
                  <div className="user-name">
                    {user.first_name && user.last_name 
                      ? `${user.first_name} ${user.last_name}` 
                      : user.username}
                  </div>
                  <div className="user-email">{user.email}</div>
                  <div className="user-meta">
                    <span className="joined">Joined: {new Date(user.created_at).toLocaleDateString()}</span>
                    {user.last_login && (
                      <span className="last-login">
                        Last login: {new Date(user.last_login).toLocaleDateString()}
                      </span>
                    )}
                  </div>
                </div>
                <div className="user-status">
                  <span className={`status-badge ${user.active_status ? 'active' : 'inactive'}`}>
                    {user.active_status ? 'Active' : 'Inactive'}
                  </span>
                  <span className="login-count">{user.login_count} logins</span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    );
  };

  const renderChart = () => {
    switch (activeTab) {
      case 'user-activity':
        return renderUserActivityChart();
      case 'user-engagement':
        return renderUserEngagementChart();
      case 'user-base':
        return renderUserBaseOverview();
      default:
        return <div>Select a tab to view analytics</div>;
    }
  };

  const renderSideContent = () => {
    if (activeTab === 'user-engagement') {
      return renderLeaderboard();
    }
    return null;
  };

  return (
    <div className="user-analytics-container">
      <div className="analytics-controls">
        <div className="filter-controls">
          <div className="date-filter">
            <label>Start Date:</label>
            <input 
              type="date" 
              value={startDate} 
              onChange={(e) => setStartDate(e.target.value)} 
            />
          </div>
          <div className="date-filter">
            <label>End Date:</label>
            <input 
              type="date" 
              value={endDate} 
              onChange={(e) => setEndDate(e.target.value)} 
            />
          </div>
          <div className="refresh-controls">
            <button className="refresh-btn" onClick={fetchData} disabled={loading}>
              🔄 Refresh
            </button>
          </div>
        </div>
      </div>

      <div className="analytics-content">
        <div className="chart-container">
          {renderChart()}
        </div>
        
        {renderSideContent() && (
          <div className="analytics-sidebar">
            {renderSideContent()}
          </div>
        )}
      </div>
    </div>
  );
};

export default UserAnalytics;