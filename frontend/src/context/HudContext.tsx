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

const STORAGE_KEY = 'mealflow_hud_id';

interface HudContextValue {
    hudId: HudId;
    activeHud: HudDefinition;
    setHudId: (id: HudId) => void;
}

const HudContext = createContext<HudContextValue | null>(null);

export function HudProvider({ children }: { children: ReactNode }) {
    const [hudId, setHudIdState] = useState<HudId>(() => {
        const saved = localStorage.getItem(STORAGE_KEY);
        return isValidHudId(saved) ? saved : DEFAULT_HUD_ID;
    });

    const activeHud = HUD_REGISTRY[hudId];

    const setHudId = (nextId: HudId) => {
        setHudIdState(nextId);
        localStorage.setItem(STORAGE_KEY, nextId);
    };

    // Actualiza las variables CSS del layout según el HUD activo
    useEffect(() => {
        const root = document.documentElement;
        root.style.setProperty('--nav-size-mobile', `${activeHud.navSizeMobile}px`);
        root.style.setProperty('--nav-size-desktop', `${activeHud.navSizeDesktop}px`);
    }, [activeHud]);

    return (
        <HudContext.Provider value={{ hudId, activeHud, setHudId }}>
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