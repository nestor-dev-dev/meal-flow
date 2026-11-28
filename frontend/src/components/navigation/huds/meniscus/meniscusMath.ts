export interface RGB {
    r: number;
    g: number;
    b: number;
}

export function hexToRgb(hex: string): RGB {
    const clean = hex.replace('#', '');
    const full =
        clean.length === 3
            ? clean
                .split('')
                .map((c) => c + c)
                .join('')
            : clean;
    const num = parseInt(full, 16);
    return {
        r: (num >> 16) & 255,
        g: (num >> 8) & 255,
        b: num & 255,
    };
}

export function lerpRgb(a: RGB, b: RGB, t: number): RGB {
    const k = Math.max(0, Math.min(1, t));
    return {
        r: Math.round(a.r + (b.r - a.r) * k),
        g: Math.round(a.g + (b.g - a.g) * k),
        b: Math.round(a.b + (b.b - a.b) * k),
    };
}

export function sampleAccentColor(
    pos: number,
    centers: number[],
    colors: RGB[],
): RGB {
    if (centers.length === 0 || colors.length === 0) {
        return { r: 185, g: 242, b: 74 };
    }
    if (pos <= centers[0]) return colors[0];
    const last = centers.length - 1;
    if (pos >= centers[last]) return colors[last];

    for (let i = 0; i < last; i++) {
        const c1 = centers[i];
        const c2 = centers[i + 1];
        if (pos >= c1 && pos <= c2) {
            const span = c2 - c1;
            const t = span > 0 ? (pos - c1) / span : 0;
            return lerpRgb(colors[i], colors[i + 1], t);
        }
    }
    return colors[last];
}

export interface MeniscusPathParams {
    width: number;
    height: number;
    cornerRadius: number;
    /** Centro del círculo sobre el eje principal (X en móvil, Y en PC) */
    center: number;
    /** Radio exacto de la muesca circular (radio del círculo + hueco uniforme) */
    notchRadius: number;
    /** Distancia que sobresale el centro del círculo fuera del borde del dock */
    orbOutset: number;
    /** Radio de las dos curvas de entrada/salida (fillets) */
    filletRadius: number;
    isDesktop: boolean;
}

/**
 * Genera el path SVG de la caja flotante con una muesca circular
 * exactamente concéntrica al círculo activo:
 * - Móvil (horizontal inferior): muesca en el borde superior (y = 0)
 * - PC (vertical izquierdo): muesca en el borde derecho (x = W)
 */
export function buildMeniscusPath({
    width: W,
    height: H,
    cornerRadius: R,
    center,
    notchRadius: Rn,
    orbOutset: out,
    filletRadius: baseFillet,
    isDesktop,
}: MeniscusPathParams): string {
    const axisLen = isDesktop ? H : W;

    // Distancia disponible hasta los bordes para que el fillet nunca pise las esquinas
    const maxAvail = Math.max(0, Math.min(center, axisLen - center) - R);

    // Ajusta el fillet solo si la pantalla es muy estrecha
    let f = baseFillet;
    let dx = Math.sqrt(Math.max(1, (Rn + f) ** 2 - (f + out) ** 2));
    if (dx > maxAvail && f > 4) {
        f = 4;
        dx = Math.sqrt(Math.max(1, (Rn + f) ** 2 - (f + out) ** 2));
    }

    // Si aún falta espacio en pantallas diminutas, suaviza el radio de esquina de ese lado
    const rStart = Math.min(R, Math.max(6, center - dx));
    const rEnd = Math.min(R, Math.max(6, axisLen - (center + dx)));

    const start = Math.max(rStart, center - dx);
    const end = Math.min(axisLen - rEnd, center + dx);

    // Punto exacto de tangencia entre el fillet y el arco circular de la muesca
    const t = Rn / (Rn + f);
    const tanAxisOffset = dx * t;
    const tanDepth = -out + (f + out) * t;

    if (!isDesktop) {
        // Móvil: caja flotante inferior, muesca circular en el borde superior (y = 0)
        const xTL = center - tanAxisOffset;
        const xTR = center + tanAxisOffset;
        const yT = tanDepth;

        return [
            `M ${rStart.toFixed(2)} 0`,
            `L ${start.toFixed(2)} 0`,
            `A ${f} ${f} 0 0 1 ${xTL.toFixed(2)} ${yT.toFixed(2)}`,
            `A ${Rn} ${Rn} 0 0 0 ${xTR.toFixed(2)} ${yT.toFixed(2)}`,
            `A ${f} ${f} 0 0 1 ${end.toFixed(2)} 0`,
            `L ${(W - rEnd).toFixed(2)} 0`,
            `A ${rEnd.toFixed(2)} ${rEnd.toFixed(2)} 0 0 1 ${W} ${rEnd.toFixed(2)}`,
            `L ${W} ${H - R}`,
            `A ${R} ${R} 0 0 1 ${W - R} ${H}`,
            `L ${R} ${H}`,
            `A ${R} ${R} 0 0 1 0 ${H - R}`,
            `L 0 ${rStart.toFixed(2)}`,
            `A ${rStart.toFixed(2)} ${rStart.toFixed(2)} 0 0 1 ${rStart.toFixed(2)} 0`,
            'Z',
        ].join(' ');
    }

    // PC: caja flotante izquierda, muesca circular en el borde derecho (x = W)
    const yTT = center - tanAxisOffset;
    const yTB = center + tanAxisOffset;
    const xT = W - tanDepth;

    return [
        `M ${R} 0`,
        `L ${(W - rStart).toFixed(2)} 0`,
        `A ${rStart.toFixed(2)} ${rStart.toFixed(2)} 0 0 1 ${W} ${rStart.toFixed(2)}`,
        `L ${W} ${start.toFixed(2)}`,
        `A ${f} ${f} 0 0 1 ${xT.toFixed(2)} ${yTT.toFixed(2)}`,
        `A ${Rn} ${Rn} 0 0 0 ${xT.toFixed(2)} ${yTB.toFixed(2)}`,
        `A ${f} ${f} 0 0 1 ${W} ${end.toFixed(2)}`,
        `L ${W} ${(H - rEnd).toFixed(2)}`,
        `A ${rEnd.toFixed(2)} ${rEnd.toFixed(2)} 0 0 1 ${(W - rEnd).toFixed(2)} ${H}`,
        `L ${R} ${H}`,
        `A ${R} ${R} 0 0 1 0 ${H - R}`,
        `L 0 ${R}`,
        `A ${R} ${R} 0 0 1 ${R} 0`,
        'Z',
    ].join(' ');
}