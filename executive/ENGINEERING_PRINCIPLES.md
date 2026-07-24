# ⚙️ Engineering Principles

| Campo | Valore |
|-------|--------|
| **Versione** | 1.0 |
| **Data** | 2026-07-24 |
| **Owner** | CTO / VP Engineering |
| **Stato** | Attivo — non negoziabili |

> Principi vincolanti per tutte le squadre. Ogni eccezione richiede ADR numerato e approvazione [ARB](./ARB_PROCESS.md).

---

## 🔗 Collegamenti

| Documento | Ruolo |
|-----------|-------|
| [6_STRATEGY_FRAMEWORK.md](../6_STRATEGY_FRAMEWORK.md) | Allineamento strategico e priorità |
| [1_DESIGN — Pilastro 9](../1_DESIGN_FRAMEWORK.md) | Cost model · vendor · capacity |
| [5_BROWNFIELD](../5_BROWNFIELD_FRAMEWORK.md) | Evoluzione sistemi legacy |
| [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md) | Registro rischi enterprise |
| [ADR-000](../ADR-000.md) · [ARB](./ARB_PROCESS.md) | Decisioni e governance architetturale |

---

## 📋 Principi non negoziabili (10)

| # | Principio | Regola sintetica |
|---|-----------|------------------|
| 1 | 🎯 Customer outcome first | Ogni deliverable mappa a metrica di successo; no feature senza outcome |
| 2 | 🏗️ Architecture before acceleration | Decisioni cross-team/irreversibili → ADR; multi-dominio → ARB |
| 3 | 🔒 Security & privacy by design | Threat modeling su alto rischio; secret mai in codice/log |
| 4 | 📊 Observability as a feature | SLI/SLO, dashboard e runbook nel DoD |
| 5 | 🧪 Test what matters | Test su flussi critici + contract test; smoke post-deploy |
| 6 | 🔄 Small batches, fast feedback | PR ≤400 LOC; feature flag; rollback ≤15 min |
| 7 | 🌱 Sustainable pace & ownership | Team owner build-run-improve; 20% capacity salute tecnica |
| 8 | 🤝 API-first & bounded contexts | OpenAPI pubblicato; no accesso cross-team al DB |
| 9 | ♻️ Reuse before rebuild | Verificare [Pilastro 9](../1_DESIGN_FRAMEWORK.md) e piattaforme interne prima di greenfield |
| 10 | 🛡️ Resilience over optimism | Timeout, retry, idempotenza; chaos test annuale tier-1 |

---

## ✅ Checklist per principio (campione)

**Architecture (2):** ADR aperto · C4 aggiornato in PR · Nessun bypass ARB per urgenza commerciale

**Security (3):** Classificazione dati · Threat model · Secret in vault

**Observability (4):** Alert configurati · Runbook linkato · SLO monitorati

**Resilience (10):** Circuit breaker · Graceful degradation · Failure path testato

---

## ✅ Checklist adozione

| Fase | Azione | Responsabile |
|------|--------|--------------|
| Onboarding | Lettura principi + quiz | Engineering Manager |
| Sprint planning | Verifica principi su epic | Tech Lead |
| PR review | Gate DoD + ADR | Reviewer |
| Quarterly | Audit conformità | ARB + CTO |

---

## 📎 Escalation

- Eccezioni temporanee → ADR con scadenza e remediation
- Violazioni ripetute → [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md)
- Legacy → applicazione progressiva via [5_BROWNFIELD](../5_BROWNFIELD_FRAMEWORK.md)
