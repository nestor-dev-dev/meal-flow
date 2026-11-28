import {
  useCallback,
  useEffect,
  useLayoutEffect,
  useMemo,
  useRef,
  useState,
  type CSSProperties,
} from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { PanelLeftClose, PanelLeftOpen, UtensilsCrossed } from 'lucide-react';
import type { HudProps } from '../../hudRegistry';
import { getOrderedNavItems } from '../../navItems';
import { APP_CONFIG } from '../../../../config/appConfig';
import { useI18n } from '../../../../i18n/I18nContext';
import './GlassyHud.css';

const DESKTOP_QUERY = '(min-width: 768px)';

interface PillRect {
  x: number;
  y: number;
  width: number;
  height: number;
  ready: boolean;
}

export default function GlassyHud({ items }: HudProps) {
  const location = useLocation();
  const navigate = useNavigate();
  const { t } = useI18n();

  const [isDesktop, setIsDesktop] = useState<boolean>(() =>
    typeof window !== 'undefined'
      ? window.matchMedia(DESKTOP_QUERY).matches
      : false,
  );
  const [isExpanded, setIsExpanded] = useState(false);
  const [pill, setPill] = useState<PillRect>({
    x: 0,
    y: 0,
    width: 0,
    height: 0,
    ready: false,
  });

  const itemsContainerRef = useRef<HTMLDivElement>(null);
  const buttonRefs = useRef<(HTMLButtonElement | null)[]>([]);

  const orderedItems = useMemo(
    () => getOrderedNavItems(items, isDesktop),
    [items, isDesktop],
  );

  const activeIndex = useMemo(() => {
    const idx = orderedItems.findIndex((item) =>
      location.pathname.startsWith(item.to),
    );
    return idx >= 0 ? idx : 0;
  }, [orderedItems, location.pathname]);

  const activeItem = orderedItems[activeIndex] ?? orderedItems[0];

  // Escuchar cambios móvil <-> PC
  useEffect(() => {
    const mql = window.matchMedia(DESKTOP_QUERY);
    const onChange = (e: MediaQueryListEvent) => {
      setIsDesktop(e.matches);
      if (!e.matches) setIsExpanded(false);
    };
    mql.addEventListener('change', onChange);
    return () => mql.removeEventListener('change', onChange);
  }, []);

  // Medir la posición y tamaño del botón activo para deslizar la píldora
  const updatePill = useCallback(() => {
    const container = itemsContainerRef.current;
    const activeBtn = buttonRefs.current[activeIndex];
    if (!container || !activeBtn) return;

    setPill({
      x: activeBtn.offsetLeft,
      y: activeBtn.offsetTop,
      width: activeBtn.offsetWidth,
      height: activeBtn.offsetHeight,
      ready: true,
    });
  }, [activeIndex]);

  useLayoutEffect(() => {
    updatePill();
  }, [updatePill, isDesktop, isExpanded, orderedItems]);

  useEffect(() => {
    const container = itemsContainerRef.current;
    if (!container) return;

    const observer = new ResizeObserver(() => updatePill());
    observer.observe(container);
    return () => observer.disconnect();
  }, [updatePill]);

  return (
    <nav
      className={[
        'glassy-shell',
        isDesktop ? 'is-desktop' : 'is-mobile',
        isDesktop && isExpanded ? 'is-expanded' : '',
      ]
        .filter(Boolean)
        .join(' ')}
      aria-label={t.navigation.ariaMain}
    >
      <div
        className="glassy-dock"
        style={
          {
            '--active-accent': activeItem?.accent ?? '#c4f22c',
          } as CSSProperties
        }
      >
        {/* Cabecera solo en PC: marca + botón expandir/colapsar */}
        {isDesktop && (
          <>
            <div className="glassy-header">
              {isExpanded && (
                <div className="glassy-brand">
                  <span className="glassy-brand-mark">
                    <UtensilsCrossed size={16} strokeWidth={2.3} />
                  </span>
                  <div className="glassy-brand-text">
                    <span className="glassy-brand-name">{APP_CONFIG.name}</span>
                    <span className="glassy-brand-sub">{t.common.tagline}</span>
                  </div>
                </div>
              )}

              <button
                type="button"
                className="glassy-toggle-btn"
                onClick={() => setIsExpanded((prev) => !prev)}
                aria-label={
                  isExpanded
                    ? t.navigation.collapseSidebar
                    : t.navigation.expandSidebar
                }
                aria-expanded={isExpanded}
                title={
                  isExpanded
                    ? t.navigation.collapseSidebar
                    : t.navigation.expandSidebar
                }
              >
                {isExpanded ? (
                  <PanelLeftClose size={18} strokeWidth={2} />
                ) : (
                  <PanelLeftOpen size={18} strokeWidth={2} />
                )}
              </button>
            </div>

            <div className="glassy-divider" aria-hidden="true" />
          </>
        )}

        {/* Lista de pestañas + píldora activa deslizante */}
        <div ref={itemsContainerRef} className="glassy-items">
          {pill.ready && (
            <div
              className="glassy-active-pill"
              aria-hidden="true"
              style={{
                width: `${pill.width}px`,
                height: `${pill.height}px`,
                transform: `translate3d(${pill.x}px, ${pill.y}px, 0)`,
              }}
            />
          )}

          {orderedItems.map((item, idx) => {
            const Icon = item.icon;
            const isActive = idx === activeIndex;

            return (
              <button
                key={item.id}
                ref={(el) => {
                  buttonRefs.current[idx] = el;
                }}
                type="button"
                className={[
                  'glassy-item',
                  isActive ? 'is-active' : '',
                  item.isPrimary ? 'is-primary' : '',
                  item.pinBottomDesktop ? 'is-bottom' : '',
                ]
                  .filter(Boolean)
                  .join(' ')}
                style={{ '--item-accent': item.accent } as CSSProperties}
                onClick={() => navigate(item.to)}
                aria-current={isActive ? 'page' : undefined}
                aria-label={item.label}
              >
                <span className="glassy-icon-wrap">
                  <Icon
                    size={20}
                    strokeWidth={isActive || item.isPrimary ? 2.3 : 1.85}
                  />
                </span>

                <span className="glassy-label">{item.label}</span>

                {isDesktop && isExpanded && isActive && (
                  <span className="glassy-accent-dot" aria-hidden="true" />
                )}
              </button>
            );
          })}
        </div>
      </div>
    </nav>
  );
}