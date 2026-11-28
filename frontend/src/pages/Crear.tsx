import { useI18n } from '../i18n/I18nContext';

export default function Crear() {
  const { t } = useI18n();

  return (
    <div>
      <h2>{t.pages.crear.title}</h2>
      <p>{t.pages.crear.subtitle}</p>
    </div>
  );
}