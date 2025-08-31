import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import API_URL from '../config/api';
import './Login.css';

const Login = () => {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({ email: '', password: '' });
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState('');
  const [showPassword, setShowPassword] = useState(false);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleLogin = async (e) => {
    e.preventDefault();
    setLoading(true);
    setMessage('');

    try {
      const res = await fetch(`${API_URL}/auth/signin`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData),
      });
      const data = await res.json();

      if (data.success) {
        // Store authentication token (this is what BookCard checks for)
        if (data.token) {
          localStorage.setItem('token', data.token);
          // Alternative: localStorage.setItem('authToken', data.token);
        }
        
        // Store user data (this is what BookCard checks for)
        if (data.user) {
          localStorage.setItem('user', JSON.stringify(data.user));
          // Alternative: localStorage.setItem('userData', JSON.stringify(data.user));
        }
        
        // Keep your existing logic for IndividualBook compatibility
        localStorage.setItem('loggedIn', 'true');
        localStorage.setItem('userId', data.user.id);

        navigate('/');
      } else {
        setMessage(data.message || 'Login failed');
      }
    } catch (err) {
      console.error(err);
      setMessage('Network error.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login-wrapper">
      <div className="login-container">
        <h2>Login to LitLoom</h2>
        {message && <div className="login-message">{message}</div>}

        <form onSubmit={handleLogin}>
          <input
            id="email"
            name="email"
            type="email"
            placeholder="Email"
            value={formData.email}
            onChange={handleChange}
            required
          />

          <input
            id="password"
            name="password"
            type={showPassword ? 'text' : 'password'}
            placeholder="Password"
            value={formData.password}
            onChange={handleChange}
            required
          />

          <div style={{ textAlign: 'right', fontSize: '0.85rem', marginTop: '-0.5rem', marginBottom: '0.5rem' }}>
            <label style={{ cursor: 'pointer' }}>
              <input
                type="checkbox"
                checked={showPassword}
                onChange={() => setShowPassword(!showPassword)}
                style={{ marginRight: '0.3rem' }}
              />
              Show password
            </label>
          </div>

          <button type="submit" disabled={loading}>
            {loading ? 'Logging in...' : 'Login'}
          </button>
        </form>

        <button className="switch-btn" onClick={() => navigate('/signup')}>
          Don't have an account? Sign up
        </button>
      </div>
    </div>
  );
};

export default Login;