import { useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import {
    ArrowLeft,
    Check,
    ChevronRight,
    Moon,
    Palette,
    Sun,
} from 'lucide-react';
import { useHud } from '../context/HudContext';
import { DEFAULT_HUD_ID, HUD_LIST } from '../components/navigation/hudRegistry';
import './Ajustes.css';
import { APP_CONFIG } from '../config/appConfig';

export default function Ajustes() {
    const { pathname } = useLocation();
    const navigate = useNavigate();
    const { hudId, activeHud, setHudId, theme, setTheme } = useHud();

    const isAppearance = pathname.startsWith('/cuenta/ajustes/aspecto');

    // Volver atrás con la tecla Escape
    useEffect(() => {
        const onKeyDown = (e: KeyboardEvent) => {
            if (e.key === 'Escape') {
                navigate(isAppearance ? '/cuenta/ajustes' : '/cuenta');
            }
        };
        window.addEventListener('keydown', onKeyDown);
        return () => window.removeEventListener('keydown', onKeyDown);
    }, [isAppearance, navigate]);

    // 1. Menú principal de Ajustes (/cuenta/ajustes)
    if (!isAppearance) {
        const themeLabel = theme === 'dark' ? 'Oscuro' : 'Claro';

        return (
            <div className="ajustes-page ajustes-view-enter" key="settings">
                <header className="ajustes-header">
                    <button
                        type="button"
                        className="ajustes-back-btn"
                        onClick={() => navigate('/cuenta')}
                        aria-label="Volver a Cuenta"
                        title="Volver"
                    >
                        <ArrowLeft size={20} strokeWidth={2} />
                    </button>

                    <div>
                        <h2 className="ajustes-title">Ajustes</h2>
                        <p className="ajustes-subtitle">
                            Personaliza tu experiencia en {APP_CONFIG.name}
                        </p>
                    </div>
                </header>

                <div className="settings-menu-list">
                    <button
                        type="button"
                        className="settings-menu-item"
                        onClick={() => navigate('/cuenta/ajustes/aspecto')}
                    >
                        <span className="settings-menu-icon">
                            <Palette size={20} strokeWidth={2} />
                        </span>

                        <div className="settings-menu-text">
                            <span className="settings-menu-title">Aspecto</span>
                            <span className="settings-menu-desc">
                                Tema {themeLabel} · HUD {activeHud.name}
                            </span>
                        </div>

                        <ChevronRight size={18} className="settings-menu-chevron" />
                    </button>
                </div>
            </div>
        );
    }

    // 2. Subvista de Aspecto (/cuenta/ajustes/aspecto)
    return (
        <div className="ajustes-page ajustes-view-enter" key="appearance">
            <header className="ajustes-header">
                <button
                    type="button"
                    className="ajustes-back-btn"
                    onClick={() => navigate('/cuenta/ajustes')}
                    aria-label="Volver a Ajustes"
                    title="Volver a Ajustes"
                >
                    <ArrowLeft size={20} strokeWidth={2} />
                </button>

                <div>
                    <h2 className="ajustes-title">Aspecto</h2>
                    <p className="ajustes-subtitle">Tema visual y barra de navegación</p>
                </div>
            </header>

            <div className="appearance-content">
                <section className="settings-block">
                    <span className="settings-label">Tema</span>
                    <div
                        className="theme-segmented"
                        role="radiogroup"
                        aria-label="Tema de la aplicación"
                    >
                        <button
                            type="button"
                            role="radio"
                            aria-checked={theme === 'dark'}
                            className={`theme-option ${theme === 'dark' ? 'is-selected' : ''}`}
                            onClick={() => setTheme('dark')}
                        >
                            <Moon size={16} />
                            <span>Oscuro</span>
                        </button>

                        <button
                            type="button"
                            role="radio"
                            aria-checked={theme === 'light'}
                            className={`theme-option ${theme === 'light' ? 'is-selected' : ''}`}
                            onClick={() => setTheme('light')}
                        >
                            <Sun size={16} />
                            <span>Claro</span>
                        </button>
                    </div>
                </section>

                <section className="settings-block">
                    <div className="settings-label-row">
                        <span className="settings-label">HUD de navegación</span>
                        <span className="settings-count">{HUD_LIST.length}</span>
                    </div>

                    <div
                        className="hud-selector-list"
                        role="radiogroup"
                        aria-label="Estilo de navegación"
                    >
                        {HUD_LIST.map((hud) => {
                            const isSelected = hud.id === hudId;
                            const isDefault = hud.id === DEFAULT_HUD_ID;

                            return (
                                <button
                                    key={hud.id}
                                    type="button"
                                    role="radio"
                                    aria-checked={isSelected}
                                    className={`hud-card ${isSelected ? 'is-selected' : ''}`}
                                    onClick={() => setHudId(hud.id)}
                                >
                                    <div className="hud-card-top">
                                        <div className="hud-card-title-row">
                                            <span className="hud-card-name">{hud.name}</span>
                                            {isDefault && (
                                                <span className="hud-card-badge">Default</span>
                                            )}
                                        </div>

                                        <span
                                            className={`hud-card-check ${isSelected ? 'is-selected' : ''}`}
                                        >
                                            {isSelected && <Check size={13} strokeWidth={3} />}
                                        </span>
                                    </div>

                                    <p className="hud-card-desc">{hud.description}</p>
                                </button>
                            );
                        })}
                    </div>
                </section>
            </div>
        </div>
    );
}