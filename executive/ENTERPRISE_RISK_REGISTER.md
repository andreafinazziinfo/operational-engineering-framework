# ⚠️ Enterprise Risk Register

**Artefatto executive** · Area C · [6_STRATEGY](../6_STRATEGY_FRAMEWORK.md)  
**Priorità adozione**: **P0**  
**Versione**: 1.0  
**Ultima modifica**: 2026-07-24  
**Owner**: _________________ · **Prossima review completa**: _________________

---

## 🎯 Obiettivo

Registro centralizzato dei rischi **enterprise** (oltre il singolo progetto): probabilità × impatto, owner, mitigazione ed escalation al board quando richiesto.

---

## 📂 Categorie di rischio

| Categoria | Esempi | Fonte tipica |
|-----------|--------|--------------|
| **Operativo** | Outage multi-region · key person | [3_OPERATIONS](../3_OPERATIONS_FRAMEWORK.md) · runbooks |
| **Finanziario** | Burn rate · vendor concentration | [FINOPS_BUDGET.md](./FINOPS_BUDGET.md) |
| **Legale / Regolatorio** | GDPR · SOC2 gap · contratti | [COMPLIANCE_PROGRAM.md](./COMPLIANCE_PROGRAM.md) |
| **Reputazionale** | SLA breach · data leak | [STAKEHOLDER_COMMS_TEMPLATES.md](./STAKEHOLDER_COMMS_TEMPLATES.md) |
| **Tecnologico** | EOL stack · debt critico | [5_BROWNFIELD](../5_BROWNFIELD_FRAMEWORK.md) · ledger |

---

## 📐 Scoring probabilità × impatto

| | Impatto 1 | Impatto 2 | Impatto 3 | Impatto 4 | Impatto 5 |
|---|:---:|:---:|:---:|:---:|:---:|
| **Prob. 1** | 1 | 2 | 3 | 4 | 5 |
| **Prob. 2** | 2 | 4 | 6 | 8 | 10 |
| **Prob. 3** | 3 | 6 | 9 | 12 | 15 |
| **Prob. 4** | 4 | 8 | 12 | 16 | 20 |
| **Prob. 5** | 5 | 10 | 15 | 20 | **25** |

**Scale**:

- **Impatto 1–5**: 1 = trascurabile · 5 = esistenziale (business/legal)
- **Probabilità 1–5**: 1 = remota · 5 = imminente (< 90 giorni)

**Soglie**:

| Score | Livello | Azione |
|:-----:|---------|--------|
| **≥ 25** | Critico | Escalation **board** entro **7 giorni** · piano mitigazione |
| **20–24** | Alto | Owner executive · review **settimanale** |
| **15–19** | Medio | Piano mitigazione entro **30 giorni** |
| **< 15** | Basso | Monitoraggio trimestrale |

---

## 📋 Registro rischi (template)

| ID | Descrizione | Cat. | P | I | Score | Owner | Mitigazione | Target date | Stato |
|----|-------------|------|:-:|:-:|-------|-------|-------------|-------------|-------|
| ER-001 | | | | | | | | | Open/Mitigating/Closed |

- **Checklist mensile (rischi Alto/Critico)**:
  - [ ] Ogni rischio score ≥ 20 ha owner nominato e attivo?
  - [ ] Mitigazioni in ritardo > 30 giorni escalated?
  - [ ] Rischi operativi P1 post-mortem riflessi entro **14 giorni**?
  - [ ] Link a portfolio se rischio blocca iniziativa P-xxx?

---

## 🚨 Escalation al board

**Trigger obbligatori**:

1. Nuovo rischio score **≥ 25**
2. Rischio Critico senza mitigazione efficace dopo **30 giorni**
3. **≥ 2** incidenti P1 stesso root cause in **90 giorni**
4. Gap compliance con scadenza legale **< 60 giorni**

**Template escalation** (1 pagina): descrizione · score · impatto business · opzioni · raccomandazione · ask al board.

---

## 🔗 Collegamenti

| Documento | Relazione |
|-----------|-----------|
| [PORTFOLIO_PRIORITIZATION.md](./PORTFOLIO_PRIORITIZATION.md) | Risk = 5 blocca GO |
| [3_OPERATIONS](../3_OPERATIONS_FRAMEWORK.md) | Incidenti → risk register |
| [DR_BACKUP_PLAN.md](../DR_BACKUP_PLAN.md) | RTO/RPO · rischio data loss |
| [security/THREAT_MODEL_TEMPLATE.md](../security/THREAT_MODEL_TEMPLATE.md) | Rischi security tier CRITICO |
| [0_META](../0_META_FRAMEWORK.md) | Circuit breaker manuale |
| [FRAMEWORK_MATURITY.md](../FRAMEWORK_MATURITY.md) | Maturity ≤ 2 → rischio operativo |

---

## 📌 Retention

- Rischi **Closed**: mantenere storico **≥ 24 mesi** per audit
- Review completa registro: **trimestrale** (allineata a [6_STRATEGY](../6_STRATEGY_FRAMEWORK.md))
