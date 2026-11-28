import {
  createContext,
  useContext,
  useEffect,
  useState,
  type ReactNode,
} from 'react';
import {
  FALLBACK_LANGUAGE,
  isValidLanguage,
  LANGUAGES,
  type LanguageCode,
  type LanguageOption,
} from './languages';
import type { Translations } from './types';
import { es } from './locales/es';
import { en } from './locales/en';

const LANG_STORAGE_KEY = 'mealflow_lang';

const LOCALES: Record<LanguageCode, Translations> = {
  es,
  en,
};

function detectInitialLanguage(): LanguageCode {
  const saved = localStorage.getItem(LANG_STORAGE_KEY);
  if (isValidLanguage(saved)) return saved;

  if (typeof navigator !== 'undefined' && navigator.language) {
    const browserPrefix = navigator.language.toLowerCase().split('-')[0];
    if (isValidLanguage(browserPrefix)) {
      return browserPrefix;
    }
  }

  return FALLBACK_LANGUAGE;
}

interface I18nContextValue {
  language: LanguageCode;
  activeLanguage: LanguageOption;
  setLanguage: (lang: LanguageCode) => void;
  t: Translations;
}

const I18nContext = createContext<I18nContextValue | null>(null);

export function I18nProvider({ children }: { children: ReactNode }) {
  const [language, setLanguageState] = useState<LanguageCode>(
    detectInitialLanguage,
  );

  const setLanguage = (nextLang: LanguageCode) => {
    setLanguageState(nextLang);
    localStorage.setItem(LANG_STORAGE_KEY, nextLang);
  };

  useEffect(() => {
    document.documentElement.lang = language;
  }, [language]);

  const activeLanguage =
    LANGUAGES.find((l) => l.code === language) ?? LANGUAGES[0];

  return (
    <I18nContext.Provider
      value={{
        language,
        activeLanguage,
        setLanguage,
        t: LOCALES[language],
      }}
    >
      {children}
    </I18nContext.Provider>
  );
}

export function useI18n(): I18nContextValue {
  const ctx = useContext(I18nContext);
  if (!ctx) {
    throw new Error('useI18n debe utilizarse dentro de un <I18nProvider>');
  }
  return ctx;
}