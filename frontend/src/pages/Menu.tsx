import { useI18n } from '../i18n/I18nContext';

export default function Menu() {
  const { t } = useI18n();

  return (
    <div>
      <h2>{t.pages.menu.title}</h2>
      <p>{t.pages.menu.subtitle}</p>
    </div>
  );
}