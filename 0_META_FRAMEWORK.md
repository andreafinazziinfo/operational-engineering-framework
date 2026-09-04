# 🧭 META-GOVERNANCE FRAMEWORK
## Governance del Manuale: Versionare, Auditare e Far Evolvere i 6 Framework + Layer AI + Strategy

**Documento**: Framework di governance applicato all'intero manuale (Strategy, Design, Execution, Operations, Brownfield, AI Agent)  
**Alias canonico**: `0_META`  
**File**: `0_META_FRAMEWORK.md`  
**Prerequisito**: Esistono `6_STRATEGY`, `1_DESIGN`, `2_EXECUTION`, `3_OPERATIONS`, `5_BROWNFIELD`, `4_AI_AGENT`, `7_COLLABORATION` (vedi [README.md](./README.md))  
**Versione**: 1.7  
**Ultima modifica**: 2026-09-04  
**Compatibile con**: `6_STRATEGY` v1.0, `1_DESIGN` v3.4, `2_EXECUTION` v2.3, `3_OPERATIONS` v1.1, `5_BROWNFIELD` v1.1, `4_AI_AGENT` v1.7, `7_COLLABORATION` v1.3  
**Principio guida**: Il manuale stesso è un sistema. Va progettato, eseguito e mantenuto con le sue stesse regole (dogfooding).

---

## 📋 PERCHÉ SERVE QUESTO LIVELLO

I sei framework operativi + il layer strategico coprono il ciclo **visione → progetto → delivery → ops**. Nessuno risponde da solo a:

- "Chi decide se il framework stesso è sbagliato o obsoleto?"
- "Come si aggiorna senza rompere la coerenza tra i documenti?"
- "Chi ha l'autorità di modificarlo?"
- "Come un agente AI applica il manuale in modo coerente?" → `4_AI_AGENT`, **governato** da questo documento
- "Come si applica il manuale a un progetto **già in sviluppo o finito**?" → `5_BROWNFIELD`, invocato via `4_AI_AGENT`
- "Quali iniziative hanno priorità a livello azienda?" → [`6_STRATEGY`](./6_STRATEGY_FRAMEWORK.md) + [`executive/`](./executive/README.md)
- "Come lavorano insieme owner e agente(i) AI **nel tempo**, tra sessioni?" → [`7_COLLABORATION`](./7_COLLABORATION_FRAMEWORK.md), caricato a inizio sessione (vedi [ADR-003.md](./ADR-003.md))

---

## 📋 LE 4 FUNZIONI DI GOVERNANCE

```
 A. VERSIONING & CHANGELOG  ──► Ogni modifica ai framework è tracciata e datata
 B. OWNERSHIP & RACI        ──► Chi propone, chi approva, chi applica le modifiche
 C. SELF-AUDIT PERIODICO    ──► Applicare i 9 Pilastri del Design ai framework stessi
 D. AI-AGENT GOVERNANCE     ──► Regole per quando un agente AI applica o modifica il manuale
```

---

### A. 📝 VERSIONING & CHANGELOG

- **Checklist**:
  - [x] Ogni file ha un header con Versione e Data ultima modifica? → **Sì**
  - [x] Esiste un CHANGELOG.md condiviso con motivazione di ogni cambio? → **[CHANGELOG.md](./CHANGELOG.md)**
  - [x] Le versioni sono coerenti tra loro? → Campo `Compatibile con` in ogni header
  - [x] I nomi file corrispondono agli alias? → `N_ALIAS_FRAMEWORK.md` (vedi README)
  - [ ] Le versioni vengono incrementate ad ogni modifica sostanziale? → **Processo attivo**

---

### B. 👤 OWNERSHIP & RACI

| Attività | Responsible | Accountable | Consulted | Informed |
|----------|-------------|-------------|-----------|----------|
| Proporre modifica al manuale | Chiunque (umano o agente) | Owner del manuale | Team / stakeholder | — |
| Approvare modifica | — | Owner del manuale | — | Team |
| Applicare modifica ai file | Owner o delegato | Owner del manuale | — | Team |
| Agent AI applica framework su task | Agente AI | Utente umano | — | — |
| Agent AI propone modifica al manuale | Agente AI | Owner del manuale | — | — |
| Portfolio / priorità iniziative | VP Product / Eng | CEO / CTO | Finance | Board |
| Escalation rischio enterprise ≥ 25 | Risk owner | CEO / board | Legal | Stakeholder |
| Approvazione ADR tier CRITICO | Tech lead | ARB ([executive/ARB_PROCESS.md](./executive/ARB_PROCESS.md)) | Security | Team |
| Comunicazione P1 a board/clienti | On-call / Comms | CEO / CTO | Legal | Clienti |

