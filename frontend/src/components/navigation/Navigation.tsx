import { useMemo } from 'react';
import { useLocation } from 'react-router-dom';
import { useHud } from '../../context/HudContext';
import { useI18n } from '../../i18n/I18nContext';
import { NAV_ITEMS } from './navItems';

/** Calcula si un color hex es claro para usar icono oscuro encima (ej. en Meniscus) */
function isLightHex(hex: string): boolean {
  const clean = hex.replace('#', '');
  const full =
    clean.length === 3
      ? clean
          .split('')
          .map((c) => c + c)
          .join('')
      : clean;
  const num = parseInt(full, 16);
  const r = (num >> 16) & 255;
  const g = (num >> 8) & 255;
  const b = num & 255;
  return (r * 299 + g * 587 + b * 114) / 1000 > 148;
}

export default function Navigation() {
  const { activeHud, activeIconPack, navColors } = useHud();
  const { t } = useI18n();
  const { pathname } = useLocation();
  const ActiveHudComponent = activeHud.Component;

  const isInSettings = pathname.startsWith('/cuenta/ajustes');

  const resolvedItems = useMemo(() => {
    return NAV_ITEMS.map((item) => {
      if (isInSettings && item.id === 'cuenta') {
        const accent = navColors.ajustes;
        return {
          ...item,
          to: '/cuenta/ajustes',
          label: t.navigation.settingsLabel,
          icon: activeIconPack.icons.ajustes,
          accent,
          darkIconOnOrb: isLightHex(accent),
        };
      }

      const accent = navColors[item.id];
      const icon =
        item.id === 'crear' ? item.icon : activeIconPack.icons[item.id];

      return {
        ...item,
        label: t.navigation.items[item.id],
        icon,
        accent,
        darkIconOnOrb: isLightHex(accent),
      };
    });
  }, [isInSettings, t, activeIconPack, navColors]);

  return <ActiveHudComponent items={resolvedItems} />;
}