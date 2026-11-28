import type { HudId } from '../components/navigation/hudRegistry';
import type { NavItemId } from '../components/navigation/navItems';
import type { IconPackId } from '../components/navigation/iconPacks';

export interface CommonTranslations {
    tagline: string;
    description: string;
}

export interface NavigationTranslations {
    items: Record<NavItemId, string>;
    settingsLabel: string;
    ariaMain: string;
    expandSidebar: string;
    collapseSidebar: string;
    huds: Record<HudId, { description: string }>;
}

export interface PagesTranslations {
    menu: { title: string; subtitle: string };
    feed: { title: string; subtitle: string };
    crear: { title: string; subtitle: string };
    compra: { title: string; subtitle: string };
    cuenta: {
        title: string;
        subtitle: string;
        openSettings: string;
    };
}

export interface SettingsTranslations {
  title: string;
  subtitle: (appName: string) => string;
  backToAccount: string;
  backToSettings: string;
  comingSoon: string;
  account: {
    title: string;
    subtitle: string;
    desc: string;
    privacyTitle: string;
    privacyDesc: string;
    privacySubtitle: string;
  };
  language: {
    title: string;
    subtitle: string;
    listLabel: string;
  };
  appearance: {
    title: string;
    subtitle: string;
    summary: (themeLabel: string, hudName: string) => string;
    themeLabel: string;
    themeDark: string;
    themeLight: string;
    hudLabel: string;
    defaultBadge: string;
    iconsLabel: string;
    iconPacks: Record<IconPackId, string>;
    colorsLabel: string;
    resetColors: string;
  };
  dietary: {
    title: string;
    subtitle: string;
    desc: string;
    badge: string;
  };
  units: {
    title: string;
    subtitle: string;
    desc: string;
    systemLabel: string;
    metric: string;
    imperial: string;
    weightLabel: string;
    volumeLabel: string;
    tempLabel: string;
    previewNote: string;
  };
  notifications: {
    title: string;
    subtitle: string;
    desc: string;
  };
  about: {
    title: string;
    subtitle: string;
    desc: string;
    githubTitle: string;
    githubDesc: string;
    openRepo: string;
  };
}

export interface Translations {
    common: CommonTranslations;
    navigation: NavigationTranslations;
    pages: PagesTranslations;
    settings: SettingsTranslations;
}