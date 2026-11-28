import {
  useCallback,
  useEffect,
  useMemo,
  useRef,
  useState,
  type CSSProperties,
  type PointerEvent as ReactPointerEvent,
} from 'react';
import { useLocation, useNavigate } from "react-router-dom";
import type { HudProps } from "../../hudRegistry";
import { getOrderedNavItems } from "../../navItems";
import { buildMeniscusPath, hexToRgb, sampleAccentColor } from "./meniscusMath";
import "./MeniscusHud.css";
import { useI18n } from '../../../../i18n/I18nContext';

const DESKTOP_QUERY = "(min-width: 768px)";
const CORNER_RADIUS = 20;
const ORB_RADIUS = 26; // Diámetro del círculo = 52px
const NOTCH_GAP = 5; // Hueco uniforme entre círculo y borde del dock
const NOTCH_RADIUS = ORB_RADIUS + NOTCH_GAP; // 31px exactos
const ORB_OUTSET = 4; // El centro del círculo sobresale 4px del borde
const FILLET_RADIUS = 10; // Curva limpia de entrada/salida

export default function MeniscusHud({ items }: HudProps) {
    const location = useLocation();
    const navigate = useNavigate();
    const { t } = useI18n();

    const [isDesktop, setIsDesktop] = useState<boolean>(() =>
        typeof window !== "undefined"
            ? window.matchMedia(DESKTOP_QUERY).matches
            : false,
    );
    const [visualIndex, setVisualIndex] = useState<number>(0);

    const orderedItems = useMemo(
        () => getOrderedNavItems(items, isDesktop),
        [items, isDesktop],
    );

    const itemColors = useMemo(
        () => orderedItems.map((item) => hexToRgb(item.accent)),
        [orderedItems],
    );

    const activeIndex = useMemo(() => {
        const idx = orderedItems.findIndex((item) =>
            location.pathname.startsWith(item.to),
        );
        return idx >= 0 ? idx : 0;
    }, [orderedItems, location.pathname]);

    const dockRef = useRef<HTMLDivElement>(null);
    const svgRef = useRef<SVGSVGElement>(null);
    const pathFillRef = useRef<SVGPathElement>(null);
    const pathStrokeRef = useRef<SVGPathElement>(null);
    const orbRef = useRef<HTMLDivElement>(null);
    const buttonRefs = useRef<(HTMLButtonElement | null)[]>([]);

    const physicsRef = useRef({
        pos: 0,
        vel: 0,
        target: 0,
        width: 360,
        height: 74,
        centers: [] as number[],
        initialized: false,
        isDragging: false,
        pointerDown: false,
        pointerStart: 0,
        pointerId: -1,
        lastNearest: 0,
    });

    useEffect(() => {
        const mql = window.matchMedia(DESKTOP_QUERY);
        const onChange = (e: MediaQueryListEvent) => setIsDesktop(e.matches);
        mql.addEventListener("change", onChange);
        return () => mql.removeEventListener("change", onChange);
    }, []);

    const measureLayout = useCallback(
        (snapImmediate = false) => {
            const dock = dockRef.current;
            if (!dock) return;

            const dockRect = dock.getBoundingClientRect();
            if (dockRect.width === 0 || dockRect.height === 0) return;

            const centers = orderedItems.map((_, idx) => {
                const btn = buttonRefs.current[idx];
                if (!btn) {
                    const axis = isDesktop ? dockRect.height : dockRect.width;
                    return ((idx + 0.5) / orderedItems.length) * axis;
                }
                const rect = btn.getBoundingClientRect();
                return isDesktop
                    ? rect.top - dockRect.top + rect.height / 2
                    : rect.left - dockRect.left + rect.width / 2;
            });

            const p = physicsRef.current;
            p.width = dockRect.width;
            p.height = dockRect.height;
            p.centers = centers;

            if (svgRef.current) {
                svgRef.current.setAttribute(
                    "viewBox",
                    `0 0 ${dockRect.width} ${dockRect.height}`,
                );
            }

            const targetCenter = centers[activeIndex] ?? centers[0] ?? 0;
            p.target = targetCenter;

            if (!p.initialized || snapImmediate) {
                p.pos = targetCenter;
                p.vel = 0;
                p.initialized = true;
            }
        },
        [orderedItems, isDesktop, activeIndex],
    );

    useEffect(() => {
        physicsRef.current.initialized = false;
        measureLayout(true);
        setVisualIndex(activeIndex);

        const dock = dockRef.current;
        if (!dock) return;

        const observer = new ResizeObserver(() => measureLayout(true));
        observer.observe(dock);
        return () => observer.disconnect();
    }, [measureLayout, activeIndex]);

    useEffect(() => {
        const p = physicsRef.current;
        if (p.isDragging) return;
        if (p.centers[activeIndex] !== undefined) {
            p.target = p.centers[activeIndex];
            p.lastNearest = activeIndex;
        }
        setVisualIndex(activeIndex);
    }, [activeIndex]);

    useEffect(() => {
        let rafId = 0;

        const tick = () => {
            const p = physicsRef.current;

            if (p.initialized && p.width > 0 && p.height > 0) {
                if (p.isDragging) {
                    const diff = p.target - p.pos;
                    p.vel = diff * 0.42;
                    p.pos += p.vel;
                } else {
                    const stiffness = 0.16;
                    const damping = 0.72;
                    const force = (p.target - p.pos) * stiffness;
                    p.vel = (p.vel + force) * damping;
                    p.pos += p.vel;

                    if (Math.abs(p.target - p.pos) < 0.05 && Math.abs(p.vel) < 0.05) {
                        p.pos = p.target;
                        p.vel = 0;
                    }
                }

                const d = buildMeniscusPath({
                    width: p.width,
                    height: p.height,
                    cornerRadius: CORNER_RADIUS,
                    center: p.pos,
                    notchRadius: NOTCH_RADIUS,
                    orbOutset: ORB_OUTSET,
                    filletRadius: FILLET_RADIUS,
                    isDesktop,
                });

                if (pathFillRef.current) pathFillRef.current.setAttribute("d", d);
                if (pathStrokeRef.current) pathStrokeRef.current.setAttribute("d", d);

                if (orbRef.current) {
                    if (!isDesktop) {
                        // Móvil: centro del círculo a -ORB_OUTSET (-4px) sobre el borde superior
                        orbRef.current.style.transform = `translate3d(${p.pos.toFixed(2)}px, ${-ORB_OUTSET}px, 0) translate(-50%, -50%)`;
                    } else {
                        // PC izquierda: centro del círculo a W + ORB_OUTSET (80px) en el borde derecho
                        orbRef.current.style.transform = `translate3d(${(p.width + ORB_OUTSET).toFixed(2)}px, ${p.pos.toFixed(2)}px, 0) translate(-50%, -50%)`;
                    }
                }

                const rgb = sampleAccentColor(p.pos, p.centers, itemColors);
                if (dockRef.current) {
                    dockRef.current.style.setProperty(
                        "--acc-rgb",
                        `${rgb.r}, ${rgb.g}, ${rgb.b}`,
                    );
                }
            }

            rafId = requestAnimationFrame(tick);
        };

        rafId = requestAnimationFrame(tick);
        return () => cancelAnimationFrame(rafId);
    }, [isDesktop, itemColors]);

    const getNearestIndex = (coord: number): number => {
        const centers = physicsRef.current.centers;
        if (centers.length === 0) return 0;
        let bestIdx = 0;
        let bestDist = Infinity;
        for (let i = 0; i < centers.length; i++) {
            const dist = Math.abs(coord - centers[i]);
            if (dist < bestDist) {
                bestDist = dist;
                bestIdx = i;
            }
        }
        return bestIdx;
    };

    const getLocalCoord = (e: ReactPointerEvent<HTMLDivElement>): number => {
        const dock = dockRef.current;
        if (!dock) return 0;
        const rect = dock.getBoundingClientRect();
        return isDesktop ? e.clientY - rect.top : e.clientX - rect.left;
    };

    const handlePointerDown = (e: ReactPointerEvent<HTMLDivElement>) => {
        if (e.button !== 0 && e.pointerType === "mouse") return;
        const p = physicsRef.current;
        p.pointerDown = true;
        p.isDragging = false;
        p.pointerStart = getLocalCoord(e);
        p.pointerId = e.pointerId;
    };

    const handlePointerMove = (e: ReactPointerEvent<HTMLDivElement>) => {
        const p = physicsRef.current;
        if (!p.pointerDown || p.centers.length === 0) return;

        const coord = getLocalCoord(e);
        if (!p.isDragging && Math.abs(coord - p.pointerStart) > 6) {
            p.isDragging = true;
            dockRef.current?.setPointerCapture(e.pointerId);
        }

        if (p.isDragging) {
            const minC = p.centers[0];
            const maxC = p.centers[p.centers.length - 1];
            const clamped = Math.max(minC, Math.min(maxC, coord));
            p.target = clamped;

            const nearest = getNearestIndex(clamped);
            if (nearest !== p.lastNearest) {
                p.lastNearest = nearest;
                setVisualIndex(nearest);
            }
        }
    };

    const finishDrag = (e: ReactPointerEvent<HTMLDivElement>) => {
        const p = physicsRef.current;
        if (!p.pointerDown) return;

        const wasDragging = p.isDragging;
        p.pointerDown = false;
        p.isDragging = false;

        if (wasDragging) {
            if (dockRef.current?.hasPointerCapture(e.pointerId)) {
                dockRef.current.releasePointerCapture(e.pointerId);
            }
            const nearest = getNearestIndex(p.target);
            p.target = p.centers[nearest] ?? p.target;
            setVisualIndex(nearest);

            const targetItem = orderedItems[nearest];
            if (targetItem && !location.pathname.startsWith(targetItem.to)) {
                navigate(targetItem.to);
            }
        }
    };

    const handleItemClick = (idx: number, to: string) => {
        if (physicsRef.current.isDragging) return;
        setVisualIndex(idx);
        navigate(to);
    };

    const activeItem = orderedItems[visualIndex];

    return (
        <nav
            className={`meniscus-shell ${isDesktop ? "is-desktop" : "is-mobile"}`}
            aria-label={t.navigation.ariaMain}
        >
            <div
                ref={dockRef}
                className={`meniscus-dock ${activeItem?.isPrimary ? "is-primary-active" : ""}`}
                onPointerDown={handlePointerDown}
                onPointerMove={handlePointerMove}
                onPointerUp={finishDrag}
                onPointerCancel={finishDrag}
            >
                <svg ref={svgRef} className="meniscus-svg" aria-hidden="true">
                    <path ref={pathFillRef} className="meniscus-path-fill" />
                    <path ref={pathStrokeRef} className="meniscus-path-stroke" />
                </svg>

                <div ref={orbRef} className="meniscus-orb" aria-hidden="true">
                    <div className="meniscus-orb-glow" />
                    <div className="meniscus-orb-core" />
                </div>

                <div className="meniscus-items">
                    {orderedItems.map((item, idx) => {
                        const Icon = item.icon;
                        const isActive = idx === visualIndex;

                        return (
                            <button
                                key={item.id}
                                ref={(el) => {
                                    buttonRefs.current[idx] = el;
                                }}
                                type="button"
                                className={[
                                    "meniscus-item",
                                    isActive ? "is-active" : "",
                                    item.isPrimary ? "is-primary" : "",
                                    item.darkIconOnOrb ? "is-dark-icon" : "",
                                    item.pinBottomDesktop ? "is-bottom" : "",
                                ]
                                    .filter(Boolean)
                                    .join(" ")}
                                style={{ '--item-accent': item.accent } as CSSProperties}
                                onClick={() => handleItemClick(idx, item.to)}
                                aria-current={isActive ? "page" : undefined}
                                aria-label={item.label}
                                title={isDesktop ? item.label : undefined}
                            >
                                <span className="meniscus-icon-wrap">
                                    <Icon
                                        className="meniscus-icon"
                                        size={22}
                                        strokeWidth={isActive || item.isPrimary ? 2.4 : 1.9}
                                    />
                                </span>
                                <span className="meniscus-label">{item.label}</span>
                            </button>
                        );
                    })}
                </div>
            </div>
        </nav>
    );
}