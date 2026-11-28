import { useI18n } from '../i18n/I18nContext';

export default function Compra() {
  const { t } = useI18n();

  return (
    <div>
      <h2>{t.pages.compra.title}</h2>
      <p>{t.pages.compra.subtitle}</p>
    </div>
  );
}