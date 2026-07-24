# 🤖 AI-AGENT PROMPTING & INVOCATION FRAMEWORK
## Come un Agente AI Deve Leggere, Interpretare e Applicare i Framework

**Documento**: Layer di meta-prompting — istruzioni operative per agenti AI (Claude Code, Cursor, Antigravity, ecc.)  
**Alias canonico**: `4_AI_AGENT`  
**File**: `4_AI_AGENT_FRAMEWORK.md`  
**Prerequisito**: Esistono `0_META`, `1_DESIGN`, `2_EXECUTION`, `3_OPERATIONS`, `5_BROWNFIELD` (vedi [README.md](./README.md))  
**Versione**: 1.5  
**Ultima modifica**: 2026-07-24  
**Compatibile con**: `0_META` v1.5, `1_DESIGN` v3.1, `2_EXECUTION` v2.1, `3_OPERATIONS` v1.1, `5_BROWNFIELD` v1.0  
**Differenza col Meta-Governance**: `0_META` governa **il contenuto** del manuale (chi lo modifica, quando). Questo documento governa **come** un agente AI lo **legge e lo usa** in una sessione di lavoro reale.

---

## 📋 PERCHÉ SERVE UN LIVELLO DI PROMPTING SEPARATO

Un framework scritto per un umano non è automaticamente utilizzabile da un agente AI. Un agente ha bisogno di regole esplicite su: quando caricare quale documento, come classificare greenfield vs brownfield, come autoclassificare il task, come riportare cosa è stato applicato e cosa saltato.

---

## 📋 LE 5 REGOLE DI INVOCAZIONE

```
 A. TASK CLASSIFICATION GATE ──► Greenfield vs brownfield + tier task e adozione
 B. LOADING PROTOCOL         ──► Quale documento caricare e in che ordine
 C. DECLARATION OF INTENT    ──► L'agente dichiara prima di agire cosa applicherà
 D. EXECUTION TRACE FORMAT   ──► Report standard post-esecuzione
 E. ESCALATION TRIGGERS      ──► Stop e richiesta conferma umana
```

---

### A. 🚦 TASK CLASSIFICATION GATE

**Passo -1 — Discovery** (idea non ancora un piano tecnico):

| Segnale | Azione |
|---------|--------|
| Obiettivo vago · "facciamo X" senza metriche | [DISCOVERY_CHECKLIST.md](./DISCOVERY_CHECKLIST.md) · **zero codice** |
| GO greenfield | → `1_DESIGN` |
| GO brownfield | → `5_BROWNFIELD` ASSESSMENT |
| NO-GO / PIVOT | stop o nuova discovery |

**Passo 0 — Tipo progetto** (prima di tutto):

| `CODEBASE` | Criteri | Azione |
|------------|---------|--------|
| **GREENFIELD** | Nuovo progetto o modulo isolato senza legacy | Non caricare `5_BROWNFIELD` |
| **BROWNFIELD** | Codice esistente, prod legacy, refactor su monolite, polyglot | Carica `5_BROWNFIELD` · se prima volta → tier adozione **ASSESSMENT** |

**Passo 1 — Tier adozione** (solo BROWNFIELD):

- [ ] **ASSESSMENT** — prima applicazione manuale · solo `5_BROWNFIELD` Area A (+ E se in prod) · **zero merge**
- [ ] **INCREMENTAL** — baseline fatta · area B/C/D/E + tier sotto per ogni change
- [ ] **FULL** — redesign legacy · `5_BROWNFIELD` A + ciclo completo Design/Execution/Operations

**Passo 2 — Tier singolo task** (greenfield e brownfield):

- [ ] **LIGHT** (< 2h, no security/denaro/dati prod) → `2_EXECUTION` Fase B + D
- [ ] **STANDARD** (> 2h o modulo persistente) → `1_DESIGN` Pilastri 1–2 + `2_EXECUTION` completo
- [ ] **CRITICO** (security, denaro, prod, infra condivisa) → `1_DESIGN` (9) + `2_EXECUTION` + `3_OPERATIONS` B + C

**Passo 3 — Area brownfield** (se BROWNFIELD + problema noto):

| Problema | Area `5_BROWNFIELD` |
|----------|---------------------|
| Prima volta / inventario | A |
| Lentezza / bottleneck | B |
| Gap backend–frontend | C |
| Rewrite altro linguaggio | D |
| Prod senza ops | E |

- [ ] Se incerto: **dichiarare e chiedere conferma** · non assumere tier più leggero

**Re-classify mid-task**: se scopri codebase legacy, produzione o rewrite cross-language → fermati, ridichiara (Sezione C).

---

### B. 📂 LOADING PROTOCOL

- [ ] **DISCOVERY** (idea vaga) → solo [DISCOVERY_CHECKLIST.md](./DISCOVERY_CHECKLIST.md)
- [ ] **GREENFIELD** + LIGHT → `2_EXECUTION` B + D
- [ ] **GREENFIELD** + STANDARD → `1_DESIGN` 1–2 + `2_EXECUTION`
- [ ] **GREENFIELD** + CRITICO → `1_DESIGN` + `2_EXECUTION` + `3_OPERATIONS` B + C + [DEFINITION_OF_DONE.md](./DEFINITION_OF_DONE.md) + [security/THREAT_MODEL_TEMPLATE.md](./security/THREAT_MODEL_TEMPLATE.md)
- [ ] **BROWNFIELD** + ASSESSMENT → `5_BROWNFIELD` Area A (+ E se prod) · **non** altri framework salvo lettura
- [ ] **BROWNFIELD** + INCREMENTAL → `5_BROWNFIELD` area pertinente (B/C/D/E) + tier task frameworks
- [ ] **BROWNFIELD** + FULL → `5_BROWNFIELD` A + `1_DESIGN` + `2_EXECUTION` + `3_OPERATIONS` B + C
- [ ] `3_OPERATIONS` Area A → solo incidente attivo
- [ ] `0_META` → solo modifica manuale o verifica governance
- [ ] Non citare sezioni non caricate

