// src/App.js
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import Login from './pages/Login';
import IndividualBook from './pages/IndividualBook';
import Signup from './pages/Signup';
import Profile from './pages/Profile';
import Wishlist from './pages/Wishlist';
import SearchResults from './pages/SearchResults';
import AddBook from './pages/AddBook';





function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/search" element={<SearchResults />} /> {/* new route */}
        <Route path="/login" element={<Login />} />
        <Route path="/book/:id" element={<IndividualBook />} />
        <Route path="/signup" element={<Signup />} />
        <Route path="/profile" element={<Profile />} />
        <Route path="/wishlist" element={<Wishlist />} />
        <Route path="/addbook" element={<AddBook />} />
        
      </Routes>
    </Router>
  );
}

export default App;
