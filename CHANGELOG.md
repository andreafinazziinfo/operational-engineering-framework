# Changelog — Manuale Framework Ingegneristico

Formato basato su [Keep a Changelog](https://keepachangelog.com/). Le versioni seguono ogni singolo documento; questo file traccia le modifiche al **set completo**.

## [2026-09-04] — Layer collaborazione owner-AI v1.7 + mental model mirati

### Aggiunto
- [7_COLLABORATION_FRAMEWORK.md](./7_COLLABORATION_FRAMEWORK.md) — layer trasversale, caricato a inizio sessione (non per-task) · 5 aree: Session Identity & Handover, Shared Working-Tree & Infra, Delegation & Sub-Agent Discipline, Verification & Trust Boundary, Tool & Permission Friction
- [ADR-003.md](./ADR-003.md) — decisione: nuovo file trasversale vs estendere `4_AI_AGENT`/`0_META`/`3_OPERATIONS`
- Colonna `Categoria` in [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) (Architetturale | Collaborazione/Tooling) — riuso del ledger esistente invece di un nuovo registro parallelo
- Circuit breaker dedicato ("Circuit Breaker della Collaborazione") distinto da quello del manuale (`0_META`) e da quello per-task (`4_AI_AGENT` §E)
- 5 mental model innestati come checklist item concreti nelle sezioni esistenti — **non** un nuovo pilastro/file, per evitare di diluire il manuale con contenuto non verificabile:
  - Effetti di secondo ordine → `1_DESIGN` Pilastro 1 (Pre-Mortem)
  - Falsificazione → `1_DESIGN` Pilastro 2 (ADR) + nuovo campo "Criterio di falsificazione" nel template ADR
  - Sunk cost check → `5_BROWNFIELD` Area D (Polyglot Rewrite)
  - Circle of competence → `7_COLLABORATION` Area C (Delegation)
  - Goodhart's Law → `7_COLLABORATION` Area D (Verification & Trust Boundary)
- [BENCHMARK.md](./BENCHMARK.md) — confronto esterno vs BMAD-METHOD, panorama Spec-Driven Development 2026, AWS/Google Well-Architected, Anthropic "Building Effective Agents" · rubric a 9 dimensioni, voto composito **3.2/5** (ricalibrato 2026-09-04: +1 dopo `SPEC_TEMPLATE.md`, −1 su governance dopo la scoperta dei link rotti dichiarati falsamente risolti) · distinto apposta dal self-audit interno (quello verifica coerenza con sé stesso, questo verifica tenuta contro l'esterno)
- Scala benchmark passata da **0–5** a **0–10** (stesso giorno, su richiesta owner per più precisione) — ogni dimensione ripensata da zero, non solo raddoppiata: voto composito **6.3/10** (dopo `scripts/check_consistency.sh`, `SELF_IMPROVEMENT_LOG.md` e la CI), leggermente più severo del 3.2/5 originale a parità di sostanza
- [.github/workflows/check-consistency.yml](./.github/workflows/check-consistency.yml) — `scripts/check_consistency.sh` automatizzato su ogni push/PR verso `main` · `BENCHMARK.md` dimensione 4 (Governance) 8/10→**9/10**
- [NEXT_SESSION.md](./NEXT_SESSION.md) — handover per la sessione successiva: primo task esplicito (verifica live della skill, non fattibile in questa sessione perché circolare), poi audit del framework su sé stesso, poi backlog con priorità onesta
- [SELF_IMPROVEMENT_LOG.md](./SELF_IMPROVEMENT_LOG.md) — registro di incidenti/gap reali e cosa è cambiato di conseguenza nel manuale, distinto da `TECHNICAL_DEBT_LEDGER.md` (quello traccia debito aperto, questo lezioni chiuse) · 5 voci da questa sessione · chiude parzialmente `BENCHMARK.md` dimensione 9 (1/10→**3/10**)
- **Reversibilità** ("one-way vs two-way door", mental model) → `1_DESIGN` Pilastro 2, campo dedicato nel template ADR. `1_DESIGN` v3.3→**v3.4**
- [POST_MORTEM_TEMPLATE.md](./POST_MORTEM_TEMPLATE.md) — post-mortem compilabile per `2_EXECUTION` Fase F (v2.2→**v2.3**), stesso gap già chiuso per Fase A con `SPEC_TEMPLATE.md`
- [scripts/check_consistency.sh](./scripts/check_consistency.sh) — verifica meccanica link rotti + coerenza versioni, eseguibile da chiunque · testato apposta (link e versione stale iniettati, poi rimossi) per confermare che rileva davvero problemi, non solo che li dichiara assenti
- **Incidente reale e fix**: `git checkout -- 0_META_FRAMEWORK.md` eseguito senza verificare prima `git status`, ha scartato tutte le modifiche non committate a quel file (fallback `sed` in una catena `||` non scattato perché il comando principale non ha fallito). File ricostruito e riverificato con `scripts/check_consistency.sh`. `7_COLLABORATION` Area B (v1.2→**v1.3**) rinforzata con 3 nuovi checklist item su comandi git distruttivi, `git stash` preferito a `checkout`/`reset --hard`, checkpoint via commit su lavoro non salvato che si accumula
- [SPEC_TEMPLATE.md](./SPEC_TEMPLATE.md) — artefatto per scomporre un design in unità di lavoro implementabili, agganciato a `2_EXECUTION` Fase A (v2.1→**v2.2**) · chiude parzialmente il gap 6 di `BENCHMARK.md` (1/5→2/5) · ispirato al concetto PRD→story di BMAD-METHOD (MIT, citato non copiato), riadattato nell'idioma gate+soglia del manuale
- [ADR-004.md](./ADR-004.md) + [.claude/skills/operational-engineering-framework/SKILL.md](./.claude/skills/operational-engineering-framework/SKILL.md) — skill canonica per Claude Code (standard aperto SKILL.md, dicembre 2025), generalizza `lead-architect-plan` già in uso in CycleLab/Titan: da 3 file coperti (`1_DESIGN`, `2_EXECUTION`, `4_AI_AGENT`) a tutti gli 8, nessuna versione hardcodata (causa della staleness osservata nella versione originale), zero riferimenti a progetti specifici. **Limite dichiarato**: non ancora verificata in una sessione Claude Code reale
- **Recency/Currency Check** (mental model, ricerca 2026 su knowledge cutoff staleness — arXiv STALE, "Always-On Agents") → `1_DESIGN` Pilastro 2 (ADR) + `7_COLLABORATION` Area D: claim time-sensitive verificati con ricerca live, mai per fiducia nel training data del modello. `1_DESIGN` v3.2→**v3.3** · `7_COLLABORATION` v1.1→**v1.2**
- [FAQ.md](./FAQ.md) — Q&A umano-orientate su tier, routing tra file, sessioni concorrenti, delega, verifica, governance del manuale · nessuna checklist duplicata, solo link ai file canonici · scritta a valle delle altre 3 iniziative per riflettere lo stato finale

### Corretto
- 11 link rotti pre-esistenti in 4 artefatti `executive/` P2 (`RESPONSIBLE_AI_POLICY`, `VENDOR_SCORECARD`, `M&A_TECH_DD_CHECKLIST`, `HORIZON_BETS`) — path verso una struttura a cartelle mai esistita, dichiarati "risolti" nel self-audit 2026-07-24 ma non lo erano. Verificato con controllo automatico su tutto il repo: **0 link rotti**. Addendum in [SELF_AUDIT_2026-07-24.md](./SELF_AUDIT_2026-07-24.md)

### Modificato
- `0_META` v1.6 → **v1.7** — riferimento `7_COLLABORATION` in "Perché serve questo livello" e cross-consistency check
- `4_AI_AGENT` v1.6 → **v1.7** — loading protocol: `7_COLLABORATION` a inizio sessione (Sezione B) · nuovo escalation trigger su circuit breaker collaborazione (Sezione E) · sezione "Relazione con 7_COLLABORATION" nell'header
- `1_DESIGN` v3.1 → **v3.2** · `5_BROWNFIELD` v1.0 → **v1.1** · `7_COLLABORATION` v1.0 → **v1.1** — mental model + `Compatibile con` propagato su tutti i file
- `README.md`, `AGENTS.md` — indice, badge (7→8 framework), nodo diagramma mermaid, sezione "Collaborazione owner-AI"

---

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
