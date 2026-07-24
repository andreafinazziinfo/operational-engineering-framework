# Changelog — Manuale Framework Ingegneristico

Formato basato su [Keep a Changelog](https://keepachangelog.com/). Le versioni seguono ogni singolo documento; questo file traccia le modifiche al **set completo**.

## [2026-07-24] — Layer strategy C-level v1.6

### Aggiunto
- [6_STRATEGY_FRAMEWORK.md](./6_STRATEGY_FRAMEWORK.md) — 6 aree strategiche · tier STRATEGIC/TACTICAL/OPERATIONAL
- Cartella [executive/](./executive/README.md) — **13 artefatti** P0/P1/P2
- [ADR-002.md](./ADR-002.md) — decisione layer strategy
- [SELF_AUDIT_2026-07-24.md](./SELF_AUDIT_2026-07-24.md) — autovalutazione 9 pilastri + piano miglioramenti

### Modificato
- `0_META` v1.5 → **v1.6** — flusso strategy-first · RACI C-level · review calendar · circuit breaker org
- `4_AI_AGENT` v1.5 → **v1.6** — strategy gate · loading `6_STRATEGY` · escalation portfolio
- [DISCOVERY_CHECKLIST.md](./DISCOVERY_CHECKLIST.md) — §2b business case
- [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) — maturity organizzazione 0–5
- [3_OPERATIONS_FRAMEWORK.md](./3_OPERATIONS_FRAMEWORK.md) — comms stakeholder P1
- [AGENTS.md](./AGENTS.md) · [README.md](./README.md) — layer 6 · executive index

---

## [2026-07-24] — Artefatti trasversali v1.5

### Aggiunto
- [DISCOVERY_CHECKLIST.md](./DISCOVERY_CHECKLIST.md) — pre-design go/no-go
- [DEFINITION_OF_DONE.md](./DEFINITION_OF_DONE.md) — DoD per tier
- [DR_BACKUP_PLAN.md](./DR_BACKUP_PLAN.md) — RTO/RPO · restore drill
- [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) — score adozione 0–5
- [security/THREAT_MODEL_TEMPLATE.md](./security/THREAT_MODEL_TEMPLATE.md) — STRIDE tier CRITICO
- Matrice severità P1/P2/P3 in `runbooks/README.md`

### Modificato
- `0_META` v1.4 → **v1.5** — flusso discovery · maturity · circuit breaker
- `4_AI_AGENT` v1.4 → **v1.5** — discovery gate · DoD · threat model · DR escalation
- `README`, `AGENTS.md`, `1_DESIGN` P8, `2_EXECUTION`, `3_OPERATIONS` — collegamenti

---

### Aggiunto
- [5_BROWNFIELD_FRAMEWORK.md](./5_BROWNFIELD_FRAMEWORK.md) — 5 aree: baseline, bottleneck, API boundary, polyglot rewrite, legacy fit
- [ADR-001.md](./ADR-001.md) — decisione architetturale brownfield
- Tier adozione **ASSESSMENT | INCREMENTAL | FULL** in `0_META` e `4_AI_AGENT`
- Classification **GREENFIELD vs BROWNFIELD** in `4_AI_AGENT`
- Escalation: rewrite senza ADR · breaking API senza contract test · merge durante ASSESSMENT

### Modificato
- `0_META` v1.3 → **v1.4**
- `4_AI_AGENT` v1.3 → **v1.4**
- `README.md`, `AGENTS.md`, `ADR-000.md` — flusso brownfield
- `3_OPERATIONS` Area D — gate `5_BROWNFIELD` su codebase esistente
- `1_DESIGN` — nota ingresso brownfield

---

### Aggiunto
- [AGENTS.md](./AGENTS.md) — entry point Cursor/agent con prompt di sistema
- Prossimo self-audit consigliato in `0_META` (2026-10-24)
- Cross-check ledger, runbooks, AGENTS in `0_META`

### Modificato
- `0_META` — esito autovalutazione aggiornato · link ledger coerenti · audit esteso

---

### Aggiunto
- [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) — registro debito tecnico live
- [runbooks/](./runbooks/README.md) — 5 scenari incident (API offline, DB, error rate post-deploy, saturazione risorse, leak credenziali)
- **Data Provenance delle Fasi** in `2_EXECUTION` (6 fasi)
- **Data Provenance delle Aree** in `3_OPERATIONS` (5 aree)
- **Data Provenance delle Regole** in `4_AI_AGENT` (5 regole)
- Soglie quantitative estese in `2_EXECUTION` (fasi A–F) e `3_OPERATIONS` (aree A–E)

### Modificato
- `0_META` v1.2 → **v1.3** — cross-check mapping alias completato
- `2_EXECUTION` v2.0 → **v2.1** — provenance + soglie quantitative
- `3_OPERATIONS` v1.0 → **v1.1** — link ledger/runbook + provenance + soglie
- `4_AI_AGENT` v1.2 → **v1.3** — provenance regole + riferimento ledger
- Header `Compatibile con` allineati su tutti i documenti (incluso `4_AI_AGENT`)
- [ADR-000.md](./ADR-000.md) — colonna File con nomi espliciti per tutti i livelli

---

### Aggiunto
- Sezione **Data Provenance dei Pilastri** in `1_DESIGN` — tabella origine/fonte/riferimenti per tutti e 9 i pilastri
- **Checklist quantitativa Idempotency** (Pilastro 5): 6 soglie numeriche + exit criteria 4/6
- Soglie quantitative su Pilastri 1–4, 6–9 in `1_DESIGN`
- Test idempotency in `2_EXECUTION` Fase B
- Voce debito tecnico idempotency in `3_OPERATIONS` Area C
- Escalation trigger idempotency < 4/6 in `4_AI_AGENT`
- Campo `File:` negli header di ogni framework

### Modificato
- **Rename file** allineati agli alias:
  - `0_META_GOVERNANCE_FRAMEWORK.md` → `0_META_FRAMEWORK.md`
  - `1_SYSTEM_DESIGN_ARCHITECTURE_FRAMEWORK.md` → `1_DESIGN_FRAMEWORK.md`
  - `2_EXECUTION_DELIVERY_FRAMEWORK.md` → `2_EXECUTION_FRAMEWORK.md`
  - `3_OPERATIONS_EVOLUTION_FRAMEWORK.md` → `3_OPERATIONS_FRAMEWORK.md`
  - `4_AI_AGENT_PROMPTING_FRAMEWORK.md` → `4_AI_AGENT_FRAMEWORK.md`
- `0_META` v1.1 → **v1.2** — audit Data Provenance e Idempotency completati
- `1_DESIGN` v3.0 → **v3.1**
- `4_AI_AGENT` v1.1 → **v1.2** — mapping file aggiornato, trace idempotency

### Rimosso
- File con nomi legacy (sostituiti dai nuovi `*_FRAMEWORK.md`)

---

## [2026-07-24] — Revisione coerenza v1.1

### Aggiunto
- `README.md` — indice del manuale con alias canonici e matrice tier
- `ADR-000.md` — giustificazione struttura 9 pilastri / 6 fasi / 5 aree
- `CHANGELOG.md` — tracciamento modifiche condiviso
- Tier **STANDARD** in `0_META` (allineato a `4_AI_AGENT`)
- Matrice RACI in `0_META`
- Template ADR, Technical Debt Ledger, runbook incident in rispettivi documenti
- Metadati `Ultima modifica` e `Compatibile con` in ogni header

### Modificato
- `0_META` v1.0 → v1.1 — scope esteso a 5 documenti (incluso `4_AI_AGENT`)
- `4_AI_AGENT` v1.0 → v1.1 — Operations CRITICO: Area B/C (non A), regola re-classify mid-task
- `1_DESIGN` — fix riferimento Post-Mortem (Execution Fase F, non Operations)
- `1_DESIGN` — allineamento terminologia diagramma/titoli sezioni
- Checklist self-audit in `0_META` con stati espliciti (fatto / TODO)

### Corretto
- Riferimenti incrociati errati tra documenti
- Alias inconsistenti (`DESIGN_FRAMEWORK` → `1_DESIGN`, ecc.)
