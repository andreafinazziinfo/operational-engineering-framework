# 📢 Stakeholder Communication Templates

**Artefatto executive** · Area F · [6_STRATEGY](../6_STRATEGY_FRAMEWORK.md)  
**Priorità adozione**: **P1**  
**Versione**: 1.0  
**Ultima modifica**: 2026-07-24  
**Owner Comms**: _________________

---

## 🎯 Obiettivo

Template riutilizzabili per comunicazioni executive: board update, breach SLA cliente, incidente regolatorio P1 — allineati a [3_OPERATIONS](../3_OPERATIONS_FRAMEWORK.md) e [COMPLIANCE_PROGRAM.md](./COMPLIANCE_PROGRAM.md).

**Regola**: personalizzare bracket `[...]` · non inviare senza review Legal su template **Regulatory** e **Customer SLA**.

---

## 📊 Template 1 — Board Update (mensile/trimestrale)

**Subject**: `[Company] — Engineering & Product Update · [Month YYYY]`

```markdown
## Executive summary
[2–3 frasi: stato generale · 1 win · 1 risk]

## Portfolio & roadmap
- Top 3 deliverables completati: [...]
- Now horizon ([TECH_PRODUCT_ROADMAP](./TECH_PRODUCT_ROADMAP.md)): [...]
- Slippage material: [...] · mitigazione [...]

## Metrics
| Metric | Target | Actual | Trend |
|--------|--------|--------|-------|
| Uptime / SLO | | | |
| Burn rate cloud ([FINOPS_BUDGET](./FINOPS_BUDGET.md)) | | | |
| Maturity ([FRAMEWORK_MATURITY](../FRAMEWORK_MATURITY.md)) | ≥ 3 | | |

## Enterprise risk ([ENTERPRISE_RISK_REGISTER](./ENTERPRISE_RISK_REGISTER.md))
- New Alto/Critico: [...]
- Closed: [...]
- Ask board: [decision / budget / hire] or "None"

## Next period
- [...]
```

**Checklist pre-invio**:
- [ ] Numeri verificati con FinOps e Ops
- [ ] Risk score ≥ 20 menzionati con piano
- [ ] Nessun dato personale o segreto commerciale non pubblico

---

## 📊 Template 2 — Customer SLA Breach

**Subject**: `[Service] — Service Impact Notification · [Incident ID]`

**Severità**: P1/P2 · **Invio entro**: P1 **≤ 1h** dalla conferma impatto · P2 **≤ 4h**

```markdown
## What happened
[Descrizione fact-based · no root cause speculation prematura]

## Impact
- Affected services: [...]
- Time window (UTC): [start] – [end] · Duration: [...]
- Customer impact: [API errors / latency / feature unavailable]

## Current status
[Investigating | Mitigated | Resolved]

## What we are doing
[Immediate actions · workaround if any]

## Next update
[Time UTC] or "within [X] hours"

## Contact
[support@ / status page URL]
```

- **Checklist**:
  - [ ] Allineato a post-mortem interno ([2_EXECUTION](../2_EXECUTION_FRAMEWORK.md) Fase F)?
  - [ ] Contract SLA credits valutati con Legal?
  - [ ] Voce risk register se pattern ripetuto?

---

## 📊 Template 3 — Regulatory / Legal P1

**Subject**: `[INTERNAL] Regulatory Incident · [ID] · LEGAL PRIVILEGED`

**Audience**: DPO · Legal · CEO · Board (se score risk ≥ 25)

```markdown
## Classification
- Type: [GDPR breach | Regulatory inquiry | Law enforcement | Other]
- Discovery time (UTC): [...]
- Reporter: [...]

## Facts known
[Data categories · approximate records · systems · geography]

## Unknowns / open questions
[...]

## Immediate containment
[Access revoked · system isolated · preservation hold]

## Regulatory timeline
- GDPR 72h notification required: [Yes/No/TBD] · Deadline UTC: [...]
- Authority: [...]

## Recommended communications
- Internal: [...]
- Customers: [Template 2 variant / none yet]
- Regulator: [draft with Legal only]

## Owners
- Incident commander: [...]
- DPO: [...]
- Legal: [...]
```

- **Checklist**:
  - [ ] Legal review **before** any external comms
  - [ ] [COMPLIANCE_PROGRAM](./COMPLIANCE_PROGRAM.md) breach procedure seguita
  - [ ] [STAKEHOLDER] — no marketing tone · facts only
  - [ ] Escalation [ENTERPRISE_RISK_REGISTER](./ENTERPRISE_RISK_REGISTER.md) entro **24h**

---

## 🔗 Collegamenti

| Documento | Relazione |
|-----------|-----------|
| [3_OPERATIONS](../3_OPERATIONS_FRAMEWORK.md) | Severità P1/P2/P3 |
| [runbooks/](../runbooks/README.md) | Incident response |
| [COMPLIANCE_PROGRAM.md](./COMPLIANCE_PROGRAM.md) | GDPR · SOC2 |
| [0_META](../0_META_FRAMEWORK.md) | Post-incidente governance |
| [4_AI_AGENT](../4_AI_AGENT_FRAMEWORK.md) | Agenti non inviano comms esterne |

---

## 📌 Retention template usage

- Log invii customer/regulatory **≥ 7 anni** (o policy legale dominio)
- Post-mortem linkato a ogni Template 2 su P1
