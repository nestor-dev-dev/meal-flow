import {
  createContext,
  useContext,
  useEffect,
  useState,
  type ReactNode,
} from 'react';
import {
  DEFAULT_HUD_ID,
  HUD_REGISTRY,
  isValidHudId,
  type HudDefinition,
  type HudId,
} from '../components/navigation/hudRegistry';
import {
  DEFAULT_ICON_PACK_ID,
  ICON_PACK_REGISTRY,
  isValidIconPackId,
  type IconPackDefinition,
  type IconPackId,
} from '../components/navigation/iconPacks';
import type { NavItemId } from '../components/navigation/navItems';

const HUD_STORAGE_KEY = 'mealflow_hud_id';
const THEME_STORAGE_KEY = 'mealflow_theme';
const ICON_PACK_STORAGE_KEY = 'mealflow_icon_pack_id';
const COLORS_STORAGE_KEY = 'mealflow_nav_colors';

export type ThemeMode = 'dark' | 'light';
export type NavColorKey = NavItemId | 'ajustes';
export type NavColorMap = Record<NavColorKey, string>;

export const DEFAULT_NAV_COLORS: NavColorMap = {
  menu: '#c4f22c',
  feed: '#f97316',
  compra: '#06b6d4',
  crear: '#3b82f6',
  cuenta: '#a855f7',
  ajustes: '#fb678c',
};

function loadSavedColors(): NavColorMap {
  try {
    const raw = localStorage.getItem(COLORS_STORAGE_KEY);
    if (!raw) return { ...DEFAULT_NAV_COLORS };
    const parsed = JSON.parse(raw) as Partial<NavColorMap>;
    return {
      menu: parsed.menu ?? DEFAULT_NAV_COLORS.menu,
      feed: parsed.feed ?? DEFAULT_NAV_COLORS.feed,
      compra: parsed.compra ?? DEFAULT_NAV_COLORS.compra,
      crear: parsed.crear ?? DEFAULT_NAV_COLORS.crear,
      cuenta: parsed.cuenta ?? DEFAULT_NAV_COLORS.cuenta,
      ajustes: parsed.ajustes ?? DEFAULT_NAV_COLORS.ajustes,
    };
  } catch {
    return { ...DEFAULT_NAV_COLORS };
  }
}

interface HudContextValue {
  hudId: HudId;
  activeHud: HudDefinition;
  setHudId: (id: HudId) => void;
  theme: ThemeMode;
  setTheme: (theme: ThemeMode) => void;
  iconPackId: IconPackId;
  activeIconPack: IconPackDefinition;
  setIconPackId: (id: IconPackId) => void;
  navColors: NavColorMap;
  setNavColor: (key: NavColorKey, hex: string) => void;
  resetNavColors: () => void;
}

const HudContext = createContext<HudContextValue | null>(null);

export function HudProvider({ children }: { children: ReactNode }) {
  const [hudId, setHudIdState] = useState<HudId>(() => {
    const saved = localStorage.getItem(HUD_STORAGE_KEY);
    return isValidHudId(saved) ? saved : DEFAULT_HUD_ID;
  });

  const [theme, setThemeState] = useState<ThemeMode>(() => {
    const saved = localStorage.getItem(THEME_STORAGE_KEY);
    return saved === 'light' || saved === 'dark' ? saved : 'dark';
  });

  const [iconPackId, setIconPackIdState] = useState<IconPackId>(() => {
    const saved = localStorage.getItem(ICON_PACK_STORAGE_KEY);
    return isValidIconPackId(saved) ? saved : DEFAULT_ICON_PACK_ID;
  });

  const [navColors, setNavColors] = useState<NavColorMap>(loadSavedColors);

  const activeHud = HUD_REGISTRY[hudId];
  const activeIconPack = ICON_PACK_REGISTRY[iconPackId];

  const setHudId = (nextId: HudId) => {
    setHudIdState(nextId);
    localStorage.setItem(HUD_STORAGE_KEY, nextId);
  };

  const setTheme = (nextTheme: ThemeMode) => {
    setThemeState(nextTheme);
    localStorage.setItem(THEME_STORAGE_KEY, nextTheme);
  };

  const setIconPackId = (nextId: IconPackId) => {
    setIconPackIdState(nextId);
    localStorage.setItem(ICON_PACK_STORAGE_KEY, nextId);
  };

  const setNavColor = (key: NavColorKey, hex: string) => {
    setNavColors((prev) => {
      const next = { ...prev, [key]: hex };
      localStorage.setItem(COLORS_STORAGE_KEY, JSON.stringify(next));
      return next;
    });
  };

  const resetNavColors = () => {
    const defaults = { ...DEFAULT_NAV_COLORS };
    setNavColors(defaults);
    localStorage.removeItem(COLORS_STORAGE_KEY);
  };

  useEffect(() => {
    const root = document.documentElement;
    root.style.setProperty('--nav-size-mobile', `${activeHud.navSizeMobile}px`);
    root.style.setProperty('--nav-size-desktop', `${activeHud.navSizeDesktop}px`);
  }, [activeHud]);

  useEffect(() => {
    document.documentElement.setAttribute('data-theme', theme);
  }, [theme]);

  return (
    <HudContext.Provider
      value={{
        hudId,
        activeHud,
        setHudId,
        theme,
        setTheme,
        iconPackId,
        activeIconPack,
        setIconPackId,
        navColors,
        setNavColor,
        resetNavColors,
      }}
    >
      {children}
    </HudContext.Provider>
  );
}

export function useHud(): HudContextValue {
  const ctx = useContext(HudContext);
  if (!ctx) {
    throw new Error('useHud debe utilizarse dentro de un <HudProvider>');
  }
  return ctx;
}