import type { ReactNode } from "react";

export type LanguageCode = "es" | "en";

export interface LanguageOption {
    code: LanguageCode;
    englishName: string;
    nativeName: string;
    flag: ReactNode;
}

function FlagSpain() {
    return (
        <svg viewBox="0 0 24 16" className="lang-flag-svg" aria-hidden="true">
            <rect width="24" height="16" rx="2" fill="#AA151B" />
            <rect y="4" width="24" height="8" fill="#F1BF00" />
        </svg>
    );
}

function FlagUK() {
    return (
        <svg viewBox="0 0 24 16" className="lang-flag-svg" aria-hidden="true">
            <clipPath id="flag-uk-clip">
                <rect width="24" height="16" rx="2" />
            </clipPath>
            <g clipPath="url(#flag-uk-clip)">
                <rect width="24" height="16" fill="#012169" />
                <path d="M0 0L24 16M24 0L0 16" stroke="#FFFFFF" strokeWidth="3.2" />
                <path d="M0 0L24 16M24 0L0 16" stroke="#C8102E" strokeWidth="1.6" />
                <path d="M12 0V16M0 8H24" stroke="#FFFFFF" strokeWidth="5" />
                <path d="M12 0V16M0 8H24" stroke="#C8102E" strokeWidth="3" />
            </g>
        </svg>
    );
}

export const LANGUAGES: LanguageOption[] = [
    {
        code: "es",
        englishName: "Spanish",
        nativeName: "Español",
        flag: <FlagSpain />,
    },
    {
        code: "en",
        englishName: "English",
        nativeName: "English",
        flag: <FlagUK />,
    },
];

/** Idioma de respaldo si el idioma del navegador no está soportado */
export const FALLBACK_LANGUAGE: LanguageCode = "en";

export function isValidLanguage(value: string | null): value is LanguageCode {
    return value === "es" || value === "en";
}
