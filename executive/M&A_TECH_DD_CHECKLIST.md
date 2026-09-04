# 🔍 M&A Tech Due Diligence Checklist

| Campo | Valore |
|-------|--------|
| **Versione** | 1.0 |
| **Data** | 2026-07-24 |
| **Owner** | CTO / Corp Dev / VP Engineering |
| **Confidentiality** | Strictly confidential |

> Due diligence tecnica per acquisizioni. Output alimenta deal evaluation e [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md) post-close.

---

## 🔗 Collegamenti

| Documento | Ruolo |
|-----------|-------|
| [6_STRATEGY_FRAMEWORK.md](../6_STRATEGY_FRAMEWORK.md) | Fit strategico |
| [5_BROWNFIELD](../5_BROWNFIELD_FRAMEWORK.md) | Integrazione legacy target |
| [1_DESIGN_FRAMEWORK.md](../1_DESIGN_FRAMEWORK.md) | Convergenza architetturale |
| [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md) | Rischi ereditati |
| [ENGINEERING_PRINCIPLES.md](./ENGINEERING_PRINCIPLES.md) | Standard post-close |
| [VENDOR_SCORECARD.md](./VENDOR_SCORECARD.md) · [RESPONSIBLE_AI_POLICY.md](./RESPONSIBLE_AI_POLICY.md) | Vendor e AI |

---

## 📁 Fase 0 — Setup

- [ ] NDA e data room · DD lead assegnato · Timeline definita
- [ ] Documenti richiesti: architettura, repo read-only, org chart, contratti vendor, incidenti 24 mesi, budget IT, IP software

---

## 🏗️ Architettura & piattaforma

| # | Area | Evidenza | ☐ |
|---|------|----------|---|
| A1 | Overview | Diagrammi prod/env/integrazioni | |
| A2 | Scalability | Load test, capacity plan | |
| A3 | SPOF | DB, vendor, region | |
| A4 | Tech stack | Linguaggi, EOL dates | |
| A5 | Data | Schema, lineage, quality | |

**Red flags:** no diagrammi · deploy manuale · no staging · shared DB multi-prodotto

---

## 💻 Engineering maturity

| # | Item | ☐ |
|---|------|---|
| C1 | CI/CD con test gate | |
| C2 | Test su path critici | |
| C3 | SBOM / CVE / license | |
| C4 | Runbook, API docs, CODEOWNERS | |
| C5 | Debt quantificato vs [ENGINEERING_PRINCIPLES.md](./ENGINEERING_PRINCIPLES.md) | |

---

## 🔒 Security & privacy

| # | Controllo | Evidenza |
|---|-----------|----------|
| S1 | Certificazioni (SOC2, ISO) | Scope e date |
| S2 | Pen test 12 mesi | MTTR |
| S3 | IAM, MFA, privileged access | |
| S4 | PII map, retention, cross-border | |
| S5 | Breach / incident history | |

- [ ] Gap vs standard acquirer · Costo remediation 12–24 mesi · Voce preliminare risk register

---

## 👥 Team · 📜 IP · 🤝 Vendor

**Team:** headcount vs revenue · top-5 key person · attrition >15% = yellow flag

**IP/OSS:** inventario IP · OSS copyleft audit · contenziosi · IP assignment · AI training provenance ([RESPONSIBLE_AI_POLICY.md](./RESPONSIBLE_AI_POLICY.md))

**Vendor:** contratti T1/T2 · change-of-control clauses · [VENDOR_SCORECARD.md](./VENDOR_SCORECARD.md) preliminare · SLA customer pass-through

---

## 🤖 AI assets · 🔗 Post-close

- [ ] Modelli prod, hosting, license · Bias assessment · Allineamento [4_AI_AGENT](../4_AI_AGENT_FRAMEWORK.md)

| Workstream | Framework |
|------------|-----------|
| Legacy integration | [5_BROWNFIELD](../5_BROWNFIELD_FRAMEWORK.md) |
| UX convergence | [1_DESIGN — Pilastro 9](../1_DESIGN_FRAMEWORK.md) |
| Strategy | [6_STRATEGY_FRAMEWORK.md](../6_STRATEGY_FRAMEWORK.md) |

---

## 📊 Deliverable & severità

| Output | Due |
|--------|-----|
| Tech DD report (RAG) | T+3 settimane |
| Remediation cost + integration size (S/M/L/XL) | Con report |
| Deal breakers | Immediato se critical |

| Level | Esempio |
|-------|---------|
| 🔴 Deal breaker | Breach non disclosure, IP contestato |
| 🟠 Major | No CI/CD, SOC2 assente B2B SaaS |
| 🟡 Minor | Debt, doc gaps — 100-day plan |

---

## ✅ Sign-off

Tech DD Lead · CISO · CTO · Corp Dev — data e firma