**Mapping alias → file**:

| Alias | File |
|-------|------|
| `0_META` | `0_META_FRAMEWORK.md` |
| `1_DESIGN` | `1_DESIGN_FRAMEWORK.md` |
| `2_EXECUTION` | `2_EXECUTION_FRAMEWORK.md` |
| `3_OPERATIONS` | `3_OPERATIONS_FRAMEWORK.md` |
| `4_AI_AGENT` | `4_AI_AGENT_FRAMEWORK.md` |
| `5_BROWNFIELD` | `5_BROWNFIELD_FRAMEWORK.md` |

---

### C. 📣 DECLARATION OF INTENT (prima di agire)

**Formato minimo obbligatorio**:
```
Codebase: [GREENFIELD/BROWNFIELD]
Tier adozione (se brownfield): [ASSESSMENT/INCREMENTAL/FULL/N/A]
Classificazione task: [LIGHT/STANDARD/CRITICO/ASSESSMENT-only]
Framework applicati: [elenco pilastri/fasi/aree]
Framework NON applicati e perché: [elenco + motivazione]
Rischi non mitigati: [elenco, anche vuoto]
```

**Regola**: rischi non vuoti su CRITICO → stop (Sezione E).

---

### D. 📊 EXECUTION TRACE FORMAT (dopo l'esecuzione)

```
Task: [descrizione]
Codebase: [GREENFIELD/BROWNFIELD]
Classificazione: [tier]
Test eseguiti: [pass/fail]
Checklist saltate: [lista + motivo]
Debito tecnico: [TECHNICAL_DEBT_LEDGER.md | nessuno]
Idempotency: [4/6 | N/A]
Brownfield area: [A/B/C/D/E | N/A]
DoD verificata: [sì/no — DEFINITION_OF_DONE.md]
Maturity (se richiesta): [0-5 | N/A]
```

**Esempio ASSESSMENT**:
```
Task: baseline monolite e-commerce | BROWNFIELD | ASSESSMENT | Test: n/a | Area A completata | Debito: seed 3 voci | Idempotency: N/A
```

**Esempio bottleneck**:
```
Task: ottimizzare query ordini | BROWNFIELD/INCREMENTAL | STANDARD | Profiling p95 -40% | Area B | Skip: rewrite (fix SQL) | Debito: nessuno
```

---

### E. 🛑 ESCALATION TRIGGERS

- [ ] Credenziali, API key, movimento denaro reale
- [ ] Bypass Circuit Breaker (`1_DESIGN` Pilastro 7)
- [ ] Conflitto istruzione vs ADR esistente
- [ ] Modifica framework senza approvazione (`0_META` B)
- [ ] Re-classify mid-task verso CRITICO
- [ ] CRITICO con idempotency < 4/6 senza debito approvato
- [ ] **Rewrite linguaggio / strangler** senza ADR (`5_BROWNFIELD` D + Pilastro 2)
- [ ] **Breaking change API** backend–frontend senza contract test (`5_BROWNFIELD` C)
- [ ] **CRITICO** senza [threat model](./security/THREAT_MODEL_TEMPLATE.md) approvato
- [ ] **CRITICO** su prod senza [DR_BACKUP_PLAN.md](./DR_BACKUP_PLAN.md) (RTO/RPO)
- [ ] **ASSESSMENT** con merge codice proposto → stop · baseline prima
- [ ] Task chiuso senza verifica [DEFINITION_OF_DONE.md](./DEFINITION_OF_DONE.md) per tier

---

## ⚡ ESEMPIO DI PROMPT DI SISTEMA

```
Idea vaga → DISCOVERY_CHECKLIST.md prima di codice.
Determina GREENFIELD vs BROWNFIELD. Verifica DEFINITION_OF_DONE per tier.
Su BROWNFIELD senza baseline: ASSESSMENT, solo 5_BROWNFIELD Area A, zero merge.
CRITICO: threat model + DR plan su prod.
Dichiara intent PRIMA di codice. Trace + DoD a fine task. Stop su escalation.
File: 0_META, 1_DESIGN, 2_EXECUTION, 3_OPERATIONS, 4_AI_AGENT, 5_BROWNFIELD (_FRAMEWORK.md).
Artefatti: DISCOVERY_CHECKLIST, DEFINITION_OF_DONE, DR_BACKUP_PLAN, FRAMEWORK_MATURITY, security/THREAT_MODEL_TEMPLATE.
```

---

## 📚 DATA PROVENANCE DELLE REGOLE

| Regola | Fonte primaria | Riferimenti / pattern | Validazione |
|--------|----------------|----------------------|-------------|
| **A Classification** | Risk + context routing | FAIR; brownfield vs greenfield (ThoughtWorks) | README + `0_META` |
| **B Loading** | Context optimization | RAG chunking; load on demand | Mapping 6 file |
| **C Declaration** | HITL AI | Pre-flight checklists | CRITICO stop |
| **D Trace** | Observability | Structured logging | Trace obbligatorio |
| **E Escalation** | Safety guardrails | OWASP LLM; rewrite/API triggers | ADR + contract test |

---

## 📌 Relazione con gli Altri Documenti

Traduce `0_META`, `1_DESIGN`, `2_EXECUTION`, `3_OPERATIONS`, **`5_BROWNFIELD`** in protocollo eseguibile per agenti AI — inclusi progetti già in sviluppo o finiti.
