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
import { UtensilsCrossed } from 'lucide-react';
import type { HudProps } from '../../hudRegistry';
import { getOrderedNavItems } from '../../navItems';
import { APP_CONFIG } from '../../../../config/appConfig';
import { useI18n } from '../../../../i18n/I18nContext';
import './RailHud.css';

const DESKTOP_QUERY = '(min-width: 768px)';

interface IndicatorRect {
  x: number;
  y: number;
  width: number;
  height: number;
  ready: boolean;
}

export default function RailHud({ items }: HudProps) {
  const location = useLocation();
  const navigate = useNavigate();
  const { t } = useI18n();

  const [isDesktop, setIsDesktop] = useState<boolean>(() =>
    typeof window !== 'undefined'
      ? window.matchMedia(DESKTOP_QUERY).matches
      : false,
  );

  const [indicator, setIndicator] = useState<IndicatorRect>({
    x: 0,
    y: 0,
    width: 0,
    height: 0,
    ready: false,
  });

  const containerRef = useRef<HTMLDivElement>(null);
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

  useEffect(() => {
    const mql = window.matchMedia(DESKTOP_QUERY);
    const onChange = (e: MediaQueryListEvent) => setIsDesktop(e.matches);
    mql.addEventListener('change', onChange);
    return () => mql.removeEventListener('change', onChange);
  }, []);

  const updateIndicator = useCallback(() => {
    const container = containerRef.current;
    const activeBtn = buttonRefs.current[activeIndex];
    if (!container || !activeBtn) return;

    setIndicator({
      x: activeBtn.offsetLeft,
      y: activeBtn.offsetTop,
      width: activeBtn.offsetWidth,
      height: activeBtn.offsetHeight,
      ready: true,
    });
  }, [activeIndex]);

  useLayoutEffect(() => {
    updateIndicator();
  }, [updateIndicator, isDesktop, orderedItems]);

  useEffect(() => {
    const container = containerRef.current;
    if (!container) return;

    const observer = new ResizeObserver(() => updateIndicator());
    observer.observe(container);
    return () => observer.disconnect();
  }, [updateIndicator]);

  return (
    <nav
      className={`rail-shell ${isDesktop ? 'is-desktop' : 'is-mobile'}`}
      aria-label={t.navigation.ariaMain}
    >
      <div
        className="rail-dock"
        style={
          {
            '--active-accent': activeItem?.accent ?? '#c4f22c',
          } as CSSProperties
        }
      >
        {/* Insignia de marca superior solo en PC (como en el vídeo) */}
        {isDesktop && (
          <>
            <div className="rail-brand" title={APP_CONFIG.name}>
              <span className="rail-brand-badge">
                <UtensilsCrossed size={18} strokeWidth={2.3} />
              </span>
            </div>
            <div className="rail-divider" aria-hidden="true" />
          </>
        )}

        <div ref={containerRef} className="rail-items">
          {/* Recuadro activo deslizante + barra lateral de acento */}
          {indicator.ready && (
            <div
              className="rail-active-box"
              aria-hidden="true"
              style={{
                width: `${indicator.width}px`,
                height: `${indicator.height}px`,
                transform: `translate3d(${indicator.x}px, ${indicator.y}px, 0)`,
              }}
            >
              <span className="rail-active-edge" />
            </div>
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
                  'rail-item',
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
                <span className="rail-icon-wrap">
                  <Icon
                    size={20}
                    strokeWidth={isActive || item.isPrimary ? 2.3 : 1.85}
                  />
                </span>
                <span className="rail-label">{item.label}</span>
              </button>
            );
          })}
        </div>
      </div>
    </nav>
  );
}