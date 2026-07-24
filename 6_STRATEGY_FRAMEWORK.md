# 🎯 STRATEGY & EXECUTIVE GOVERNANCE FRAMEWORK
## Layer strategico sopra Discovery: portfolio, rischio, FinOps, organizzazione e compliance

**Documento**: Framework di governance strategica ed esecutiva — collega visione multi-quarter al ciclo operativo del manuale  
**Alias canonico**: `6_STRATEGY`  
**File**: `6_STRATEGY_FRAMEWORK.md`  
**Prerequisito**: [README.md](./README.md) · [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md) v1.6 · artefatti in [executive/](./executive/README.md)  
**Versione**: 1.0  
**Ultima modifica**: 2026-07-24  
**Compatibile con**: `0_META` v1.6, `1_DESIGN` v3.1, `2_EXECUTION` v2.1, `3_OPERATIONS` v1.1, `4_AI_AGENT` v1.6, `5_BROWNFIELD` v1.0  
**Principio guida**: La strategia definisce *cosa* e *perché*; Discovery e i framework operativi definiscono *come* e *quando*.

---

## 📋 PERCHÉ SERVE QUESTO LIVELLO

I framework `0_META`–`5_BROWNFIELD` governano **un progetto o un task**. Nessuno risponde da solo a:

- "Quali iniziative hanno priorità nel portfolio e perché?"
- "Come allineiamo roadmap prodotto e tecnica su 4–12 trimestri?"
- "Quali rischi enterprise richiedono escalation al board?"
- "Il burn rate cloud è sostenibile rispetto al revenue per unità?"
- "Chi decide l'architettura e come si organizzano platform vs product team?"
- "SOC2/GDPR e governance AI sono programmi continui, non checkbox pre-release?"

**Risposta**: `6_STRATEGY` + artefatti in `executive/`.

---

## 🧭 POSIZIONE NEL FLUSSO

Il layer strategico **siede sopra** Discovery e **alimenta** sia [DISCOVERY_CHECKLIST.md](./DISCOVERY_CHECKLIST.md) sia [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md).

```
STRATEGY (6_STRATEGY + executive/)
    │
    ├── Portfolio · roadmap · rischio · FinOps · org · compliance
    │
    ▼
DISCOVERY_CHECKLIST ──► GO / NO-GO / PIVOT
    │
    ├── GO greenfield ──► 1_DESIGN → 2_EXECUTION → 3_OPERATIONS
    │
    └── GO brownfield ──► 5_BROWNFIELD → Design / Execution / Ops
```

**Regole di alimentazione**:

- Ogni **GO** in Discovery deve referenziare almeno un elemento di portfolio o roadmap (`executive/PORTFOLIO_PRIORITIZATION.md` o `TECH_PRODUCT_ROADMAP.md`).
- Tier task operativi (LIGHT / STANDARD / CRITICO) derivano dal tier executive corrispondente (vedi sotto).
- Review trimestrale strategy ↔ [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) — maturity progetto **≥ 3** richiede P0 executive completati.

---

## 📋 LE 6 AREE STRATEGICHE

```
 A. PORTFOLIO & PRIORITIZATION     ──► Cosa fare prima · impact × effort × risk × fit
 B. TECH + PRODUCT ROADMAP         ──► Now / Next / Later · allineamento product-engineering
 C. ENTERPRISE RISK                ──► Registro rischi · probabilità × impatto · escalation board
 D. FINOPS & UNIT ECONOMICS        ──► Budget cloud · burn rate · chargeback · TCO
 E. ORG TOPOLOGY & ARB             ──► Platform vs product · Conway · DRI · Architecture Review Board
 F. COMPLIANCE & AI GOVERNANCE     ──► SOC2/GDPR continuo · policy agenti AI · audit trail
```

---

### A. 📊 PORTFOLIO & PRIORITIZATION

- **Artefatto**: [executive/PORTFOLIO_PRIORITIZATION.md](./executive/PORTFOLIO_PRIORITIZATION.md) · **Priorità**: P0
- **Obiettivo**: Decidere quali iniziative entrano nel ciclo Discovery con criteri oggettivi e review trimestrale.
- **Checklist**:
  - [ ] Matrice impact × effort × risk × strategic fit compilata per ogni iniziativa attiva?
  - [ ] Score numerico (1–5 per asse) con soglia minima **≥ 3.0** weighted per GO Discovery?
  - [ ] Review portfolio ogni trimestre (stesso trigger di [0_META](./0_META_FRAMEWORK.md) self-audit)?
  - [ ] Iniziative deprioritizzate documentate con motivazione (no silent drop)?

---

### B. 🗺️ TECH + PRODUCT ROADMAP

