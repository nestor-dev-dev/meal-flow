import { Routes, Route, Navigate } from 'react-router-dom';
import './App.css';
import Navigation from './components/Navigation';
import Menu from './pages/Menu';
import Feed from './pages/Feed';
import Crear from './pages/Crear';
import Compra from './pages/Compra';
import Cuenta from './pages/Cuenta';

function App() {
  return (
    <div className="app-container">
      <Navigation />

      <main className="main-content">
        <Routes>
          {/* Redirigir la ruta raíz al menú por defecto */}
          <Route path="/" element={<Navigate to="/menu" replace />} />
          
          <Route path="/menu" element={<Menu />} />
          <Route path="/feed" element={<Feed />} />
          <Route path="/crear" element={<Crear />} />
          <Route path="/compra" element={<Compra />} />
          <Route path="/cuenta" element={<Cuenta />} />
        </Routes>
      </main>
    </div>
  );
}

export default App;