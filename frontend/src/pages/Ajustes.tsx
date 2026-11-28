import { useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import {
  ArrowLeft,
  Bell,
  Check,
  ChevronRight,
  ExternalLink,
  Globe,
  Info,
  Moon,
  Palette,
  RotateCcw,
  Ruler,
  Salad,
  Shield,
  Sun,
  UserCog,
} from 'lucide-react';
import {
  DEFAULT_NAV_COLORS,
  useHud,
  type NavColorKey,
} from '../context/HudContext';
import { useI18n } from '../i18n/I18nContext';
import { LANGUAGES } from '../i18n/languages';
import { DEFAULT_HUD_ID, HUD_LIST } from '../components/navigation/hudRegistry';
import {
  DEFAULT_ICON_PACK_ID,
  ICON_PACK_LIST,
} from '../components/navigation/iconPacks';
import { APP_CONFIG } from '../config/appConfig';
import './Ajustes.css';

type SettingsView =
  | 'menu'
  | 'account'
  | 'privacy'
  | 'language'
  | 'appearance'
  | 'dietary'
  | 'units'
  | 'notifications'
  | 'about';

const COLOR_KEYS: NavColorKey[] = [
  'menu',
  'feed',
  'compra',
  'crear',
  'cuenta',
  'ajustes',
];

function GithubMark() {
  return (
    <svg
      viewBox="0 0 24 24"
      width="24"
      height="24"
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M12 .5C5.65.5.5 5.65.5 12c0 5.08 3.29 9.39 7.86 10.91.58.11.79-.25.79-.56 0-.28-.01-1.02-.02-2-3.2.7-3.88-1.54-3.88-1.54-.52-1.33-1.28-1.68-1.28-1.68-1.05-.72.08-.7.08-.7 1.16.08 1.77 1.19 1.77 1.19 1.03 1.76 2.7 1.25 3.36.96.1-.75.4-1.25.73-1.54-2.55-.29-5.24-1.28-5.24-5.68 0-1.25.45-2.28 1.19-3.08-.12-.29-.52-1.46.11-3.05 0 0 .97-.31 3.17 1.18a11.02 11.02 0 0 1 5.78 0c2.2-1.49 3.17-1.18 3.17-1.18.63 1.59.23 2.76.11 3.05.74.8 1.19 1.83 1.19 3.08 0 4.41-2.69 5.39-5.26 5.67.41.36.78 1.06.78 2.14 0 1.55-.01 2.8-.01 3.18 0 .31.21.68.8.56A11.51 11.51 0 0 0 23.5 12C23.5 5.65 18.35.5 12 .5Z" />
    </svg>
  );
}

export default function Ajustes() {
  const { pathname } = useLocation();
  const navigate = useNavigate();
  const {
    hudId,
    activeHud,
    setHudId,
    theme,
    setTheme,
    iconPackId,
    setIconPackId,
    navColors,
    setNavColor,
    resetNavColors,
  } = useHud();
  const { language, activeLanguage, setLanguage, t } = useI18n();

  const view: SettingsView = pathname.startsWith('/cuenta/ajustes/cuenta/privacidad')
    ? 'privacy'
    : pathname.startsWith('/cuenta/ajustes/cuenta')
      ? 'account'
      : pathname.startsWith('/cuenta/ajustes/idioma')
        ? 'language'
        : pathname.startsWith('/cuenta/ajustes/aspecto')
          ? 'appearance'
          : pathname.startsWith('/cuenta/ajustes/alimentacion')
            ? 'dietary'
            : pathname.startsWith('/cuenta/ajustes/unidades')
              ? 'units'
              : pathname.startsWith('/cuenta/ajustes/notificaciones')
                ? 'notifications'
                : pathname.startsWith('/cuenta/ajustes/acerca')
                  ? 'about'
                  : 'menu';

  useEffect(() => {
    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key !== 'Escape') return;
      if (view === 'menu') navigate('/cuenta');
      else if (view === 'privacy') navigate('/cuenta/ajustes/cuenta');
      else navigate('/cuenta/ajustes');
    };
    window.addEventListener('keydown', onKeyDown);
    return () => window.removeEventListener('keydown', onKeyDown);
  }, [view, navigate]);

  const isDefaultColors = COLOR_KEYS.every(
    (k) => navColors[k].toLowerCase() === DEFAULT_NAV_COLORS[k].toLowerCase(),
  );

  // =========================================================================
  // 1. MENÚ PRINCIPAL DE AJUSTES (/cuenta/ajustes)
  // =========================================================================
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
          {/* 1. Cuenta */}
          <button
            type="button"
            className="settings-menu-item"
            onClick={() => navigate('/cuenta/ajustes/cuenta')}
          >
            <span className="settings-menu-icon">
              <UserCog size={20} strokeWidth={2} />
            </span>
            <div className="settings-menu-text">
              <span className="settings-menu-title">
                {t.settings.account.title}
              </span>
              <span className="settings-menu-desc">
                {t.settings.account.desc}
              </span>
            </div>
            <ChevronRight size={18} className="settings-menu-chevron" />
          </button>

          {/* 2. Idioma */}
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

          {/* 3. Aspecto */}
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

          {/* 4. Configuración alimentaria (Resaltado con glowing) */}
          <button
            type="button"
            className="settings-menu-item is-featured-dietary"
            onClick={() => navigate('/cuenta/ajustes/alimentacion')}
          >
            <span className="settings-menu-icon is-featured-icon">
              <Salad size={20} strokeWidth={2} />
            </span>
            <div className="settings-menu-text">
              <div className="settings-menu-title-row">
                <span className="settings-menu-title">
                  {t.settings.dietary.title}
                </span>
                <span className="dietary-badge">
                  {t.settings.dietary.badge}
                </span>
              </div>
              <span className="settings-menu-desc">
                {t.settings.dietary.desc}
              </span>
            </div>
            <ChevronRight size={18} className="settings-menu-chevron" />
          </button>

          {/* 5. Unidades métricas */}
          <button
            type="button"
            className="settings-menu-item"
            onClick={() => navigate('/cuenta/ajustes/unidades')}
          >
            <span className="settings-menu-icon">
              <Ruler size={20} strokeWidth={2} />
            </span>
            <div className="settings-menu-text">
              <span className="settings-menu-title">
                {t.settings.units.title}
              </span>
              <span className="settings-menu-desc">
                {t.settings.units.desc}
              </span>
            </div>
            <ChevronRight size={18} className="settings-menu-chevron" />
          </button>

          {/* 6. Notificaciones */}
          <button
            type="button"
            className="settings-menu-item"
            onClick={() => navigate('/cuenta/ajustes/notificaciones')}
          >
            <span className="settings-menu-icon">
              <Bell size={20} strokeWidth={2} />
            </span>
            <div className="settings-menu-text">
              <span className="settings-menu-title">
                {t.settings.notifications.title}
              </span>
              <span className="settings-menu-desc">
                {t.settings.notifications.desc}
              </span>
            </div>
            <ChevronRight size={18} className="settings-menu-chevron" />
          </button>

          {/* 7. Acerca de */}
          <button
            type="button"
            className="settings-menu-item"
            onClick={() => navigate('/cuenta/ajustes/acerca')}
          >
            <span className="settings-menu-icon">
              <Info size={20} strokeWidth={2} />
            </span>
            <div className="settings-menu-text">
              <span className="settings-menu-title">
                {t.settings.about.title}
              </span>
              <span className="settings-menu-desc">
                {t.settings.about.desc}
              </span>
            </div>
            <ChevronRight size={18} className="settings-menu-chevron" />
          </button>
        </div>
      </div>
    );
  }

  // =========================================================================
  // 2. CUENTA -> PRIVACIDAD Y SEGURIDAD
  // =========================================================================
  if (view === 'account') {
    return (
      <div className="ajustes-page ajustes-view-enter" key="account">
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
            <h2 className="ajustes-title">{t.settings.account.title}</h2>
            <p className="ajustes-subtitle">{t.settings.account.subtitle}</p>
          </div>
        </header>

        <div className="settings-menu-list">
          <button
            type="button"
            className="settings-menu-item"
            onClick={() => navigate('/cuenta/ajustes/cuenta/privacidad')}
          >
            <span className="settings-menu-icon">
              <Shield size={20} strokeWidth={2} />
            </span>
            <div className="settings-menu-text">
              <span className="settings-menu-title">
                {t.settings.account.privacyTitle}
              </span>
              <span className="settings-menu-desc">
                {t.settings.account.privacyDesc}
              </span>
            </div>
            <ChevronRight size={18} className="settings-menu-chevron" />
          </button>
        </div>
      </div>
    );
  }

  if (view === 'privacy') {
    return (
      <div className="ajustes-page ajustes-view-enter" key="privacy">
        <header className="ajustes-header">
          <button
            type="button"
            className="ajustes-back-btn"
            onClick={() => navigate('/cuenta/ajustes/cuenta')}
            aria-label={t.settings.account.title}
            title={t.settings.account.title}
          >
            <ArrowLeft size={20} strokeWidth={2} />
          </button>

          <div>
            <h2 className="ajustes-title">{t.settings.account.privacyTitle}</h2>
            <p className="ajustes-subtitle">
              {t.settings.account.privacySubtitle}
            </p>
          </div>
        </header>

        <div className="settings-empty-card">
          <Shield size={24} strokeWidth={1.8} />
          <p>{t.settings.comingSoon}</p>
        </div>
      </div>
    );
  }

  // =========================================================================
  // 3. IDIOMA
  // =========================================================================
  if (view === 'language') {
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

  // =========================================================================
  // 4. ASPECTO (Tema + HUD + Iconos 2x2 + Colores)
  // =========================================================================
  if (view === 'appearance') {
    const getColorLabel = (key: NavColorKey): string =>
      key === 'ajustes'
        ? t.navigation.settingsLabel
        : t.navigation.items[key];

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
          {/* 4.1 Tema Claro / Oscuro */}
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

          {/* 4.2 HUD de navegación */}
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

          {/* 4.3 Iconos (Grid 2x2) */}
          <section className="settings-block">
            <div className="settings-label-row">
              <span className="settings-label">
                {t.settings.appearance.iconsLabel}
              </span>
              <span className="settings-count">{ICON_PACK_LIST.length}</span>
            </div>

            <div
              className="icon-pack-grid"
              role="radiogroup"
              aria-label={t.settings.appearance.iconsLabel}
            >
              {ICON_PACK_LIST.map((pack) => {
                const isSelected = pack.id === iconPackId;
                const isDefault = pack.id === DEFAULT_ICON_PACK_ID;
                const PreviewMenu = pack.icons.menu;
                const PreviewFeed = pack.icons.feed;
                const PreviewCompra = pack.icons.compra;
                const PreviewCuenta = pack.icons.cuenta;
                const PreviewAjustes = pack.icons.ajustes;

                return (
                  <button
                    key={pack.id}
                    type="button"
                    role="radio"
                    aria-checked={isSelected}
                    className={`icon-pack-card ${isSelected ? 'is-selected' : ''}`}
                    onClick={() => setIconPackId(pack.id)}
                  >
                    <div className="hud-card-top">
                      <div className="hud-card-title-row">
                        <span className="hud-card-name">
                          {t.settings.appearance.iconPacks[pack.id]}
                        </span>
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

                    <div className="icon-pack-preview" aria-hidden="true">
                      <span className="icon-pack-chip">
                        <PreviewMenu size={17} strokeWidth={2} />
                      </span>
                      <span className="icon-pack-chip">
                        <PreviewFeed size={17} strokeWidth={2} />
                      </span>
                      <span className="icon-pack-chip">
                        <PreviewCompra size={17} strokeWidth={2} />
                      </span>
                      <span className="icon-pack-chip">
                        <PreviewCuenta size={17} strokeWidth={2} />
                      </span>
                      <span className="icon-pack-chip">
                        <PreviewAjustes size={17} strokeWidth={2} />
                      </span>
                    </div>
                  </button>
                );
              })}
            </div>
          </section>

          {/* 4.4 Colores personalizables + Restaurar default */}
          <section className="settings-block">
            <div className="settings-label-row">
              <span className="settings-label">
                {t.settings.appearance.colorsLabel}
              </span>

              <button
                type="button"
                className="colors-reset-btn"
                onClick={resetNavColors}
                disabled={isDefaultColors}
              >
                <RotateCcw size={13} strokeWidth={2.2} />
                <span>{t.settings.appearance.resetColors}</span>
              </button>
            </div>

            <div className="color-picker-grid">
              {COLOR_KEYS.map((key) => {
                const value = navColors[key];
                const label = getColorLabel(key);

                return (
                  <label key={key} className="color-picker-card">
                    <div className="color-picker-info">
                      <span className="color-picker-name">{label}</span>
                      <span className="color-picker-hex">
                        {value.toUpperCase()}
                      </span>
                    </div>

                    <span
                      className="color-swatch-wrap"
                      style={{ backgroundColor: value }}
                    >
                      <input
                        type="color"
                        className="color-native-input"
                        value={value}
                        onChange={(e) => setNavColor(key, e.target.value)}
                        aria-label={label}
                      />
                    </span>
                  </label>
                );
              })}
            </div>
          </section>
        </div>
      </div>
    );
  }

  // =========================================================================
  // 5. CONFIGURACIÓN ALIMENTARIA (Vacía de momento)
  // =========================================================================
  if (view === 'dietary') {
    return (
      <div className="ajustes-page ajustes-view-enter" key="dietary">
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
            <h2 className="ajustes-title">{t.settings.dietary.title}</h2>
            <p className="ajustes-subtitle">{t.settings.dietary.subtitle}</p>
          </div>
        </header>

        <div className="settings-empty-card is-dietary">
          <Salad size={24} strokeWidth={1.8} />
          <p>{t.settings.comingSoon}</p>
        </div>
      </div>
    );
  }

  // =========================================================================
  // 6. UNIDADES MÉTRICAS (Solo interfaz visual, sin lógica ni guardado aún)
  // =========================================================================
  if (view === 'units') {
    return (
      <div className="ajustes-page ajustes-view-enter" key="units">
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
            <h2 className="ajustes-title">{t.settings.units.title}</h2>
            <p className="ajustes-subtitle">{t.settings.units.subtitle}</p>
          </div>
        </header>

        <div className="appearance-content">
          <section className="settings-block">
            <span className="settings-label">
              {t.settings.units.systemLabel}
            </span>
            <div className="theme-segmented is-preview-only">
              <button type="button" className="theme-option is-selected">
                {t.settings.units.metric}
              </button>
              <button type="button" className="theme-option">
                {t.settings.units.imperial}
              </button>
            </div>
          </section>

          <section className="settings-block">
            <span className="settings-label">
              {t.settings.units.weightLabel}
            </span>
            <div className="theme-segmented is-preview-only">
              <button type="button" className="theme-option is-selected">
                g / kg
              </button>
              <button type="button" className="theme-option">
                oz / lb
              </button>
            </div>
          </section>

          <section className="settings-block">
            <span className="settings-label">
              {t.settings.units.volumeLabel}
            </span>
            <div className="theme-segmented is-preview-only">
              <button type="button" className="theme-option is-selected">
                ml / L
              </button>
              <button type="button" className="theme-option">
                fl oz / cups
              </button>
            </div>
          </section>

          <section className="settings-block">
            <span className="settings-label">
              {t.settings.units.tempLabel}
            </span>
            <div className="theme-segmented is-preview-only">
              <button type="button" className="theme-option is-selected">
                °C
              </button>
              <button type="button" className="theme-option">
                °F
              </button>
            </div>
          </section>

          <p className="settings-preview-note">
            {t.settings.units.previewNote}
          </p>
        </div>
      </div>
    );
  }

  // =========================================================================
  // 7. NOTIFICACIONES (Vacía de momento)
  // =========================================================================
  if (view === 'notifications') {
    return (
      <div className="ajustes-page ajustes-view-enter" key="notifications">
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
            <h2 className="ajustes-title">{t.settings.notifications.title}</h2>
            <p className="ajustes-subtitle">
              {t.settings.notifications.subtitle}
            </p>
          </div>
        </header>

        <div className="settings-empty-card">
          <Bell size={24} strokeWidth={1.8} />
          <p>{t.settings.comingSoon}</p>
        </div>
      </div>
    );
  }

  // =========================================================================
  // 8. ACERCA DE (Tarjeta de GitHub conectada a appConfig.ts)
  // =========================================================================
  return (
    <div className="ajustes-page ajustes-view-enter" key="about">
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
          <h2 className="ajustes-title">{t.settings.about.title}</h2>
          <p className="ajustes-subtitle">{t.settings.about.subtitle}</p>
        </div>
      </header>

      <div className="appearance-content">
        <a
          href={APP_CONFIG.githubRepoUrl}
          target="_blank"
          rel="noopener noreferrer"
          className="about-github-card"
        >
          <div className="about-github-top">
            <span className="about-github-icon">
              <GithubMark />
            </span>

            <div className="about-github-head">
              <span className="about-github-title">
                {t.settings.about.githubTitle}
              </span>
              <span className="about-github-url">
                {APP_CONFIG.githubRepoUrl.replace(/^https?:\/\//, '')}
              </span>
            </div>

            <ExternalLink size={17} className="about-github-ext" />
          </div>

          <p className="about-github-desc">{t.settings.about.githubDesc}</p>

          <span className="about-github-cta">{t.settings.about.openRepo}</span>
        </a>
      </div>
    </div>
  );
}