**Regola one-person**: l'owner è chi mantiene il repo; l'agente propone, l'umano approva sempre prima del merge.

- **Checklist**:
  - [x] È chiaro chi propone vs chi approva? → **Matrice RACI sopra**
  - [ ] Ogni pilastro/fase ha un "responsabile concettuale"? → **TODO: assegnare owner per pilastro in team > 1**

---

### C. 🔬 SELF-AUDIT PERIODICO

**Obiettivo**: Applicare i 9 Pilastri di `1_DESIGN` al manuale stesso, come se fosse un sistema software.

**Prossimo self-audit consigliato**: 2026-10-24 (trimestrale) o dopo incidente P1.

- **Checklist (stato audit 2026-07-24)**:
  - [x] **Pre-Mortem**: obsolescenza non rilevata → trigger trimestrale + post-incidente definito
  - [x] **ADR**: perché 9/6/5 pilastri? → **[ADR-000.md](./ADR-000.md)**
  - [x] **Blast Radius**: errore in `1_DESIGN` non invalida silenziosamente `2_EXECUTION` → alias = nomi file in README
  - [x] **Data Provenance**: origine di ogni pilastro → tabella in `1_DESIGN` sezione "Data Provenance dei Pilastri"
  - [x] **Idempotency**: checklist quantitative → Pilastro 5 in `1_DESIGN` v3.1 (6 soglie + exit criteria 4/6)
  - [x] **Chaos Test**: pilastri ignorati sotto deadline → tier LIGHT + regola non-negoziabilità CRITICO (sotto)
  - [x] **Circuit Breaker**: segnale "stop, framework non rispettato" → definito sotto
  - [x] **Security**: no dati sensibili reali negli esempi → regola esplicita in `1_DESIGN` Pilastro 8
  - [x] **Cost Model**: versione LIGHT per task piccoli → definita sotto
  - [x] **Provenance estesa**: fasi (`2_EXECUTION`), aree (`3_OPERATIONS`), regole AI (`4_AI_AGENT`)
  - [x] **Artefatti operativi**: [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) · [runbooks/](./runbooks/README.md) · [AGENTS.md](./AGENTS.md)
  - [x] **Brownfield**: adozione su codebase esistente → [5_BROWNFIELD_FRAMEWORK.md](./5_BROWNFIELD_FRAMEWORK.md) · [ADR-001.md](./ADR-001.md)
  - [x] **Artefatti trasversali**: [DISCOVERY_CHECKLIST.md](./DISCOVERY_CHECKLIST.md) · [DEFINITION_OF_DONE.md](./DEFINITION_OF_DONE.md) · [DR_BACKUP_PLAN.md](./DR_BACKUP_PLAN.md) · [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) · [security/THREAT_MODEL_TEMPLATE.md](./security/THREAT_MODEL_TEMPLATE.md)
  - [x] **Layer strategy**: [6_STRATEGY_FRAMEWORK.md](./6_STRATEGY_FRAMEWORK.md) · [executive/](./executive/README.md) · [ADR-002.md](./ADR-002.md)
  - [x] **Self-audit documentato**: [SELF_AUDIT_2026-07-24.md](./SELF_AUDIT_2026-07-24.md)

---

### D. 🤖 AI-AGENT GOVERNANCE

**Obiettivo**: Regole quando un agente AI applica o modifica questo manuale. Il protocollo operativo dettagliato è in `4_AI_AGENT`; qui le regole di governance.

- **Checklist**:
  - [x] L'agente dichiara pilastri/fasi applicati e saltati → `4_AI_AGENT` Sezione C
  - [x] Soglia di rischio con stop umano → `4_AI_AGENT` Sezione E (Escalation Triggers)
  - [x] L'agente aggiorna [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) quando prende scorciatoie → `4_AI_AGENT` Sezione D
  - [x] Modifiche ai framework passano da approvazione umana (Area B) → Escalation Trigger in `4_AI_AGENT`

---

## ⚡ FLUSSO COMPLETO (strategy → discovery → delivery)

```
6_STRATEGY + executive/ (portfolio · roadmap · risk · FinOps · org)
    │
    ▼
DISCOVERY (idea vaga) → DISCOVERY_CHECKLIST.md
    │
    ├── GO greenfield ──► 1_DESIGN → 2_EXECUTION → 3_OPERATIONS
    │
    └── GO brownfield ──► 5_BROWNFIELD A (ASSESSMENT) → tier INCREMENTAL/FULL
```

