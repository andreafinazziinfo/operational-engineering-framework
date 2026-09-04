# 🤖 Responsible AI Policy

| Campo | Valore |
|-------|--------|
| **Versione** | 1.0 |
| **Data** | 2026-07-24 |
| **Owner** | Chief AI Officer / DPO / Legal |
| **Estende** | [4_AI_AGENT](../4_AI_AGENT_FRAMEWORK.md) |

> Policy vincolante per sistemi AI e agenti. Integra e specializza [4_AI_AGENT](../4_AI_AGENT_FRAMEWORK.md).

---

## 🔗 Collegamenti

| Documento | Ruolo |
|-----------|-------|
| [4_AI_AGENT](../4_AI_AGENT_FRAMEWORK.md) | Framework operativo agenti AI |
| [6_STRATEGY_FRAMEWORK.md](../6_STRATEGY_FRAMEWORK.md) | Use case AI approvati |
| [1_DESIGN — Pilastro 8](../1_DESIGN_FRAMEWORK.md) | Security · dati sensibili |
| [5_BROWNFIELD](../5_BROWNFIELD_FRAMEWORK.md) | AI su dati/processi legacy |
| [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md) | Rischi AI e compliance |
| [VENDOR_SCORECARD.md](./VENDOR_SCORECARD.md) | Due diligence vendor LLM |

---

## 🎯 Ambito

Modelli ML, LLM, agenti (RAG, tool-use), copilot, automazioni decisionali, training/fine-tuning su dati aziendali.

- [ ] Use case registrato in catalogo 4_AI_AGENT
- [ ] Risk tier assegnato prima del pilot
- [ ] No deploy production senza approvazione tier

---

## ⚖️ Bias & fairness

| Requisito | Implementazione |
|-----------|-----------------|
| Valutazione bias | Test su sottogruppi (genere, geografia, lingua) |
| Dataset | Provenienza e limiti documentati |
| Mitigazione | Threshold disparità; human review se superati |
| Monitoraggio | Drift e fairness in dashboard produzione |

- [ ] Gruppi sensibili definiti · Metriche equità su holdout/shadow · Escalation a comitato AI

---

## 🔍 Explainability

| Rischio | Requisito |
|---------|-----------|
| Basso | Disclosure "AI-generated"; fonti RAG citate |
| Medio | Motivazione + confidence; opt-out umano |
| Alto | Log decisionale, explainability strutturata, appeal path |

Copy UX conforme a [1_DESIGN — Pilastro 9](../1_DESIGN_FRAMEWORK.md). Utente informato AI vs umano.

---

## 👤 Human-in-the-loop

| Scenario | HITL |
|----------|------|
| Decisioni legali/finanziarie | ✅ Approvazione umana |
| Azioni irreversibili | ✅ Conferma esplicita |
| Bassa confidence | ✅ Fallback umano |

Agenti ([4_AI_AGENT](../4_AI_AGENT_FRAMEWORK.md)): tool side-effect gated · kill switch ≤5 min · audit trail azioni autonome

---

## 📋 Audit & accountability

| Elemento | Retention |
|----------|-----------|
| Prompt + output (PII redacted) | 12 mesi |
| Decision log alto rischio | 7 anni |
| Incident AI | Permanente (summary) |

- [ ] Audit annuale use case alto rischio · RCA ≤5gg per P2+ · Incidenti → [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md)

---

## 🗄️ Data & training policy

| Regola | Dettaglio |
|--------|-----------|
| Consent | Training solo con base legale documentata |
| PII | Pseudonimizzazione; no categorie speciali salvo eccezione legale |
| Customer data | No training generico senza contratto |
| Vendor models | [VENDOR_SCORECARD.md](./VENDOR_SCORECARD.md) + training opt-out |

- [ ] Data lineage · Ambienti train/staging/prod separati · Right to erasure (unlearning/retirement)

---

## 🚦 Risk tier & go-live

| Tier | Esempi | Approvazione |
|------|--------|--------------|
| T1 | Summarization interna | Team lead |
| T2 | Customer chatbot | AI Committee |
| T3 | Underwriting, HR screening | Executive + DPO + Legal |

**Go-live:** risk tier · HITL testato · monitoring (latency, drift, toxicity) · runbook incident · allineamento [6_STRATEGY_FRAMEWORK.md](../6_STRATEGY_FRAMEWORK.md)

Violazioni → sospensione → AI Committee → [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md)
