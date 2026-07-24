# 📂 Executive Artifacts — Indice

**Cartella**: `executive/`  
**Framework di riferimento**: [6_STRATEGY_FRAMEWORK.md](../6_STRATEGY_FRAMEWORK.md) (`6_STRATEGY`)  
**Versione indice**: 1.0  
**Ultima modifica**: 2026-07-24  
**Compatibile con**: `0_META` v1.6 · [FRAMEWORK_MATURITY.md](../FRAMEWORK_MATURITY.md)

---

## 🎯 Scopo

Artefatti **strategici ed esecutivi** che alimentano [DISCOVERY_CHECKLIST.md](../DISCOVERY_CHECKLIST.md) e la governance in [0_META_FRAMEWORK.md](../0_META_FRAMEWORK.md). Non sostituiscono Design, Execution o Operations — definiscono priorità, rischio, budget e organizzazione **prima** del ciclo operativo.

---

## 📋 Priorità adozione

| Priorità | Quando obbligatorio | Soglia maturity |
|:--------:|---------------------|-----------------|
| **P0** | Primo GO Discovery su prodotto revenue o prod con utenti | [FRAMEWORK_MATURITY](../FRAMEWORK_MATURITY.md) **≥ 2** |
| **P1** | Team **> 5** engineer o multi-servizio in produzione | Maturity **≥ 3** |
| **P2** | Ottimizzazione · template comunicazione su richiesta | Maturity **≥ 4** |

---

## 📊 Indice artefatti

### P0 — Fondamentali (compilare entro 30 giorni da GO)

| | Artefatto | Area `6_STRATEGY` | Owner tipico |
|---|-----------|-------------------|--------------|
| 📊 | [PORTFOLIO_PRIORITIZATION.md](./PORTFOLIO_PRIORITIZATION.md) | A · Portfolio | VP Product / Head of Eng |
| 🗺️ | [TECH_PRODUCT_ROADMAP.md](./TECH_PRODUCT_ROADMAP.md) | B · Roadmap | Product + Engineering |
| ⚠️ | [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md) | C · Risk | CRO / COO / CTO |
| 💰 | [FINOPS_BUDGET.md](./FINOPS_BUDGET.md) | D · FinOps | FinOps / CFO delegate |

### P1 — Struttura e governance (compilare entro 90 giorni)

| | Artefatto | Area `6_STRATEGY` | Owner tipico |
|---|-----------|-------------------|--------------|
| 🏗️ | [TEAM_TOPOLOGY_CHARTER.md](./TEAM_TOPOLOGY_CHARTER.md) | E · Topology | Eng Director / CTO |
| 🏛️ | [ARB_PROCESS.md](./ARB_PROCESS.md) | E · ARB | Principal Architect |
| 📜 | [COMPLIANCE_PROGRAM.md](./COMPLIANCE_PROGRAM.md) | F · Compliance | DPO / Security Lead |
| 📢 | [STAKEHOLDER_COMMS_TEMPLATES.md](./STAKEHOLDER_COMMS_TEMPLATES.md) | F · Comms | Comms / CEO office |

### P2 — Eccellenza e orizzonte (compilare entro 6 mesi · maturity ≥ 4)

| | Artefatto | Area `6_STRATEGY` | Owner tipico |
|---|-----------|-------------------|--------------|
| ⚙️ | [ENGINEERING_PRINCIPLES.md](./ENGINEERING_PRINCIPLES.md) | E · Standard | Fellow / CTO |
| 🎯 | [HORIZON_BETS.md](./HORIZON_BETS.md) | B · Horizon | CPO / CTO |
| 🤖 | [RESPONSIBLE_AI_POLICY.md](./RESPONSIBLE_AI_POLICY.md) | F · AI | CAIO / DPO |
| 📊 | [VENDOR_SCORECARD.md](./VENDOR_SCORECARD.md) | C · Vendor | Procurement |
| 🔍 | [M&A_TECH_DD_CHECKLIST.md](./M&A_TECH_DD_CHECKLIST.md) | C · M&A | Corp Dev / CTO |

---

## 🔀 Flusso di utilizzo

```
6_STRATEGY (framework)
    │
    ├── P0: portfolio · roadmap · risk · FinOps
    │
    ├── P1: topology · ARB · compliance · comms
    │
    ▼
DISCOVERY_CHECKLIST (GO con riferimento portfolio/roadmap)
    │
    ▼
1_DESIGN · 2_EXECUTION · 3_OPERATIONS · 5_BROWNFIELD
```

---

## 🔗 Cross-link framework operativi

| Documento | Uso con executive |
|-----------|-------------------|
| [README.md](../README.md) | Hub manuale |
| [0_META_FRAMEWORK.md](../0_META_FRAMEWORK.md) | Tier · self-audit · RACI |
| [1_DESIGN_FRAMEWORK.md](../1_DESIGN_FRAMEWORK.md) | ADR da ARB · pilastri da roadmap |
| [2_EXECUTION_FRAMEWORK.md](../2_EXECUTION_FRAMEWORK.md) | Delivery item Now |
| [3_OPERATIONS_FRAMEWORK.md](../3_OPERATIONS_FRAMEWORK.md) | Rischi operativi → risk register |
| [4_AI_AGENT_FRAMEWORK.md](../4_AI_AGENT_FRAMEWORK.md) | AI governance · Area F |
| [5_BROWNFIELD_FRAMEWORK.md](../5_BROWNFIELD_FRAMEWORK.md) | Priorità legacy nel portfolio |
| [DISCOVERY_CHECKLIST.md](../DISCOVERY_CHECKLIST.md) | Gate post-strategy |
| [FRAMEWORK_MATURITY.md](../FRAMEWORK_MATURITY.md) | Score adozione executive |

---

## ✅ Checklist adozione cartella `executive/`

- [ ] Tutti i P0 compilati con owner e data review
- [ ] Portfolio score collegato a almeno un GO Discovery documentato
- [ ] Roadmap Now allineata a sprint/quarter corrente
- [ ] Risk register con **0** rischi score ≥ 25 senza mitigazione
- [ ] FinOps alert configurati (80% / 95% budget)
- [ ] P1 pianificati con scadenza entro 90 giorni se team > 5

**Prossima review indice**: 2026-10-24
