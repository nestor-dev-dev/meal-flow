import { Routes, Route, Navigate } from 'react-router-dom';
import './App.css';
import Navigation from './components/navigation/Navigation';
import Menu from './pages/Menu';
import Feed from './pages/Feed';
import Crear from './pages/Crear';
import Compra from './pages/Compra';
import Cuenta from './pages/Cuenta';
import Ajustes from './pages/Ajustes';
import { useEffect } from 'react';
import { APP_CONFIG } from './config/appConfig';

function App() {
  useEffect(() => {
    document.title = APP_CONFIG.name;
  }, []);
  return (
    <div className="app-container">
      <Navigation />

      <main className="main-content">
        <Routes>
          <Route path="/" element={<Navigate to="/menu" replace />} />

          <Route path="/menu" element={<Menu />} />
          <Route path="/feed" element={<Feed />} />
          <Route path="/crear" element={<Crear />} />
          <Route path="/compra" element={<Compra />} />
          <Route path="/cuenta" element={<Cuenta />} />
          <Route path="/cuenta/ajustes/*" element={<Ajustes />} />
        </Routes>
      </main>
    </div>
  );
}

export default App;