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
    /** En PC, empuja este botón (y los que vayan detrás) al final inferior de la barra */
    pinBottomDesktop?: boolean;
}

export const NAV_ITEMS: NavItemConfig[] = [
    {
        id: 'menu',
        to: '/menu',
        label: 'Menú',
        icon: CalendarDays,
        accent: '#c4f22c', // Tu lima actualizado
        mobileOrder: 1,
        desktopOrder: 1,
        darkIconOnOrb: true,
    },
    {
        id: 'feed',
        to: '/feed',
        label: 'Feed',
        icon: Flame,
        accent: '#f97316',
        mobileOrder: 2,
        desktopOrder: 2,
    },
    {
        id: 'compra',
        to: '/compra',
        label: 'Compra',
        icon: ShoppingCart,
        accent: '#06b6d4',
        mobileOrder: 4,
        desktopOrder: 3,
    },
    {
        id: 'crear',
        to: '/crear',
        label: 'Crear',
        icon: Plus,
        accent: '#3b82f6',
        mobileOrder: 3, // Centro exacto en móvil
        desktopOrder: 4, // Abajo en PC, justo encima de Cuenta
        isPrimary: true,
        pinBottomDesktop: true,
    },
    {
        id: 'cuenta',
        to: '/cuenta',
        label: 'Cuenta',
        icon: User,
        accent: '#a855f7',
        mobileOrder: 5,
        desktopOrder: 5,
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