import { useNavigate } from 'react-router-dom';
import { Settings } from 'lucide-react';
import { useI18n } from '../i18n/I18nContext';
import './Cuenta.css';

export default function Cuenta() {
  const navigate = useNavigate();
  const { t } = useI18n();

  return (
    <div className="cuenta-page">
      <header className="cuenta-header">
        <div>
          <h2 className="cuenta-title">{t.pages.cuenta.title}</h2>
          <p className="cuenta-subtitle">{t.pages.cuenta.subtitle}</p>
        </div>

        <button
          type="button"
          className="cuenta-settings-btn"
          onClick={() => navigate('/cuenta/ajustes')}
          aria-label={t.pages.cuenta.openSettings}
          title={t.settings.title}
        >
          <Settings size={20} strokeWidth={2} />
        </button>
      </header>
    </div>
  );
}