import { useI18n } from '../i18n/I18nContext';

export default function Feed() {
  const { t } = useI18n();

  return (
    <div>
      <h2>{t.pages.feed.title}</h2>
      <p>{t.pages.feed.subtitle}</p>
    </div>
  );
}