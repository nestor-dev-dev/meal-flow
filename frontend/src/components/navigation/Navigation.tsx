import { useMemo } from 'react';
import { useLocation } from 'react-router-dom';
import { Settings2 } from 'lucide-react';
import { useHud } from '../../context/HudContext';
import { useI18n } from '../../i18n/I18nContext';
import { NAV_ITEMS } from './navItems';

export default function Navigation() {
  const { activeHud } = useHud();
  const { t } = useI18n();
  const { pathname } = useLocation();
  const ActiveHudComponent = activeHud.Component;

  const isInSettings = pathname.startsWith('/cuenta/ajustes');

  const resolvedItems = useMemo(() => {
    return NAV_ITEMS.map((item) => {
      if (isInSettings && item.id === 'cuenta') {
        return {
          ...item,
          to: '/cuenta/ajustes',
          label: t.navigation.settingsLabel,
          icon: Settings2,
          accent: '#fb678c',
          darkIconOnOrb: true,
        };
      }

      return {
        ...item,
        label: t.navigation.items[item.id],
      };
    });
  }, [isInSettings, t]);

  return <ActiveHudComponent items={resolvedItems} />;
}