Ogni task: tier LIGHT / STANDARD / CRITICO · verifica [DEFINITION_OF_DONE.md](./DEFINITION_OF_DONE.md)  
Maturity progetto: [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) · maturity org: stessa sezione **organizzazione**

## ⚡ CLASSIFICAZIONE TASK (ASSESSMENT / LIGHT / STANDARD / CRITICO)

Allineata a `4_AI_AGENT` Sezione A. Vale per umani e agenti.

### Tier adozione progetto (solo codebase **esistente**)

| Tier adozione | Criteri | Framework |
|---------------|---------|-----------|
| **ASSESSMENT** | Prima applicazione manuale su codebase esistente | `5_BROWNFIELD` Area A (+ E se già in prod) · **zero merge** |
| **INCREMENTAL** | Baseline completata · change per modulo | `5_BROWNFIELD` area pertinente + tier sotto per ogni task |
| **FULL** | Redesign architetturale legacy | `5_BROWNFIELD` A + `1_DESIGN` completo + `2_EXECUTION` + `3_OPERATIONS` B/C |

**Regola ingresso brownfield**: se il progetto ha codice preesistente e non esiste baseline → **ASSESSMENT obbligatorio** prima di INCREMENTAL.

### Tier singolo task (greenfield e brownfield)

| Tier | Criteri | Framework |
|------|---------|-----------|
| **LIGHT** | < 2h stimate, nessun tocco a security / denaro reale / dati produzione | `2_EXECUTION` Fase B + D |
| **STANDARD** | > 2h **oppure** modulo persistente non critico | `1_DESIGN` Pilastri 1–2 + `2_EXECUTION` completo |
| **CRITICO** | Security, capitale reale, dati produzione, infrastruttura condivisa | `1_DESIGN` (9 pilastri) + `2_EXECUTION` + `3_OPERATIONS` Area B + C |

**Combinazioni brownfield frequenti**:
- Bottleneck / rewrite linguaggio → `5_BROWNFIELD` B o D + tier STANDARD/CRITICO
- Gap backend–frontend → `5_BROWNFIELD` C + tier STANDARD
- Prod senza monitoring → `5_BROWNFIELD` E + `3_OPERATIONS` Area B

**Non-negoziabilità minima (Chaos Test)**:
- Tier CRITICO: nessuna scorciatoia su Pilastri 2 (ADR), 7 (Circuit Breaker), 8 (Security)
- Tier LIGHT: vietato classificare LIGHT un task che tocca produzione o credenziali

---

## 🛑 CIRCUIT BREAKER DEL MANUALE

Segnale esplicito che il framework **non viene più rispettato** su un progetto:

1. Più di 2 task consecutivi classificati LIGHT su componenti che toccano dati sensibili
2. [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) con voci **Alto impatto** > 30 giorni senza revisione
3. Post-Mortem (`2_EXECUTION` Fase F) che identifica rischi previsti nel Pre-Mortem ma ignorati
4. [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) livello **≤ 2** su prod con utenti **> 30 giorni**
5. Maturity **organizzazione ≤ 2** con **≥ 2** prod attivi **> 90 giorni**
6. Iniziativa GO Discovery **senza** riferimento portfolio/roadmap ([6_STRATEGY](./6_STRATEGY_FRAMEWORK.md))

**Azione**: fermare nuove feature, eseguire audit con `1_DESIGN` completo, aggiornare tier e debito tecnico.

---

## 🔗 CROSS-CONSISTENCY CHECK

Prima di ogni release del manuale, verificare:

