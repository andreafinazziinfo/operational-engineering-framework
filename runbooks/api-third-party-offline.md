## Incidente: API / servizio terzo offline

**Severità**: P1 (se core) | P2 (se non critico)  
**Rilevamento**: alert su error rate verso `[endpoint-terzo]` · healthcheck `[servizio-dipendente]` fail · timeout p95 > 3× baseline

### Passi immediati (primi 15 min)

1. Conferma scope: solo `[modulo]` o tutto il core? → dashboard `[dashboard-url]`
2. Attiva circuit breaker / fallback cache su `[servizio]` (`1_DESIGN` Pilastro 7)
3. Verifica status page del vendor (se esiste)
4. Se P1: comunica a stakeholder · valuta degradazione feature non essenziali
5. Registra ora di inizio incidente (per TTD/TTR)

### Rollback / mitigazione

- Servire risposta cached / stale-while-revalidate se disponibile
- Disabilitare feature flag `[feature-flag]` che dipende dal terzo
- Se deploy recente (< 24h): valuta rollback (`2_EXECUTION` Fase E)

### Post-incidente

- [ ] Report scritto (impatto utenti, durata, causa root)
- [ ] Voce in [TECHNICAL_DEBT_LEDGER.md](../TECHNICAL_DEBT_LEDGER.md) se workaround temporaneo
- [ ] Aggiornamento Pre-Mortem / ADR se dipendenza non era classificata critica
