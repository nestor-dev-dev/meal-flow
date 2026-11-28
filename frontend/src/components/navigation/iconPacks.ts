import {
  BookOpen,
  CalendarDays,
  ChefHat,
  CircleUser,
  Cog,
  Compass,
  Flame,
  LayoutGrid,
  ListChecks,
  Package,
  Settings2,
  ShoppingBag,
  ShoppingCart,
  SlidersHorizontal,
  Sparkles,
  User,
  UserRound,
  Utensils,
  Wrench,
  Zap,
  type LucideIcon,
} from 'lucide-react';

export type IconPackId = 'default' | 'culinary' | 'editorial' | 'geometric';

export interface IconPackDefinition {
  id: IconPackId;
  icons: {
    menu: LucideIcon;
    feed: LucideIcon;
    compra: LucideIcon;
    cuenta: LucideIcon;
    ajustes: LucideIcon;
  };
}

export const DEFAULT_ICON_PACK_ID: IconPackId = 'default';

export const ICON_PACK_REGISTRY: Record<IconPackId, IconPackDefinition> = {
  default: {
    id: 'default',
    icons: {
      menu: CalendarDays,
      feed: Flame,
      compra: ShoppingCart,
      cuenta: User,
      ajustes: Settings2,
    },
  },
  culinary: {
    id: 'culinary',
    icons: {
      menu: Utensils,
      feed: Compass,
      compra: ShoppingBag,
      cuenta: ChefHat,
      ajustes: SlidersHorizontal,
    },
  },
  editorial: {
    id: 'editorial',
    icons: {
      menu: BookOpen,
      feed: Sparkles,
      compra: ListChecks,
      cuenta: CircleUser,
      ajustes: Wrench,
    },
  },
  geometric: {
    id: 'geometric',
    icons: {
      menu: LayoutGrid,
      feed: Zap,
      compra: Package,
      cuenta: UserRound,
      ajustes: Cog,
    },
  },
};

export const ICON_PACK_LIST: IconPackDefinition[] =
  Object.values(ICON_PACK_REGISTRY);

export function isValidIconPackId(value: string | null): value is IconPackId {
  return value !== null && value in ICON_PACK_REGISTRY;
}