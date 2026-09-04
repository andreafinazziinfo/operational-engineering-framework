# ⚙️ EXECUTION & DELIVERY FRAMEWORK
## Dal Piano Approvato al Rilascio Testato in Produzione

**Documento**: Guida operativa per esecuzione, testing e rilascio di qualsiasi piano tecnico  
**Alias canonico**: `2_EXECUTION`  
**File**: `2_EXECUTION_FRAMEWORK.md`  
**Prerequisito**: Il piano ha superato `1_DESIGN` o `5_BROWNFIELD` Area A (brownfield) — tier in `0_META` / `4_AI_AGENT`
**Versione**: 2.3  
**Ultima modifica**: 2026-09-04  
**Compatibile con**: `1_DESIGN` v3.4, `3_OPERATIONS` v1.1, `0_META` v1.7, `4_AI_AGENT` v1.7, `5_BROWNFIELD` v1.1, `7_COLLABORATION` v1.3  

---

## 📋 LE 6 FASI DI ESECUZIONE

```
 A. TASK BREAKDOWN      ──► Scomposizione del piano in unità di lavoro atomiche e sequenziabili
 B. TEST STRATEGY       ──► Definizione di unit/integration/e2e test PRIMA del codice
 C. IMPLEMENTATION LOOP ──► Ciclo scrivi→testa→verifica con checkpoint continui
 D. REVIEW GATE         ──► Code review, static analysis, security scan prima del merge
 E. RELEASE & ROLLBACK  ──► Deploy controllato con piano di rollback testato
 F. POST-MORTEM REALE   ──► Confronto tra pre-mortem previsto e cosa è successo davvero
```

**Tier LIGHT** (`0_META`): per task < 2h non critici, applicare **solo Fase B + D**.  
**Definition of Done**: [DEFINITION_OF_DONE.md](./DEFINITION_OF_DONE.md) per ogni tier.

---

### A. 🧩 TASK BREAKDOWN
- **Obiettivo**: Trasformare il piano in task eseguibili in max 1-2 ore ciascuno, con dipendenze esplicite.
- **Template**: [SPEC_TEMPLATE.md](./SPEC_TEMPLATE.md) — artefatto copiabile per formalizzare ogni unità di lavoro, opzionale su LIGHT ovvio, consigliato su STANDARD/CRITICO o quando il contesto rischia di perdersi tra sessioni (`7_COLLABORATION` Area A)
- **Checklist**:
  - [ ] Ogni task ha un output verificabile (file, test che passa, endpoint funzionante)?
  - [ ] Le dipendenze tra task sono esplicite?
  - [ ] I task più incerti/rischiosi vengono eseguiti prima?
  - [ ] Soglia quantitativa: **≥ 90%** dei task rispettano il limite **≤ 2 ore** (i restanti giustificati per iscritto)?

---

### B. 🧪 TEST STRATEGY (prima del codice)
- **Obiettivo**: Nessun task si considera iniziato senza sapere già come verrà validato.
- **Checklist**:
  - [ ] Unit test: quali funzioni pure vanno testate in isolamento (edge case, null, valori limite)?
  - [ ] Integration test: quali interazioni tra moduli/servizi vanno testate con mock o sandbox?
  - [ ] Regression test: esiste una suite automatica eseguita prima di ogni merge?
  - [ ] È definito un target minimo di coverage sui moduli core? → **≥ 80% line coverage su moduli core** (o giustificazione scritta se inferiore)
  - [ ] Per moduli con retry/idempotency: test che verifica **2 invocazioni = 0 duplicati** (`1_DESIGN` Pilastro 5)?

---

### C. 🔁 IMPLEMENTATION LOOP
- **Obiettivo**: Ciclo breve e verificabile per ogni task, senza derive di scope.
- **Checklist**:
  - [ ] Scrivi test → scrivi codice minimo per farlo passare → refactor.
  - [ ] Ogni commit è atomico e riferisce un singolo task?
  - [ ] Checkpoint periodici: il pre-mortem è ancora valido? I test passano tutti?
  - [ ] Se un task richiede più del doppio del tempo stimato, si riscompone invece di forzare?
  - [ ] Soglia quantitativa: checkpoint ogni **≤ 2 ore** di lavoro continuo o a fine ogni task?

