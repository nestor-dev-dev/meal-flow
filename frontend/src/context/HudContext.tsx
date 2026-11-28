import {
    createContext,
    useContext,
    useEffect,
    useState,
    type ReactNode,
} from "react";
import {
    DEFAULT_HUD_ID,
    HUD_REGISTRY,
    isValidHudId,
    type HudDefinition,
    type HudId,
} from "../components/navigation/hudRegistry";

const HUD_STORAGE_KEY = "mealflow_hud_id";
const THEME_STORAGE_KEY = "mealflow_theme";

export type ThemeMode = "dark" | "light";

interface HudContextValue {
    hudId: HudId;
    activeHud: HudDefinition;
    setHudId: (id: HudId) => void;
    theme: ThemeMode;
    setTheme: (theme: ThemeMode) => void;
}

const HudContext = createContext<HudContextValue | null>(null);

export function HudProvider({ children }: { children: ReactNode }) {
    const [hudId, setHudIdState] = useState<HudId>(() => {
        const saved = localStorage.getItem(HUD_STORAGE_KEY);
        return isValidHudId(saved) ? saved : DEFAULT_HUD_ID;
    });

    const [theme, setThemeState] = useState<ThemeMode>(() => {
        const saved = localStorage.getItem(THEME_STORAGE_KEY);
        return saved === "light" || saved === "dark" ? saved : "dark";
    });

    const activeHud = HUD_REGISTRY[hudId];

    const setHudId = (nextId: HudId) => {
        setHudIdState(nextId);
        localStorage.setItem(HUD_STORAGE_KEY, nextId);
    };

    const setTheme = (nextTheme: ThemeMode) => {
        setThemeState(nextTheme);
        localStorage.setItem(THEME_STORAGE_KEY, nextTheme);
    };

    // Actualiza las variables CSS del layout según el HUD activo
    useEffect(() => {
        const root = document.documentElement;
        root.style.setProperty("--nav-size-mobile", `${activeHud.navSizeMobile}px`);
        root.style.setProperty(
            "--nav-size-desktop",
            `${activeHud.navSizeDesktop}px`,
        );
    }, [activeHud]);

    // Aplica el tema al documento (claro / oscuro)
    useEffect(() => {
        document.documentElement.setAttribute("data-theme", theme);
    }, [theme]);

    return (
        <HudContext.Provider
            value={{ hudId, activeHud, setHudId, theme, setTheme }}
        >
            {children}
        </HudContext.Provider>
    );
}

export function useHud(): HudContextValue {
    const ctx = useContext(HudContext);
    if (!ctx) {
        throw new Error("useHud debe utilizarse dentro de un <HudProvider>");
    }
    return ctx;
}
