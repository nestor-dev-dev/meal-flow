import { useMemo } from 'react';
import { useLocation } from 'react-router-dom';
import { Settings2 } from 'lucide-react';
import { useHud } from '../../context/HudContext';
import { NAV_ITEMS } from './navItems';

export default function Navigation() {
    const { activeHud } = useHud();
    const { pathname } = useLocation();
    const ActiveHudComponent = activeHud.Component;

    const isInSettings = pathname.startsWith('/cuenta/ajustes');

    const resolvedItems = useMemo(() => {
        if (!isInSettings) return NAV_ITEMS;

        return NAV_ITEMS.map((item) =>
            item.id === 'cuenta'
                ? {
                    ...item,
                    to: '/cuenta/ajustes',
                    label: 'Ajustes',
                    icon: Settings2,
                    accent: '#fb678c', 
                    darkIconOnOrb: true,
                }
                : item,
        );
    }, [isInSettings]);

    return <ActiveHudComponent items={resolvedItems} />;
}