---

### D. 🔍 REVIEW GATE
- **Obiettivo**: Nessun merge senza un controllo indipendente, anche automatizzato.
- **Checklist**:
  - [ ] Static analysis senza errori bloccanti (linter/type-checker)?
  - [ ] Security scan sulle dipendenze eseguito?
  - [ ] Il diff è stato letto riga per riga da un secondo revisore (umano o AI)?
  - [ ] I test aggiunti coprono anche i casi limite, non solo il happy path?
  - [ ] Soglia quantitativa: diff **≤ 400 righe** per PR (oltre → split obbligatorio salvo giustificazione)?

---

### E. 🚀 RELEASE & ROLLBACK
- **Obiettivo**: Ogni rilascio deve poter essere annullato più rapidamente di quanto serva per accorgersi del problema.
- **Checklist**:
  - [ ] Esiste uno script di rollback testato (non solo teorico)?
  - [ ] Il rilascio è graduale (staging/canary → produzione) o big-bang?
  - [ ] I Circuit Breaker (`1_DESIGN` Pilastro 7) sono attivi PRIMA del deploy?
  - [ ] Finestra minima di osservazione post-deploy:
    - Canary: **≥ 30 minuti** con metriche stabili (error rate **< 1%**)
    - Rollout completo: **≥ 24 ore** prima di dichiarare stabilità (o SLO verificati)
  - [ ] Soglia quantitativa: rollback eseguibile in **≤ 30 minuti** dal decision point?

---

### F. 🪞 POST-MORTEM REALE
- **Obiettivo**: Confrontare le ipotesi del Pre-Mortem (`1_DESIGN` Pilastro 1) con quanto accaduto realmente.
- **Template**: [POST_MORTEM_TEMPLATE.md](./POST_MORTEM_TEMPLATE.md) — artefatto copiabile, entro 48h da P1/P2
- **Checklist**:
  - [ ] Quali rischi previsti si sono materializzati? Quali non erano previsti?
  - [ ] L'ADR originale (`1_DESIGN` Pilastro 2) va aggiornato con una nota "esito reale"?
  - [ ] C'è un miglioramento da riportare nei framework stessi? → aggiornare via `0_META` + `CHANGELOG.md`
  - [ ] Compromessi presi sotto pressione vanno registrati in [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md)?
  - [ ] Soglia quantitativa: Post-Mortem entro **48 ore** da incidente P1/P2 o release fallita?

---

## 📚 DATA PROVENANCE DELLE FASI (origine del manuale)

| Fase | Fonte primaria | Riferimenti / pattern | Validazione nel manuale |
|------|----------------|----------------------|-------------------------|
| **A Task Breakdown** | Agile / Kanban | INVEST criteria; Shape Up scopes; 1–2h task limit (personal kanban) | Tier LIGHT riduce scope |
| **B Test Strategy** | TDD / quality gates | Test Pyramid (Cohn); coverage targets industry | Collegamento Pilastro 5 idempotency |
| **C Implementation Loop** | TDD + lean | Red-Green-Refactor; Pomodoro/checkpoint | Regola 2× tempo stimato |
| **D Review Gate** | Code review culture | Google eng practices; PR size studies | Trace AI in `4_AI_AGENT` |
| **E Release & Rollback** | SRE / continuous delivery | DORA metrics; canary/blue-green (Fowler) | Pilastro 7 + runbook post-deploy |
| **F Post-Mortem Reale** | SRE blameless postmortem | Google SRE Ch. 15; closed loop con ADR | `0_META` circuit breaker manuale |

**Revisione provenance**: self-audit trimestrale (`0_META` Area C).
