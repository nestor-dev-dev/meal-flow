import type { SettingsTranslations } from '../../types';

export const settings: SettingsTranslations = {
  title: 'Settings',
  subtitle: (appName) => `Customize your ${appName} experience`,
  backToAccount: 'Back to Account',
  backToSettings: 'Back to Settings',
  appearance: {
    title: 'Appearance',
    subtitle: 'Visual theme and navigation bar',
    summary: (themeLabel, hudName) => `${themeLabel} theme · ${hudName} HUD`,
    themeLabel: 'Theme',
    themeDark: 'Dark',
    themeLight: 'Light',
    hudLabel: 'Navigation HUD',
    defaultBadge: 'Default',
  },
  language: {
    title: 'Language',
    subtitle: 'Choose the interface language',
    listLabel: 'Available languages',
  },
};