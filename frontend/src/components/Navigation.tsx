import { NavLink } from "react-router-dom";
import "./Navigation.css";

export default function Navigation() {
    return (
        <nav className="nav-container">
            <NavLink to="/menu" className="nav-item item-menu">
                <span className="nav-icon">📅</span>
                <span className="nav-text">Menú</span>
            </NavLink>

            <NavLink to="/feed" className="nav-item item-feed">
                <span className="nav-icon">🔥</span>
                <span className="nav-text">Feed</span>
            </NavLink>

            <NavLink to="/crear" className="nav-item item-crear">
                <div className="nav-fab">
                    {/* SVG vectorial: cruz centrada matemáticamente al milímetro */}
                    <svg className="fab-plus-icon" viewBox="0 0 24 24">
                        <path d="M12 5v14M5 12h14" />
                    </svg>
                </div>
                <span className="nav-text text-crear">Crear</span>
            </NavLink>

            <NavLink to="/compra" className="nav-item item-compra">
                <span className="nav-icon">🛒</span>
                <span className="nav-text">Compra</span>
            </NavLink>

            <NavLink to="/cuenta" className="nav-item item-cuenta">
                <span className="nav-icon">👤</span>
                <span className="nav-text">Cuenta</span>
            </NavLink>
        </nav>
    );
}
