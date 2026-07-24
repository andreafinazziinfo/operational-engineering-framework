# 📊 Portfolio Prioritization

**Artefatto executive** · Area A · [6_STRATEGY](../6_STRATEGY_FRAMEWORK.md)  
**Priorità adozione**: **P0**  
**Versione**: 1.0  
**Ultima modifica**: 2026-07-24  
**Owner**: _________________ · **Prossima review**: _________________

---

## 🎯 Obiettivo

Prioritizzare iniziative con matrice **impact × effort × risk × strategic fit**, score numerico e review trimestrale. Ogni **GO** in [DISCOVERY_CHECKLIST.md](../DISCOVERY_CHECKLIST.md) deve referenziare un ID portfolio.

---

## 📐 Matrice di scoring

| Asse | Scala 1–5 | 1 = | 5 = |
|------|-----------|-----|-----|
| **Impact** | Business/utente | Trascurabile | Trasformativo · revenue/retention |
| **Effort** | Costo/tempo (invertire) | Triviale (< 1 sprint) | Major (> 2 quarter) |
| **Risk** | Tecnico/regolatorio (invertire) | Basso · ben noto | Alto · unknown unknowns |
| **Strategic fit** | Allineamento visione | Off-strategy | Core strategic pillar |

**Formula weighted score** (default):

```
Score = (Impact × 0.35) + ((6 − Effort) × 0.25) + ((6 − Risk) × 0.20) + (Strategic fit × 0.20)
```

- **Soglia GO Discovery**: score **≥ 3.0**
- **Fast-track**: score **≥ 4.0** + owner executive → bypass coda portfolio
- **NO-GO automatico**: score **< 2.0** o Risk = 5 senza mitigazione in [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md)

---

## 📋 Registro iniziative (template)

| ID | Iniziativa | Impact | Effort | Risk | Fit | Score | Tier exec | Discovery | Stato |
|----|------------|:------:|:------:|:----:|:---:|:-----:|-----------|-----------|-------|
| P-001 | | | | | | | STRATEGIC/TACTICAL | GO/NO-GO | Backlog/Active/Done |
| P-002 | | | | | | | | | |

**Stati**: `Backlog` · `Active` (in Discovery+) · `Done` · `Deprioritized` (motivo obbligatorio)

---

## 🔄 Processo trimestrale

1. **Raccolta** — product, engineering, ops propongono voci (deadline: Giorno 1 del quarter)
2. **Scoring** — owner portfolio normalizza assi con stakeholder (≤ 5 giorni lavorativi)
3. **Allineamento** — sync con [TECH_PRODUCT_ROADMAP.md](./TECH_PRODUCT_ROADMAP.md) Now/Next
4. **Decisione** — top N per capacity (N = capacity team / effort medio)
5. **Comunicazione** — update board se ≥ 1 voce STRATEGIC cambia priorità

- **Checklist review**:
  - [ ] Tutte le voci Active hanno score aggiornato?
  - [ ] Deprioritized con motivazione in 1 paragrafo?
  - [ ] Capacità quarter vs somma effort Now documentata?
  - [ ] Link a [FRAMEWORK_MATURITY.md](../FRAMEWORK_MATURITY.md) se maturity < 3?

---

## 🔗 Collegamenti

| Documento | Relazione |
|-----------|-----------|
| [6_STRATEGY](../6_STRATEGY_FRAMEWORK.md) | Area A · tier STRATEGIC/TACTICAL |
| [DISCOVERY_CHECKLIST.md](../DISCOVERY_CHECKLIST.md) | Gate ingresso post-prioritization |
| [TECH_PRODUCT_ROADMAP.md](./TECH_PRODUCT_ROADMAP.md) | Horizon Now/Next/Later |
| [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md) | Risk = 5 → mitigazione |
| [0_META](../0_META_FRAMEWORK.md) | Tier task LIGHT/STANDARD/CRITICO |
| [5_BROWNFIELD](../5_BROWNFIELD_FRAMEWORK.md) | Iniziative legacy nel portfolio |

---

## 📌 Note operative

- Non more than **3** iniziative STRATEGIC **Active** contemporaneamente (focus).
- Effort stimato in **person-week** o **story-point normalizzati** — stessa unità ogni quarter.
- Agenti AI: non avviare Discovery senza ID portfolio o esplicita deroga documentata in ADR breve.
