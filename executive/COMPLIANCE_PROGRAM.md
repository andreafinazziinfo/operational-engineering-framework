# 📜 Compliance Program (SOC2 / GDPR)

**Artefatto executive** · Area F · [6_STRATEGY](../6_STRATEGY_FRAMEWORK.md)  
**Priorità adozione**: **P1**  
**Versione**: 1.0  
**Ultima modifica**: 2026-07-24  
**Owner (DPO/Security)**: _________________ · **Prossimo audit**: _________________

---

## 🎯 Obiettivo

Programma **continuo** di compliance — non checklist pre-release — mappato ai framework operativi, con controlli SOC2/GDPR e governance agenti AI ([4_AI_AGENT](../4_AI_AGENT_FRAMEWORK.md)).

---

## 📂 Scope programma

| Framework | Applicabilità | Owner controllo |
|-----------|---------------|-----------------|
| **SOC2 Type II** | Trust criteria CC · se dati clienti B2B | Security + Eng |
| **GDPR** | Dati personali UE/UK | DPO |
| **AI governance** | Agenti Cursor/automation su codice prod | Eng + Legal |

---

## ✅ Checklist SOC2 (continuo)

### CC6 — Logical access

- [ ] MFA su prod e repo **100%** engineer
- [ ] RBAC review **trimestrale** · orphan account **0**
- [ ] Secrets in vault · rotazione **≤ 90 giorni** (tier CRITICO)

### CC7 — System operations

- [ ] [3_OPERATIONS](../3_OPERATIONS_FRAMEWORK.md) Area A attiva · runbook ≥ 3
- [ ] [DR_BACKUP_PLAN.md](../DR_BACKUP_PLAN.md) · drill **≤ 12 mesi**
- [ ] Log retention **≥ 90 giorni** · access audit trail

### CC8 — Change management

- [ ] [2_EXECUTION](../2_EXECUTION_FRAMEWORK.md) · PR review · CI verde
- [ ] Tier CRITICO → [DEFINITION_OF_DONE](../DEFINITION_OF_DONE.md) + threat model
- [ ] [ARB_PROCESS.md](./ARB_PROCESS.md) per change architetturali

### CC9 — Risk mitigation

- [ ] [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md) aggiornato
- [ ] [security/THREAT_MODEL_TEMPLATE.md](../security/THREAT_MODEL_TEMPLATE.md) su path sensibili
- [ ] Post-mortem P1 entro **5 giorni** lavorativi

---

## ✅ Checklist GDPR (continuo)

- [ ] Registro trattamenti (RoPA) aggiornato
- [ ] Base giuridica documentata per ogni flusso dati personali
- [ ] DPIA per trattamenti ad alto rischio (profilazione · scale)
- [ ] DSR (access/delete/export) SLA **≤ 30 giorni**
- [ ] Sub-processor list pubblicata · DPA firmati
- [ ] Data residency documentata · transfer mechanism (SCC, ecc.)
- [ ] Breach procedure → [STAKEHOLDER_COMMS_TEMPLATES.md](./STAKEHOLDER_COMMS_TEMPLATES.md) · notifica autorità **≤ 72h** se richiesto

---

## 🤖 AI Governance (allineamento 4_AI_AGENT)

- [ ] Agenti seguono [AGENTS.md](../AGENTS.md) · tier declaration obbligatoria
- [ ] Nessun commit prod senza review umana su tier CRITICO
- [ ] Log prompt/action su repo sensibili (policy interna)
- [ ] Escalation agenti = escalation umana ([4_AI_AGENT](../4_AI_AGENT_FRAMEWORK.md) Sez. E)
- [ ] Training data / PII: **no** dati reali in prompt o esempi framework

---

## 📊 Mapping controlli → framework

| Controllo | Evidenza | Framework |
|-----------|----------|-----------|
| Change approval | PR history · ADR | `2_EXECUTION` · ARB |
| Monitoring | Dashboard · alert | `3_OPERATIONS` |
| Design security | Threat model | `1_DESIGN` P8 |
| Legacy gap | Debt ledger | `5_BROWNFIELD` |
| Maturity | Score ≥ 3 | [FRAMEWORK_MATURITY](../FRAMEWORK_MATURITY.md) |

---

## 🔗 Collegamenti

| Documento | Relazione |
|-----------|-----------|
| [STAKEHOLDER_COMMS_TEMPLATES.md](./STAKEHOLDER_COMMS_TEMPLATES.md) | Breach · regulatorio |
| [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md) | Rischio legale |
| [0_META](../0_META_FRAMEWORK.md) | Governance manuale |
| [DISCOVERY_CHECKLIST](../DISCOVERY_CHECKLIST.md) | Tier CRITICO se dati sensibili |

---

## 📌 Review

- Self-assessment checklist: **semestrale**
- Gap → [TECHNICAL_DEBT_LEDGER.md](../TECHNICAL_DEBT_LEDGER.md) · owner · target date
- External audit SOC2: pianificare **≥ 30 giorni** dopo self-assessment verde
