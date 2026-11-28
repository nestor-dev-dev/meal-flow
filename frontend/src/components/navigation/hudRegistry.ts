import type { ComponentType } from 'react';
import type { NavItemConfig } from './navItems';
import MeniscusHud from './huds/meniscus/MeniscusHud';
import GlassyHud from './huds/glassy/GlassyHud';
import RailHud from './huds/rail/RailHud';
import SpotlightHud from './huds/spotlight/SpotlightHud';

export type HudId = 'meniscus' | 'glassy' | 'rail' | 'spotlight';

export interface HudProps {
  items: NavItemConfig[];
}

export interface HudDefinition {
  id: HudId;
  name: string;
  description: string;
  /** Espacio que reserva el HUD en el layout (px) */
  navSizeMobile: number;
  navSizeDesktop: number;
  Component: ComponentType<HudProps>;
}

export const DEFAULT_HUD_ID: HudId = 'meniscus';

export const HUD_REGISTRY: Record<HudId, HudDefinition> = {
  meniscus: {
    id: 'meniscus',
    name: 'Meniscus',
    description:
      'Dock paramétrico con muesca circular líquida y esfera arrastrable.',
    navSizeMobile: 124,
    navSizeDesktop: 140,
    Component: MeniscusHud,
  },
  glassy: {
    id: 'glassy',
    name: 'Glassy',
    description:
      'Cápsula flotante de cristal esmerilado con píldora deslizante y barra desplegable en PC.',
    navSizeMobile: 96,
    navSizeDesktop: 98,
    Component: GlassyHud,
  },
  rail: {
    id: 'rail',
    name: 'Rail',
    description:
      'Barra compacta de estilo dashboard con indicador lateral de acento y recuadro deslizante.',
    navSizeMobile: 92,
    navSizeDesktop: 96,
    Component: RailHud,
  },
  spotlight: {
    id: 'spotlight',
    name: 'Spotlight',
    description:
      'Cápsula minimalista con haz de luz ambiental y barra luminosa deslizante sobre el icono activo.',
    navSizeMobile: 92,
    navSizeDesktop: 98,
    Component: SpotlightHud,
  },
};

export const HUD_LIST: HudDefinition[] = Object.values(HUD_REGISTRY);

export function isValidHudId(value: string | null): value is HudId {
  return value !== null && value in HUD_REGISTRY;
}