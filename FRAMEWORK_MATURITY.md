# Framework Maturity — Score di adozione per progetto

Misura quanto un **progetto** (non il manuale) aderisce al framework.  
Usato in `0_META` self-audit e `5_BROWNFIELD` per fissare obiettivi di miglioramento.

**Valutazione**: trimestrale o dopo ogni incidente P1 · owner: ___ · data: ___

---

## Livelli 0–5

| Livello | Nome | Criteri sintetici |
|---------|------|-------------------|
| **0** | Assente | Nessuna baseline · nessun tier · nessun ledger |
| **1** | Consapevole | Discovery o Brownfield Area A fatta · tier usati informalmente |
| **2** | Baseline | Ledger attivo · ADR su dipendenze critiche · test CI base |
| **3** | Incremental | DoD STANDARD rispettata su change persistenti · runbook ≥ 3 scenari |
| **4** | Operativo | SLO + monitoring · restore drill ≤ 90 gg · post-mortem su P1/P2 |
| **5** | Maturo | DoD CRITICO su path sensibili · maturity review · idempotency 4/6+ · DR testato |

---

## Scorecard (segna per progetto)

| Criterio | Peso | Sì (1) / No (0) | Note |
|----------|------|-----------------|------|
| Discovery o Brownfield A completata | 1 | | |
| [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) attivo e revisionato ≤ 30 gg | 1 | | |
| ADR su 100% dipendenze critiche | 1 | | |
| CI: test + lint su ogni PR | 1 | | |
| [DEFINITION_OF_DONE.md](./DEFINITION_OF_DONE.md) applicata per tier | 1 | | |
| Runbook ≥ 3 scenari pertinenti | 1 | | |
| SLO definiti + dashboard | 1 | | |
| [DR_BACKUP_PLAN.md](./DR_BACKUP_PLAN.md) compilato + drill ≤ 90 gg | 1 | | |
| Threat model su ultimo change CRITICO | 1 | | |
| Post-mortem entro 48h su ultimo P1/P2 | 1 | | |

**Punteggio grezzo** = somma (max 10)

| Punteggio | Livello maturity |
|-----------|------------------|
| 0–2 | **0–1** |
| 3–4 | **2** |
| 5–6 | **3** |
| 7–8 | **4** |
| 9–10 | **5** |

---

## Target per contesto

| Contesto | Target minimo | Target ideale |
|----------|---------------|---------------|
| Side project / MVP | 2 | 3 |
| Prod con utenti reali | 3 | 4 |
| Dati sensibili / pagamenti | 4 | 5 |
| Brownfield appena onboarded | 1 → 3 in 90 gg | 4 entro 6 mesi |

---

## Piano di salita (esempio)

```
Oggi: livello 2
Obiettivo Q+1: livello 3
Azioni:
  - [ ] Definire 3 SLO (3_OPERATIONS B)
  - [ ] Completare 3 runbook
  - [ ] DoD STANDARD su prossime 5 PR
```

---

## Maturity organizzazione (0–5)

Misura quanto l'**organizzazione** aderisce al layer strategico + operativo. Complementa la scorecard progetto.

**Valutazione**: annuale (CEO/CTO) + trimestrale light · owner: ___ · data: ___

| Livello | Nome | Criteri sintetici |
|---------|------|-------------------|
| **0** | Reattiva | Nessun portfolio · firefighting |
| **1** | Consapevole | Discovery · roadmap informale |
| **2** | Baseline | P0 executive · FinOps alert |
| **3** | Strutturata | ARB · compliance · risk register |
| **4** | Allineata | Roadmap multi-anno · SLO ↔ KPI · vendor scorecard |
| **5** | Matura | Horizon bets · responsible AI · board review |

### Scorecard organizzazione

| Criterio | Peso | Sì (1) / No (0) | Note |
|----------|------|-----------------|------|
| [executive/PORTFOLIO_PRIORITIZATION.md](./executive/PORTFOLIO_PRIORITIZATION.md) attivo | 1 | | |
| [executive/TECH_PRODUCT_ROADMAP.md](./executive/TECH_PRODUCT_ROADMAP.md) Now/Next/Later | 1 | | |
| [executive/ENTERPRISE_RISK_REGISTER.md](./executive/ENTERPRISE_RISK_REGISTER.md) · 0 rischi ≥25 senza piano | 1 | | |
| [executive/FINOPS_BUDGET.md](./executive/FINOPS_BUDGET.md) · alert 80/95% | 1 | | |
| [executive/ARB_PROCESS.md](./executive/ARB_PROCESS.md) operativo | 1 | | |
| Maturity progetto media **≥ 3** su prod attivi | 1 | | |
| [executive/COMPLIANCE_PROGRAM.md](./executive/COMPLIANCE_PROGRAM.md) review ≤ 12 mesi | 1 | | |
| Comms P1 via [STAKEHOLDER_COMMS_TEMPLATES.md](./executive/STAKEHOLDER_COMMS_TEMPLATES.md) se richiesto | 1 | | |
| [executive/ENGINEERING_PRINCIPLES.md](./executive/ENGINEERING_PRINCIPLES.md) adottati | 1 | | |
| Review strategy trimestrale documentata | 1 | | |

**Target org**: startup **≥ 2** · scale-up **≥ 3** · enterprise/regulated **≥ 4**.

---

## Circuit breaker maturity

Se livello **≤ 2** su prod con utenti reali **> 30 giorni** → congelare feature non critiche fino a livello **≥ 3** (allineato a circuit breaker manuale in `0_META`).

---

## Collegamenti

- Governance review → `0_META` Area C · strategy → [6_STRATEGY](./6_STRATEGY_FRAMEWORK.md)
- Ingresso brownfield → `5_BROWNFIELD` Area A
- Agente AI: dichiarare maturity stimata in trace se valutazione richiesta
