# 🗺️ Tech + Product Roadmap

**Artefatto executive** · Area B · [6_STRATEGY](../6_STRATEGY_FRAMEWORK.md)  
**Priorità adozione**: **P0**  
**Versione**: 1.0  
**Ultima modifica**: 2026-07-24  
**Owner Product**: _________________ · **Owner Engineering**: _________________

---

## 🎯 Obiettivo

Allineare roadmap prodotto e tecnica su orizzonti **Now / Next / Later**, con owner duali e dipendenze esplicite verso [1_DESIGN](../1_DESIGN_FRAMEWORK.md) e [2_EXECUTION](../2_EXECUTION_FRAMEWORK.md).

---

## ⏱️ Orizzonti temporali

| Horizon | Finestra | Granularità | Review |
|---------|----------|-------------|--------|
| **Now** | 0–3 mesi | Sprint / milestone | Mensile |
| **Next** | 3–9 mesi | Quarter | Trimestrale |
| **Later** | 9–18+ mesi | Tema strategico | Trimestrale |

**Regola**: item **Now** senza owner entrambi i lati → non entra in sprint.

---

## 📋 Template Now / Next / Later

### Now (0–3 mesi)

| ID | Item | Tipo | Owner Product | Owner Eng | Portfolio ID | Tier | Dipendenze | Stato |
|----|------|------|---------------|-----------|--------------|------|------------|-------|
| R-N-01 | | Feature / Tech / Infra | | | P-xxx | LIGHT/STD/CRIT | ADR-xxx, team Y | Planned/In progress/Done |

### Next (3–9 mesi)

| ID | Item | Outcome misurabile | Portfolio ID | Blocchi noti |
|----|------|-------------------|--------------|--------------|
| R-X-01 | | | | |

### Later (9–18+ mesi)

| ID | Tema | Ipotesi da validare | Spike? |
|----|------|---------------------|--------|
| R-L-01 | | | Sì/No |

---

## 🤝 Allineamento Product ↔ Engineering

| Tipo item | Product lead | Engineering lead | Framework operativo |
|-----------|--------------|------------------|---------------------|
| Feature utente | Metriche · UX · rollout | API · performance · test | `1_DESIGN` 1–2 + `2_EXECUTION` |
| Piattaforma / infra | Abilitatore (indiretto) | SLO · cost · reliability | `3_OPERATIONS` + FinOps |
| Debito tecnico | Trade-off visibilità | [TECHNICAL_DEBT_LEDGER](../TECHNICAL_DEBT_LEDGER.md) | `5_BROWNFIELD` se legacy |
| Compliance | Requisito legale | Controlli · audit | [COMPLIANCE_PROGRAM](./COMPLIANCE_PROGRAM.md) |

- **Checklist sync mensile (Now)**:
  - [ ] **100%** item Now con ticket link o ADR?
  - [ ] Slippage > 2 sprint → spostamento a Next con motivazione?
  - [ ] Nessun item CRITICO in Now senza threat model pianificato?
  - [ ] Capacità engineering vs commitment Now ≤ **110%** (buffer 10%)?

---

## 🔗 Collegamenti

| Documento | Relazione |
|-----------|-----------|
| [PORTFOLIO_PRIORITIZATION.md](./PORTFOLIO_PRIORITIZATION.md) | ID portfolio per ogni item |
| [DISCOVERY_CHECKLIST.md](../DISCOVERY_CHECKLIST.md) | Nuovi item Now → GO |
| [ARB_PROCESS.md](./ARB_PROCESS.md) | Gate architettura item Next/CRITICO |
| [FINOPS_BUDGET.md](./FINOPS_BUDGET.md) | Costo infra in Now |
| [FRAMEWORK_MATURITY.md](../FRAMEWORK_MATURITY.md) | Maturity guida profondità Design |

---

## 📌 Anti-pattern

- Roadmap = lista wish senza outcome misurabile → **NO-GO** Discovery
- Now > **5** item paralleli per team < 8 persone → ridurre scope
- Later senza ipotesi → rimane tema, non entra in portfolio score
