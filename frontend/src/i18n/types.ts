import type { HudId } from '../components/navigation/hudRegistry';
import type { NavItemId } from '../components/navigation/navItems';

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
    appearance: {
        title: string;
        subtitle: string;
        summary: (themeLabel: string, hudName: string) => string;
        themeLabel: string;
        themeDark: string;
        themeLight: string;
        hudLabel: string;
        defaultBadge: string;
    };
    language: {
        title: string;
        subtitle: string;
        listLabel: string;
    };
}

export interface Translations {
    common: CommonTranslations;
    navigation: NavigationTranslations;
    pages: PagesTranslations;
    settings: SettingsTranslations;
}