- [x] Nomi file = alias (`0_META_FRAMEWORK.md`, `1_DESIGN_FRAMEWORK.md`, …)
- [x] Tier ASSESSMENT/INCREMENTAL/FULL + LIGHT/STANDARD/CRITICO allineati in `0_META` e `4_AI_AGENT`
- [x] Versioni in header + CHANGELOG aggiornate
- [x] Nessun riferimento a nomi file obsoleti (`*_GOVERNANCE_*`, `*_DELIVERY_*`, ecc.)
- [x] Mapping alias in `4_AI_AGENT` Sezione B allineato → tabella Sezione B v1.3
- [x] [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) referenziato da Execution, Operations, AI, runbooks
- [x] [runbooks/](./runbooks/README.md) — **5 scenari** collegati da `3_OPERATIONS` Area A
- [x] [AGENTS.md](./AGENTS.md) — entry point Cursor/agent
- [x] [5_BROWNFIELD_FRAMEWORK.md](./5_BROWNFIELD_FRAMEWORK.md) — brownfield + [ADR-001.md](./ADR-001.md)
- [x] Artefatti trasversali: Discovery, DoD, DR, Maturity, Threat model template
- [x] `6_STRATEGY` + `executive/` (13 artefatti P0–P2) · [ADR-002.md](./ADR-002.md)
- [x] Cross-link P2 executive corretti · maturity org in FRAMEWORK_MATURITY
- [x] [7_COLLABORATION_FRAMEWORK.md](./7_COLLABORATION_FRAMEWORK.md) — igiene sessione/delega/verifica · [ADR-003.md](./ADR-003.md) · confine esplicito con `4_AI_AGENT` §E
- [x] [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) — colonna Categoria (Architetturale | Collaborazione/Tooling)
- [x] [BENCHMARK.md](./BENCHMARK.md) — confronto esterno, distinto dal self-audit interno · fonti verificate, non a memoria
- [x] [SPEC_TEMPLATE.md](./SPEC_TEMPLATE.md) — unità di lavoro implementabile, agganciato a `2_EXECUTION` Fase A
- [x] [.claude/skills/operational-engineering-framework/SKILL.md](./.claude/skills/operational-engineering-framework/SKILL.md) — skill canonica, 8 file coperti · [ADR-004.md](./ADR-004.md) · **non ancora verificata in sessione reale** (limite dichiarato)
- [x] [POST_MORTEM_TEMPLATE.md](./POST_MORTEM_TEMPLATE.md) — post-mortem compilabile, agganciato a `2_EXECUTION` Fase F
- [x] [scripts/check_consistency.sh](./scripts/check_consistency.sh) — verifica meccanica link + versioni, non solo self-report
- [x] [SELF_IMPROVEMENT_LOG.md](./SELF_IMPROVEMENT_LOG.md) — incidenti/gap reali e cosa è cambiato di conseguenza, revisionato ad ogni self-audit
- [x] [.github/workflows/check-consistency.yml](./.github/workflows/check-consistency.yml) — `scripts/check_consistency.sh` automatizzato su ogni push/PR
- [x] [NEXT_SESSION.md](./NEXT_SESSION.md) — handover per la sessione successiva (`7_COLLABORATION` Area A), sovrascritto a fine sessione

---

## 📅 REVIEW CALENDAR

| Review | Frequenza | Owner | Output |
|--------|-----------|-------|--------|
| Self-audit manuale (Area C) | Trimestrale | Owner manuale | Checklist `0_META` + [SELF_AUDIT](./SELF_AUDIT_2026-07-24.md) template + [scripts/check_consistency.sh](./scripts/check_consistency.sh) (verifica meccanica, non solo auto-dichiarata) + nuove voci in [SELF_IMPROVEMENT_LOG.md](./SELF_IMPROVEMENT_LOG.md) da revisionare |
| Benchmark esterno (coerenza vs framework reali) | Trimestrale (con self-audit) | Owner manuale | [BENCHMARK.md](./BENCHMARK.md) aggiornato · fonti riverificate |
| Strategy / portfolio | Trimestrale | CEO / CTO | [executive/PORTFOLIO_PRIORITIZATION.md](./executive/PORTFOLIO_PRIORITIZATION.md) |
| Maturity org | Annuale (+ trimestrale light) | CTO | [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) sezione org |
| Compliance | Semestrale | DPO / Security | [executive/COMPLIANCE_PROGRAM.md](./executive/COMPLIANCE_PROGRAM.md) |

**Prossima review consigliata**: 2026-10-24

## 📊 FRAMEWORK MATURITY (progetto)

Valutare ogni progetto con [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) · livelli **0–5**.

| Livello | Azione governance |
|---------|-------------------|
| 0–1 | Obbligo Discovery o Brownfield A prima di change |
| 2–3 | DoD STANDARD su change persistenti |
| 4–5 | DoD CRITICO · DR drill · threat model su path sensibili |

**Review**: trimestrale (stesso trigger self-audit) o post-incidente P1.

---

## 📌 Esito dell'Autovalutazione

Il manuale copre **strategy → discovery → greenfield/brownfield → delivery → ops**, con layer executive (CEO/CTO/Fellow), layer trasversale di collaborazione owner↔AI (`7_COLLABORATION`), DoD per tier, DR, threat modeling, maturity progetto **e organizzazione**, ledger, runbook e `AGENTS.md`. **Completo per uso operativo, governance C-level e igiene di collaborazione multi-sessione** — vedi [SELF_AUDIT_2026-07-24.md](./SELF_AUDIT_2026-07-24.md) (delta 2026-09-04 per `7_COLLABORATION` in coda al documento) e [BENCHMARK.md](./BENCHMARK.md) per il confronto esterno (5.9/10, non un 5/5 auto-dichiarato).
