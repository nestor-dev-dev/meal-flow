import {
    CalendarDays,
    Flame,
    Plus,
    ShoppingCart,
    User,
    type LucideIcon,
} from 'lucide-react';

export type NavItemId = 'menu' | 'feed' | 'crear' | 'compra' | 'cuenta';

export interface NavItemConfig {
    id: NavItemId;
    to: string;
    label: string;
    icon: LucideIcon;
    accent: string;
    mobileOrder: number;
    desktopOrder: number;
    isPrimary?: boolean;
    /** Usa icono oscuro dentro de la esfera si el color de acento es muy luminoso */
    darkIconOnOrb?: boolean;
    /** En PC, empuja este botón al final inferior de la barra */
    pinBottomDesktop?: boolean;
}

export const NAV_ITEMS: NavItemConfig[] = [
    {
        id: 'menu',
        to: '/menu',
        label: 'Menú',
        icon: CalendarDays,
        accent: '#c4f22c',
        mobileOrder: 1,
        desktopOrder: 2,
        darkIconOnOrb: true,
    },
    {
        id: 'feed',
        to: '/feed',
        label: 'Feed',
        icon: Flame,
        accent: '#f97316',
        mobileOrder: 2,
        desktopOrder: 3,
    },
    {
        id: 'crear',
        to: '/crear',
        label: 'Crear',
        icon: Plus,
        accent: '#3b82f6',
        mobileOrder: 3,
        desktopOrder: 1,
        isPrimary: true,
    },
    {
        id: 'compra',
        to: '/compra',
        label: 'Compra',
        icon: ShoppingCart,
        accent: '#06b6d4',
        mobileOrder: 4,
        desktopOrder: 4,
    },
    {
        id: 'cuenta',
        to: '/cuenta',
        label: 'Cuenta',
        icon: User,
        accent: '#a855f7',
        mobileOrder: 5,
        desktopOrder: 5,
        pinBottomDesktop: true,
    },
];

export function getOrderedNavItems(
    items: NavItemConfig[],
    isDesktop: boolean,
): NavItemConfig[] {
    return [...items].sort((a, b) =>
        isDesktop ? a.desktopOrder - b.desktopOrder : a.mobileOrder - b.mobileOrder,
    );
}