- **Artefatto**: [executive/TECH_PRODUCT_ROADMAP.md](./executive/TECH_PRODUCT_ROADMAP.md) · **Priorità**: P0
- **Obiettivo**: Allineare horizon prodotto e debito tecnico/infrastruttura su orizzonti Now / Next / Later.
- **Checklist**:
  - [ ] Template Now (0–3 mesi) / Next (3–9) / Later (9–18+) compilato?
  - [ ] Ogni item roadmap ha owner product **e** owner engineering?
  - [ ] Dipendenze cross-team esplicite (blocchi su ADR o ARB)?
  - [ ] Soglia: **100%** item Now con link a ticket/ADR o voce Discovery?

---

### C. ⚠️ ENTERPRISE RISK

- **Artefatto**: [executive/ENTERPRISE_RISK_REGISTER.md](./executive/ENTERPRISE_RISK_REGISTER.md) · **Priorità**: P0
- **Obiettivo**: Tracciare rischi oltre il singolo progetto — vendor, regolatorio, concentrazione talento, single-region.
- **Checklist**:
  - [ ] Categorie rischio definite (operativo, finanziario, legale, reputazionale, tecnologico)?
  - [ ] Ogni rischio: probabilità (1–5) × impatto (1–5) · score **≥ 15** → piano mitigazione obbligatorio?
  - [ ] Owner nominato per ogni rischio **Alto** (score ≥ 20)?
  - [ ] Escalation al board per rischi **≥ 25** o senza mitigazione entro **30 giorni**?

---

### D. 💰 FINOPS & UNIT ECONOMICS

- **Artefatto**: [executive/FINOPS_BUDGET.md](./executive/FINOPS_BUDGET.md) · **Priorità**: P0
- **Obiettivo**: Governare spend cloud, alert burn rate, chargeback e TCO per servizio/feature.
- **Checklist**:
  - [ ] Budget annuale e mensile cloud definiti con owner FinOps?
  - [ ] Alert burn rate: warning **≥ 80%** budget mensile · critical **≥ 95%**?
  - [ ] Chargeback o showback per team/prodotto attivo?
  - [ ] Template TCO compilato per ogni servizio tier CRITICO o revenue-bearing?

---

### E. 🏗️ ORG TOPOLOGY & ARB

- **Artefatti**: [executive/TEAM_TOPOLOGY_CHARTER.md](./executive/TEAM_TOPOLOGY_CHARTER.md) · [executive/ARB_PROCESS.md](./executive/ARB_PROCESS.md) · **Priorità**: P1
- **Obiettivo**: Allineare struttura team (platform vs product, Conway) e gate decisionali architetturali.
- **Checklist**:
  - [ ] Charter topology: team platform vs stream-aligned documentato?
  - [ ] DRI (Directly Responsible Individual) per ogni servizio core in produzione?
  - [ ] ARB definito con gate ADR per tier STANDARD/CRITICO e eccezioni tracciate?
  - [ ] Soglia: **100%** ADR tier CRITICO approvati da ARB prima del merge?

---

### F. 📜 COMPLIANCE & AI GOVERNANCE

- **Artefatti**: [executive/COMPLIANCE_PROGRAM.md](./executive/COMPLIANCE_PROGRAM.md) · [4_AI_AGENT_FRAMEWORK.md](./4_AI_AGENT_FRAMEWORK.md) · **Priorità**: P1
- **Obiettivo**: Programma compliance continuo (SOC2, GDPR) e policy agenti AI allineate al manuale.
- **Checklist**:
  - [ ] Programma SOC2/GDPR con controlli mappati a framework operativi?
  - [ ] Agenti AI: escalation e DoD allineati a [4_AI_AGENT](./4_AI_AGENT_FRAMEWORK.md) e audit trail?
  - [ ] Template comunicazione stakeholder per breach/regulatorio → [STAKEHOLDER_COMMS_TEMPLATES.md](./executive/STAKEHOLDER_COMMS_TEMPLATES.md)?
  - [ ] Review compliance almeno **semestrale** · gap → [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md)?

---

## 🏷️ TIER EXECUTIVE → TIER OPERATIVO

| Tier executive | Orizzonte | Criteri | Mapping operativo |
|----------------|-----------|---------|-------------------|
| **STRATEGIC** | Multi-quarter (6–18 mesi) | Visione portfolio · rischio enterprise · compliance program | Alimenta Discovery · non sostituisce Design |
| **TACTICAL** | Quarter (90 giorni) | Roadmap Now/Next · budget trimestre · ARB backlog | Task → **STANDARD** default · CRITICO se security/denaro |
| **OPERATIONAL** | Sprint / settimane | Esecuzione item Now · incidenti · FinOps alert | Task → **LIGHT** / **STANDARD** / **CRITICO** per [0_META](./0_META_FRAMEWORK.md) |

