import type { SettingsTranslations } from '../../types';

export const settings: SettingsTranslations = {
  title: 'Ajustes',
  subtitle: (appName) => `Personaliza tu experiencia en ${appName}`,
  backToAccount: 'Volver a Cuenta',
  backToSettings: 'Volver a Ajustes',
  appearance: {
    title: 'Aspecto',
    subtitle: 'Tema visual y barra de navegación',
    summary: (themeLabel, hudName) => `Tema ${themeLabel} · HUD ${hudName}`,
    themeLabel: 'Tema',
    themeDark: 'Oscuro',
    themeLight: 'Claro',
    hudLabel: 'HUD de navegación',
    defaultBadge: 'Default',
  },
  language: {
    title: 'Idioma',
    subtitle: 'Elige el idioma de la interfaz',
    listLabel: 'Idiomas disponibles',
  },
};