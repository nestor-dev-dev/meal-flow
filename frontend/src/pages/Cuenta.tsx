import { useNavigate } from 'react-router-dom';
import { Settings } from 'lucide-react';
import './Cuenta.css';

export default function Cuenta() {
    const navigate = useNavigate();

    return (
        <div className="cuenta-page">
            <header className="cuenta-header">
                <div>
                    <h2 className="cuenta-title">Cuenta</h2>
                    <p className="cuenta-subtitle">Aquí irá la configuración de la cuenta.</p>
                </div>

                <button
                    type="button"
                    className="cuenta-settings-btn"
                    onClick={() => navigate('/cuenta/ajustes')}
                    aria-label="Abrir ajustes"
                    title="Ajustes"
                >
                    <Settings size={20} strokeWidth={2} />
                </button>
            </header>
        </div>
    );
}