**Regola**: un'iniziativa STRATEGIC senza breakdown TACTICAL non entra in Discovery.

---

## 📎 INDICE ARTEFATTI EXECUTIVE

| Priorità | Artefatto | Area |
|:--------:|-----------|------|
| **P0** | [PORTFOLIO_PRIORITIZATION.md](./executive/PORTFOLIO_PRIORITIZATION.md) | A |
| **P0** | [TECH_PRODUCT_ROADMAP.md](./executive/TECH_PRODUCT_ROADMAP.md) | B |
| **P0** | [ENTERPRISE_RISK_REGISTER.md](./executive/ENTERPRISE_RISK_REGISTER.md) | C |
| **P0** | [FINOPS_BUDGET.md](./executive/FINOPS_BUDGET.md) | D |
| **P1** | [TEAM_TOPOLOGY_CHARTER.md](./executive/TEAM_TOPOLOGY_CHARTER.md) | E |
| **P1** | [ARB_PROCESS.md](./executive/ARB_PROCESS.md) | E |
| **P1** | [COMPLIANCE_PROGRAM.md](./executive/COMPLIANCE_PROGRAM.md) | F |
| **P1** | [STAKEHOLDER_COMMS_TEMPLATES.md](./executive/STAKEHOLDER_COMMS_TEMPLATES.md) | F |
| **P2** | [ENGINEERING_PRINCIPLES.md](./executive/ENGINEERING_PRINCIPLES.md) · [HORIZON_BETS.md](./executive/HORIZON_BETS.md) · [RESPONSIBLE_AI_POLICY.md](./executive/RESPONSIBLE_AI_POLICY.md) · [VENDOR_SCORECARD.md](./executive/VENDOR_SCORECARD.md) · [M&A_TECH_DD_CHECKLIST.md](./executive/M&A_TECH_DD_CHECKLIST.md) | B/C/F |

→ Indice completo: **[executive/README.md](./executive/README.md)**

---

## 🔗 COLLEGAMENTI TRASVERSALI

| Documento | Relazione con `6_STRATEGY` |
|-----------|----------------------------|
| [README.md](./README.md) | Mappa framework · aggiungere `6_STRATEGY` al ciclo |
| [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md) | Governance manuale · tier task · self-audit trimestrale |
| [1_DESIGN_FRAMEWORK.md](./1_DESIGN_FRAMEWORK.md) | ADR e pilastri eseguono decisioni ARB/roadmap |
| [2_EXECUTION_FRAMEWORK.md](./2_EXECUTION_FRAMEWORK.md) | Delivery item Now/Next |
| [3_OPERATIONS_FRAMEWORK.md](./3_OPERATIONS_FRAMEWORK.md) | SLO, incidenti, rischio operativo → risk register |
| [4_AI_AGENT_FRAMEWORK.md](./4_AI_AGENT_FRAMEWORK.md) | Governance agenti · Area F |
| [5_BROWNFIELD_FRAMEWORK.md](./5_BROWNFIELD_FRAMEWORK.md) | Priorità portfolio su legacy |
| [DISCOVERY_CHECKLIST.md](./DISCOVERY_CHECKLIST.md) | Gate ingresso post-strategy |
| [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) | Maturity ≥ 3 richiede P0 executive |

---

## 📊 SOGLIE E REVIEW

| Evento | Frequenza | Output |
|--------|-----------|--------|
| Portfolio review | Trimestrale | Aggiornamento [PORTFOLIO_PRIORITIZATION](./executive/PORTFOLIO_PRIORITIZATION.md) |
| Roadmap sync | Mensile (Now) · trimestrale (Next/Later) | [TECH_PRODUCT_ROADMAP](./executive/TECH_PRODUCT_ROADMAP.md) |
| Risk register | Mensile rischi Alto · trimestrale completo | [ENTERPRISE_RISK_REGISTER](./executive/ENTERPRISE_RISK_REGISTER.md) |
| FinOps | Continuo (alert) · review mensile | [FINOPS_BUDGET](./executive/FINOPS_BUDGET.md) |
| Compliance | Semestrale | [COMPLIANCE_PROGRAM](./executive/COMPLIANCE_PROGRAM.md) |

**Prossima review strategy consigliata**: 2026-10-24 (allineata a [0_META](./0_META_FRAMEWORK.md) self-audit)

---

## 📌 Esito dell'Autovalutazione

`6_STRATEGY` collega visione executive al ciclo **Discovery → Design → Execution → Operations**, con artefatti P0/P1 misurabili e tier STRATEGIC/TACTICAL/OPERATIONAL mappati su LIGHT/STANDARD/CRITICO. **Pronto per adozione con `0_META` v1.6.**
