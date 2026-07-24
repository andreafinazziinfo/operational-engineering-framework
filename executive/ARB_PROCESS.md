# 🏛️ Architecture Review Board (ARB) Process

**Artefatto executive** · Area E · [6_STRATEGY](../6_STRATEGY_FRAMEWORK.md)  
**Priorità adozione**: **P1**  
**Versione**: 1.0  
**Ultima modifica**: 2026-07-24  
**Chair ARB**: _________________ · **Cadence**: _________________

---

## 🎯 Obiettivo

Processo formale per review e approvazione decisioni architetturali: gate ADR, eccezioni tracciate e allineamento a [1_DESIGN](../1_DESIGN_FRAMEWORK.md) e roadmap [TECH_PRODUCT_ROADMAP.md](./TECH_PRODUCT_ROADMAP.md).

---

## 👥 Composizione ARB

| Ruolo | Responsabilità | Voto |
|-------|----------------|:----:|
| **Chair** (Principal Architect) | Agenda · decisione finale tecnica | Sì |
| **Platform lead** | Impatto infra · FinOps | Sì |
| **Security delegate** | Pilastro 8 · compliance | Sì (veto security) |
| **Product delegate** | Trade-off business | Consulted |
| **DRI servizio** | Contesto · implementazione | Presenter |

**Quorum**: Chair + **≥ 2** voter · Security veto su tier CRITICO se gap non mitigato.

---

## 🚦 Gate ARB — quando serve review

| Trigger | Tier task | Output ARB |
|---------|-----------|------------|
| Nuovo servizio in produzione | STANDARD/CRITICO | ADR Accettato |
| Cambio datastore / messaging core | CRITICO | ADR + threat model ref |
| Breaking API pubblica | STANDARD+ | ADR + migration plan |
| Eccezione a standard platform | Qualsiasi | Exception record |
| Spend infra > **$X**/mese nuovo | STANDARD+ | ADR Pilastro 9 |

**Soglia**: **100%** ADR tier CRITICO con stato **Accettato** prima del merge su main/prod.

---

## 📋 Workflow

```
Proposta (ADR Proposto) → Pre-read 48h → Sessione ARB → Accettato | Rifiutato | Differito
                              │
                              └── Eccezione temporanea (max 90 giorni) → debito in TECHNICAL_DEBT_LEDGER
```

1. **Submit** — autore apre ADR (template in [1_DESIGN](../1_DESIGN_FRAMEWORK.md)) · tag `arb-review`
2. **Pre-read** — membri commentano async · blocker entro 48h
3. **Sessione** — 30–60 min · decisione registrata nell'ADR
4. **Follow-up** — eccezioni con scadenza · review in ARB successivo

- **Checklist sessione**:
  - [ ] ≥ 2 alternative scartate documentate?
  - [ ] Blast radius (Pilastro 3) discusso?
  - [ ] Impatto [FINOPS_BUDGET](./FINOPS_BUDGET.md) stimato se infra?
  - [ ] Link a portfolio/roadmap ID?

---

## ⚠️ Eccezioni

| Campo | Valore |
|-------|--------|
| ID eccezione | EX-YYYYMMDD-NN |
| Standard derogato | |
| Motivazione business | |
| Risk accettato | |
| Compensating control | |
| Scadenza | max **90 giorni** |
| Owner remediation | |

Eccezioni attive → voce in [TECHNICAL_DEBT_LEDGER.md](../TECHNICAL_DEBT_LEDGER.md) impatto **Alto**.

---

## 🔗 Collegamenti

| Documento | Relazione |
|-----------|-----------|
| [1_DESIGN](../1_DESIGN_FRAMEWORK.md) | ADR · 9 pilastri |
| [TEAM_TOPOLOGY_CHARTER.md](./TEAM_TOPOLOGY_CHARTER.md) | DRI presenter |
| [COMPLIANCE_PROGRAM.md](./COMPLIANCE_PROGRAM.md) | Veto security |
| [4_AI_AGENT](../4_AI_AGENT_FRAMEWORK.md) | Agenti non bypassano ARB su CRITICO |
| [0_META](../0_META_FRAMEWORK.md) | Tier CRITICO non negoziabile |
| [DISCOVERY_CHECKLIST](../DISCOVERY_CHECKLIST.md) | Spike → ADR |

---

## 📌 Metriche ARB

| Metrica | Target |
|---------|--------|
| Time-to-decision | **≤ 10 giorni** lavorativi da submit |
| ADR CRITICO senza review | **0** |
| Eccezioni scadute non chiuse | **0** |
| Re-open stessa decisione | **< 2** / quarter (indica ADR incompleto) |
