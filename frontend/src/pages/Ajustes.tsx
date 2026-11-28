import { useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import {
  ArrowLeft,
  Check,
  ChevronRight,
  Globe,
  Moon,
  Palette,
  Sun,
} from 'lucide-react';
import { useHud } from '../context/HudContext';
import { useI18n } from '../i18n/I18nContext';
import { LANGUAGES } from '../i18n/languages';
import { DEFAULT_HUD_ID, HUD_LIST } from '../components/navigation/hudRegistry';
import { APP_CONFIG } from '../config/appConfig';
import './Ajustes.css';

type SettingsView = 'menu' | 'appearance' | 'language';

export default function Ajustes() {
  const { pathname } = useLocation();
  const navigate = useNavigate();
  const { hudId, activeHud, setHudId, theme, setTheme } = useHud();
  const { language, activeLanguage, setLanguage, t } = useI18n();

  const view: SettingsView = pathname.startsWith('/cuenta/ajustes/aspecto')
    ? 'appearance'
    : pathname.startsWith('/cuenta/ajustes/idioma')
      ? 'language'
      : 'menu';

  useEffect(() => {
    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        navigate(view === 'menu' ? '/cuenta' : '/cuenta/ajustes');
      }
    };
    window.addEventListener('keydown', onKeyDown);
    return () => window.removeEventListener('keydown', onKeyDown);
  }, [view, navigate]);

  // 1. Menú principal de Ajustes (/cuenta/ajustes)
  if (view === 'menu') {
    const themeLabel =
      theme === 'dark'
        ? t.settings.appearance.themeDark
        : t.settings.appearance.themeLight;

    return (
      <div className="ajustes-page ajustes-view-enter" key="settings">
        <header className="ajustes-header">
          <button
            type="button"
            className="ajustes-back-btn"
            onClick={() => navigate('/cuenta')}
            aria-label={t.settings.backToAccount}
            title={t.settings.backToAccount}
          >
            <ArrowLeft size={20} strokeWidth={2} />
          </button>

          <div>
            <h2 className="ajustes-title">{t.settings.title}</h2>
            <p className="ajustes-subtitle">
              {t.settings.subtitle(APP_CONFIG.name)}
            </p>
          </div>
        </header>

        <div className="settings-menu-list">
          {/* Aspecto */}
          <button
            type="button"
            className="settings-menu-item"
            onClick={() => navigate('/cuenta/ajustes/aspecto')}
          >
            <span className="settings-menu-icon">
              <Palette size={20} strokeWidth={2} />
            </span>

            <div className="settings-menu-text">
              <span className="settings-menu-title">
                {t.settings.appearance.title}
              </span>
              <span className="settings-menu-desc">
                {t.settings.appearance.summary(themeLabel, activeHud.name)}
              </span>
            </div>

            <ChevronRight size={18} className="settings-menu-chevron" />
          </button>

          {/* Idioma */}
          <button
            type="button"
            className="settings-menu-item"
            onClick={() => navigate('/cuenta/ajustes/idioma')}
          >
            <span className="settings-menu-icon">
              <Globe size={20} strokeWidth={2} />
            </span>

            <div className="settings-menu-text">
              <span className="settings-menu-title">
                {t.settings.language.title}
              </span>
              <span className="settings-menu-desc">
                {activeLanguage.englishName} · {activeLanguage.nativeName}
              </span>
            </div>

            <ChevronRight size={18} className="settings-menu-chevron" />
          </button>
        </div>
      </div>
    );
  }

  // 2. Subvista de Aspecto (/cuenta/ajustes/aspecto)
  if (view === 'appearance') {
    return (
      <div className="ajustes-page ajustes-view-enter" key="appearance">
        <header className="ajustes-header">
          <button
            type="button"
            className="ajustes-back-btn"
            onClick={() => navigate('/cuenta/ajustes')}
            aria-label={t.settings.backToSettings}
            title={t.settings.backToSettings}
          >
            <ArrowLeft size={20} strokeWidth={2} />
          </button>

          <div>
            <h2 className="ajustes-title">{t.settings.appearance.title}</h2>
            <p className="ajustes-subtitle">
              {t.settings.appearance.subtitle}
            </p>
          </div>
        </header>

        <div className="appearance-content">
          <section className="settings-block">
            <span className="settings-label">
              {t.settings.appearance.themeLabel}
            </span>
            <div
              className="theme-segmented"
              role="radiogroup"
              aria-label={t.settings.appearance.themeLabel}
            >
              <button
                type="button"
                role="radio"
                aria-checked={theme === 'dark'}
                className={`theme-option ${theme === 'dark' ? 'is-selected' : ''}`}
                onClick={() => setTheme('dark')}
              >
                <Moon size={16} />
                <span>{t.settings.appearance.themeDark}</span>
              </button>

              <button
                type="button"
                role="radio"
                aria-checked={theme === 'light'}
                className={`theme-option ${theme === 'light' ? 'is-selected' : ''}`}
                onClick={() => setTheme('light')}
              >
                <Sun size={16} />
                <span>{t.settings.appearance.themeLight}</span>
              </button>
            </div>
          </section>

          <section className="settings-block">
            <div className="settings-label-row">
              <span className="settings-label">
                {t.settings.appearance.hudLabel}
              </span>
              <span className="settings-count">{HUD_LIST.length}</span>
            </div>

            <div
              className="hud-selector-list"
              role="radiogroup"
              aria-label={t.settings.appearance.hudLabel}
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
                          <span className="hud-card-badge">
                            {t.settings.appearance.defaultBadge}
                          </span>
                        )}
                      </div>

                      <span
                        className={`hud-card-check ${isSelected ? 'is-selected' : ''}`}
                      >
                        {isSelected && <Check size={13} strokeWidth={3} />}
                      </span>
                    </div>

                    <p className="hud-card-desc">
                      {t.navigation.huds[hud.id]?.description ?? hud.description}
                    </p>
                  </button>
                );
              })}
            </div>
          </section>
        </div>
      </div>
    );
  }

  // 3. Subvista de Idioma (/cuenta/ajustes/idioma)
  return (
    <div className="ajustes-page ajustes-view-enter" key="language">
      <header className="ajustes-header">
        <button
          type="button"
          className="ajustes-back-btn"
          onClick={() => navigate('/cuenta/ajustes')}
          aria-label={t.settings.backToSettings}
          title={t.settings.backToSettings}
        >
          <ArrowLeft size={20} strokeWidth={2} />
        </button>

        <div>
          <h2 className="ajustes-title">{t.settings.language.title}</h2>
          <p className="ajustes-subtitle">{t.settings.language.subtitle}</p>
        </div>
      </header>

      <div className="appearance-content">
        <section className="settings-block">
          <div className="settings-label-row">
            <span className="settings-label">
              {t.settings.language.listLabel}
            </span>
            <span className="settings-count">{LANGUAGES.length}</span>
          </div>

          <div
            className="lang-selector-list"
            role="radiogroup"
            aria-label={t.settings.language.listLabel}
          >
            {LANGUAGES.map((lang) => {
              const isSelected = lang.code === language;

              return (
                <button
                  key={lang.code}
                  type="button"
                  role="radio"
                  aria-checked={isSelected}
                  className={`lang-card ${isSelected ? 'is-selected' : ''}`}
                  onClick={() => setLanguage(lang.code)}
                >
                  <span className="lang-flag-wrap">{lang.flag}</span>

                  <div className="lang-names">
                    <span className="lang-english">{lang.englishName}</span>
                    <span className="lang-native">{lang.nativeName}</span>
                  </div>

                  <span
                    className={`hud-card-check ${isSelected ? 'is-selected' : ''}`}
                  >
                    {isSelected && <Check size={13} strokeWidth={3} />}
                  </span>
                </button>
              );
            })}
          </div>
        </section>
      </div>
    </div>
  );
}