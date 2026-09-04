# 🎯 Horizon Bets

| Campo | Valore |
|-------|--------|
| **Versione** | 1.0 |
| **Data** | 2026-07-24 |
| **Owner** | CPO / CTO |
| **Review cycle** | Trimestrale |

> Portfolio di scommesse strategiche per orizzonte temporale. Ogni bet richiede spike in [DISCOVERY_CHECKLIST](../DISCOVERY_CHECKLIST.md) (§4) prima dell'investimento significativo.

---

## 🔗 Collegamenti

| Documento | Ruolo |
|-----------|-------|
| [6_STRATEGY_FRAMEWORK.md](../6_STRATEGY_FRAMEWORK.md) | Visione e priorità strategiche |
| [DISCOVERY_CHECKLIST](../DISCOVERY_CHECKLIST.md) | Spike time-boxed pre-investimento |
| [1_DESIGN — Pilastro 9](../1_DESIGN_FRAMEWORK.md) | Cost model · capacity · vendor exit |
| [5_BROWNFIELD](../5_BROWNFIELD_FRAMEWORK.md) | Vincoli su sistemi esistenti |
| [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md) | Rischi portfolio |

---

## 🗺️ Modello H1 / H2 / H3

| Orizzonte | Tempo | Obiettivo | Budget |
|-----------|-------|-----------|--------|
| **H1 — Core** | 0–12 mesi | Revenue e retention su prodotti esistenti | 60–70% |
| **H2 — Adjacent** | 12–24 mesi | Nuovi segmenti, moduli, partnership | 20–30% |
| **H3 — Transform** | 24–36+ mesi | Scommesse disruptive, nuovi business model | 5–15% |

---

## 📊 Portfolio (template)

| Bet ID | Nome | H | Ipotesi | Owner | Stato |
|--------|------|---|---------|-------|-------|
| BET-H1-001 | _Self-service onboarding_ | H1 | _TTV −40%_ | _Squad X_ | 🟢 Active |
| BET-H2-001 | _Marketplace integrazioni_ | H2 | _Canale B2B2C_ | _Squad Y_ | 🟡 Discovery |
| BET-H3-001 | _AI-native workflow_ | H3 | _10x produttività_ | _Innovation Lab_ | 🔵 Spike |

---

## 🔬 Gate DISCOVERY (obbligatorio)

Prima di *Idea → Active*, completare [DISCOVERY spike](../DISCOVERY_CHECKLIST.md):

- [ ] Problema validato (≥5 interviste o dati quantitativi)
- [ ] Metrica primaria e soglia di successo definite
- [ ] Effort tecnico e dipendenze [5_BROWNFIELD](../5_BROWNFIELD_FRAMEWORK.md)
- [ ] Risk assessment in [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md)
- [ ] Go/No-Go con sponsor executive

---

## 📈 Progressione · 🛑 Kill · 🔀 Pivot

| Transizione | Criteri |
|-------------|---------|
| Idea → Discovery | Allineamento [6_STRATEGY_FRAMEWORK.md](../6_STRATEGY_FRAMEWORK.md) |
| Discovery → Pilot | Spike OK; MVP ≤8 settimane |
| Pilot → Scale | KPI ≥ soglia per 2 cicli; unit economics positivi |
| Scale → H1 Core | Revenue material; ownership permanente |

**Kill** (2 review consecutive con una condizione vera): KPI <50% target · Costo >150% budget · Blocco dipendenza >90gg · Cambio strategico · Rischio regolatorio non mitigabile

**Pivot:** segmento errato → cambio ICP · tech immatura → partnership/vendor · legacy → [5_BROWNFIELD](../5_BROWNFIELD_FRAMEWORK.md) + wrapper API

---

## 📅 Governance

| Ritual | Frequenza | Output |
|--------|-----------|--------|
| Bet review | Mensile | Status RAG |
| Portfolio committee | Trimestrale | Kill / Pivot / Scale |
| Strategy sync | Semestrale | Ribilanciamento H1/H2/H3 |

---

## ✅ Chiusura bet

- [ ] Post-mortem o success story · Metriche archiviate
- [ ] Rischi chiusi in [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md)
- [ ] Learnings linkati al prossimo [DISCOVERY spike](../DISCOVERY_CHECKLIST.md)
