# Discovery Checklist — Pre-Design / Pre-Brownfield

Usare **prima** di `1_DESIGN` (greenfield) o `5_BROWNFIELD` Area A (brownfield) quando l'obiettivo non è ancora un piano tecnico chiaro.

**Exit**: **GO** → Design o Brownfield · **NO-GO** → stop · **PIVOT** → rivalutare scope

---

## 1. Problema e obiettivo

- [ ] Problema descritto in **1 frase** verificabile
- [ ] Obiettivo **misurabile** (metrica + target + scadenza)
- [ ] **Non-obiettivi** espliciti (cosa NON si fa in questo ciclo)
- [ ] Utente/stakeholder identificato

**Esempio obiettivo**: "Ridurre p95 checkout da 800ms a <300ms entro 6 settimane"

---

## 2. Vincoli e contesto

- [ ] Budget/tempo massimo noto
- [ ] Stack esistente o vincoli tecnologici
- [ ] Dati sensibili / compliance (GDPR, pagamenti, health) → se sì, tier minimo **CRITICO**
- [ ] Dipendenze esterne critiche identificate

---

## 2b. Business case (CEO/CTO — obbligatorio se tier executive STRATEGIC o TACTICAL)

Usare template in [executive/PORTFOLIO_PRIORITIZATION.md](./executive/PORTFOLIO_PRIORITIZATION.md) e [executive/FINOPS_BUDGET.md](./executive/FINOPS_BUDGET.md).

- [ ] **Beneficio atteso** quantificato (€, tempo, utenti, revenue) con orizzonte
- [ ] **Costo totale** stimato (build + run 12 mesi) · confronto **build vs buy vs integrare**
- [ ] **ROI / payback** indicativo o scenario *do nothing*
- [ ] **Strategic fit** (1–5) allineato a [executive/TECH_PRODUCT_ROADMAP.md](./executive/TECH_PRODUCT_ROADMAP.md)
- [ ] **Rischio enterprise** registrato o aggiornato in [executive/ENTERPRISE_RISK_REGISTER.md](./executive/ENTERPRISE_RISK_REGISTER.md) se score ≥ 15
- [ ] Riferimento voce **portfolio** o roadmap Now (ID iniziativa)

**Soglia NO-GO**: costo > beneficio atteso **oppure** payback > **24 mesi** senza strategic fit ≥ 4.

---

## 3. Build vs buy vs integrare

| Opzione | Quando preferirla | Da documentare |
|---------|-------------------|----------------|
| **Build** | requisito unico, controllo totale | stima effort |
| **Buy/SaaS** | commodity, time-to-market | vendor lock-in (Pilastro 9) |
| **Integrare** | esiste API/library matura | contratto, SLA vendor |

- [ ] **≥ 2 alternative** valutate · scelta preliminare motivata (bozza ADR)

---

## 4. Spike / fattibilità (se incertezza alta)

- [ ] Spike time-boxed **≤ 2 giorni** con domanda precisa
- [ ] Output spike: dimostrazione, numeri, o blocco documentato
- [ ] Spike **non** va in produzione

---

## 5. Decisione ingresso framework

| Esito | Criteri | Prossimo passo |
|-------|---------|----------------|
| **GO greenfield** | obiettivo chiaro, stack nuovo o modulo isolato | `1_DESIGN` Pilastri 1–2 minimo |
| **GO brownfield** | codebase esistente | `5_BROWNFIELD` Area A · tier **ASSESSMENT** |
| **PIVOT** | obiettivo o scope da cambiare | nuova discovery |
| **NO-GO** | costo > beneficio, rischio inaccettabile | documentare in ADR breve |

---

## 6. Collegamenti

- Strategy layer → [6_STRATEGY_FRAMEWORK.md](./6_STRATEGY_FRAMEWORK.md) · [executive/](./executive/README.md)
- Obiettivo approvato → [DEFINITION_OF_DONE.md](./DEFINITION_OF_DONE.md) per tier task
- Tier CRITICO → [security/THREAT_MODEL_TEMPLATE.md](./security/THREAT_MODEL_TEMPLATE.md) in Design
- Prod esistente → [DR_BACKUP_PLAN.md](./DR_BACKUP_PLAN.md) se mancante

**Regola agente AI**: idea vaga o "facciamo un'app per X" senza metriche → completare discovery · **non** iniziare codice.
