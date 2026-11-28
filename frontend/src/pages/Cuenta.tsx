import { useEffect, useState } from 'react';
import {
    ArrowLeft,
    Check,
    ChevronRight,
    Moon,
    Palette,
    Settings,
    Sun,
} from 'lucide-react';
import { useHud } from '../context/HudContext';
import { DEFAULT_HUD_ID, HUD_LIST } from '../components/navigation/hudRegistry';
import './Cuenta.css';

type CuentaView = 'profile' | 'settings' | 'appearance';

export default function Cuenta() {
    const [view, setView] = useState<CuentaView>('profile');
    const { hudId, activeHud, setHudId, theme, setTheme } = useHud();

    // Permitir volver atrás con la tecla Escape
    useEffect(() => {
        if (view === 'profile') return;
        const onKeyDown = (e: KeyboardEvent) => {
            if (e.key === 'Escape') {
                setView((prev) => (prev === 'appearance' ? 'settings' : 'profile'));
            }
        };
        window.addEventListener('keydown', onKeyDown);
        return () => window.removeEventListener('keydown', onKeyDown);
    }, [view]);

    // 1. Vista principal de Cuenta
    if (view === 'profile') {
        return (
            <div className="cuenta-page cuenta-view-enter" key="profile">
                <header className="cuenta-header">
                    <div>
                        <h2 className="cuenta-title">Cuenta</h2>
                        <p className="cuenta-subtitle">Aquí irá la configuración de la cuenta.</p>
                    </div>

                    <button
                        type="button"
                        className="cuenta-icon-btn"
                        onClick={() => setView('settings')}
                        aria-label="Abrir ajustes"
                        title="Ajustes"
                    >
                        <Settings size={20} strokeWidth={2} />
                    </button>
                </header>
            </div>
        );
    }

    // 2. Vista de Ajustes (menú principal de categorías)
    if (view === 'settings') {
        const themeLabel = theme === 'dark' ? 'Oscuro' : 'Claro';

        return (
            <div className="cuenta-page cuenta-view-enter" key="settings">
                <header className="subpage-header">
                    <button
                        type="button"
                        className="cuenta-icon-btn"
                        onClick={() => setView('profile')}
                        aria-label="Volver a Cuenta"
                        title="Volver"
                    >
                        <ArrowLeft size={20} strokeWidth={2} />
                    </button>

                    <div>
                        <h2 className="cuenta-title">Ajustes</h2>
                        <p className="cuenta-subtitle">Personaliza tu experiencia en mealFlow</p>
                    </div>
                </header>

                <div className="settings-menu-list">
                    <button
                        type="button"
                        className="settings-menu-item"
                        onClick={() => setView('appearance')}
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

                    {/* Aquí iremos añadiendo el resto de botones de ajustes (Notificaciones, Alergias, Privacidad...) */}
                </div>
            </div>
        );
    }

    // 3. Subvista de Aspecto (Tema + Selector dinámico de HUDs)
    return (
        <div className="cuenta-page cuenta-view-enter" key="appearance">
            <header className="subpage-header">
                <button
                    type="button"
                    className="cuenta-icon-btn"
                    onClick={() => setView('settings')}
                    aria-label="Volver a Ajustes"
                    title="Volver a Ajustes"
                >
                    <ArrowLeft size={20} strokeWidth={2} />
                </button>

                <div>
                    <h2 className="cuenta-title">Aspecto</h2>
                    <p className="cuenta-subtitle">Tema visual y barra de navegación</p>
                </div>
            </header>

            <div className="appearance-content">
                {/* Tema Claro / Oscuro */}
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

                {/* Selector dinámico de HUDs */}
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