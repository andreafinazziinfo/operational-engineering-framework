# 📊 Vendor Scorecard

| Campo | Valore |
|-------|--------|
| **Versione** | 1.0 |
| **Data** | 2026-07-24 |
| **Owner** | Procurement + CTO + Security |
| **Review cycle** | Semestrale (T1: trimestrale) |

> Valutazione, monitoraggio e gestione rischio fornitore. Allineato a [6_STRATEGY_FRAMEWORK.md](../6_STRATEGY_FRAMEWORK.md) e [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md).

---

## 🔗 Collegamenti

| Documento | Ruolo |
|-----------|-------|
| [6_STRATEGY_FRAMEWORK.md](../6_STRATEGY_FRAMEWORK.md) | Dipendenze strategiche |
| [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md) | Concentrazione e SPOF |
| [ENGINEERING_PRINCIPLES.md](./ENGINEERING_PRINCIPLES.md) | Reuse, API-first |
| [RESPONSIBLE_AI_POLICY.md](./RESPONSIBLE_AI_POLICY.md) | Vendor AI/LLM |
| [5_BROWNFIELD](../5_BROWNFIELD_FRAMEWORK.md) | Migrazione da vendor |
| [1_DESIGN — Pilastro 9](../1_DESIGN_FRAMEWORK.md) | Cost model · vendor lock-in |

---

## 🏷️ Tiering

| Tier | Criteri | Review |
|------|---------|--------|
| **T1 Critical** | SPOF; >30% workload; PII | Trimestrale |
| **T2 Important** | Multi-team; sostituzione >6 mesi | Semestrale |
| **T3 Standard** | Sostituibile; basso impatto | Annuale |

---

## 📋 Scorecard (100 pt)

| Area | Peso | Criteri |
|------|------|---------|
| Prodotto & roadmap | 20 | Fit, SLA feature, roadmap |
| Sicurezza & compliance | 25 | SOC2/ISO, pen test, GDPR |
| Operatività & SLA | 20 | Uptime, incident response |
| Finanziario | 15 | Stabilità vendor, pricing |
| Integrazione & exit | 10 | API, export, standard aperti |
| Supporto | 10 | TAM, support tier |

| Score | Decisione |
|-------|-----------|
| ≥80 | ✅ Approvato |
| 65–79 | ⚠️ Condizionato |
| <65 | ❌ Alternative obbligatorie |

---

## ⚠️ Concentration risk

| Indicatore | Warning | Critical |
|------------|---------|----------|
| Spend single vendor / IT | >25% | >40% |
| Servizi critical su vendor | >2 | >4 |
| Vendor lock-in (no export) | T1 = rischio | — |

- [ ] Multi-vendor o abstraction layer (ADR) · Voce risk register · Budget exit annuale

---

## 🔄 Renewal (T1/T2) — avvio T−120gg

| # | Item | Owner |
|---|------|-------|
| R1 | Scorecard rieseguita | Procurement |
| R2 | ≥2 alternative (T1) | Architecture |
| R3 | SLA, liability, DPA | Legal / DPO |
| R4 | Exit plan valido (<12 mesi) | Tech Lead |
| R5 | Costi vs [6_STRATEGY](../../6_STRATEGY_FRAMEWORK.md) | Finance |

---

## 🚪 Exit plan (T1/T2 obbligatorio)

| Sezione | Contenuto |
|---------|-----------|
| Trigger | M&A vendor, breach, price +X%, EOL |
| Export | Formato, API, tempi, costi egress |
| Migration | Fasi, durata, [5_BROWNFIELD](../5_BROWNFIELD/README.md) |
| Rollback | Strategia migrazione parallela |

- [ ] Export testato ≤12 mesi (T1) · Clausola portabilità · Rehearsal ogni 24 mesi (T1)

---

## 🤖 Vendor AI (add-on)

Per [RESPONSIBLE_AI_POLICY.md](./RESPONSIBLE_AI_POLICY.md): data residency · training opt-out · model card · fallback provider

---

## ✅ Nuovo vendor — quick gate

- [ ] Tier · Scorecard · Security assessment · Contratto (SLA, DPA, exit) · Catalogo enterprise
