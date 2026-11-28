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
import type { HudProps } from '../../hudRegistry';
import { getOrderedNavItems } from '../../navItems';
import { useI18n } from '../../../../i18n/I18nContext';
import './SpotlightHud.css';

const DESKTOP_QUERY = '(min-width: 768px) and (min-height: 500px)';

interface BeamRect {
  x: number;
  y: number;
  width: number;
  height: number;
  ready: boolean;
}

export default function SpotlightHud({ items }: HudProps) {
  const location = useLocation();
  const navigate = useNavigate();
  const { t } = useI18n();

  const [isDesktop, setIsDesktop] = useState<boolean>(() =>
    typeof window !== 'undefined'
      ? window.matchMedia(DESKTOP_QUERY).matches
      : false,
  );

  const [beam, setBeam] = useState<BeamRect>({
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

  const updateBeam = useCallback(() => {
    const container = containerRef.current;
    const activeBtn = buttonRefs.current[activeIndex];
    if (!container || !activeBtn) return;

    setBeam({
      x: activeBtn.offsetLeft,
      y: activeBtn.offsetTop,
      width: activeBtn.offsetWidth,
      height: activeBtn.offsetHeight,
      ready: true,
    });
  }, [activeIndex]);

  useLayoutEffect(() => {
    updateBeam();
  }, [updateBeam, isDesktop, orderedItems]);

  useEffect(() => {
    const container = containerRef.current;
    if (!container) return;

    const observer = new ResizeObserver(() => updateBeam());
    observer.observe(container);
    return () => observer.disconnect();
  }, [updateBeam]);

  return (
    <nav
      className={`spotlight-shell ${isDesktop ? 'is-desktop' : 'is-mobile'}`}
      aria-label={t.navigation.ariaMain}
    >
      <div
        className="spotlight-dock"
        style={
          {
            '--active-accent': activeItem?.accent ?? '#c4f22c',
          } as CSSProperties
        }
      >
        <div ref={containerRef} className="spotlight-items">
          {/* Haz de luz ambiental + barra luminosa en el borde (efecto del vídeo 2) */}
          {beam.ready && (
            <div
              className="spotlight-beam-slot"
              aria-hidden="true"
              style={{
                width: `${beam.width}px`,
                height: `${beam.height}px`,
                transform: `translate3d(${beam.x}px, ${beam.y}px, 0)`,
              }}
            >
              <span className="spotlight-edge-bar" />
              <span className="spotlight-glow-cone" />
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
                  'spotlight-item',
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
                <span className="spotlight-icon-wrap">
                  <Icon
                    size={21}
                    strokeWidth={isActive || item.isPrimary ? 2.3 : 1.85}
                  />
                </span>
                <span className="spotlight-label">{item.label}</span>
              </button>
            );
          })}
        </div>
      </div>
    </nav>
  );
}