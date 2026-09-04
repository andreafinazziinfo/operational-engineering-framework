# 🏗️ BROWNFIELD & MODERNIZATION FRAMEWORK
## Adozione del Manuale su Progetti Esistenti, Legacy e Full-Stack

**Documento**: Layer per codebase già in sviluppo, in produzione o eterogenei (polyglot, gap backend–frontend)  
**Alias canonico**: `5_BROWNFIELD`  
**File**: `5_BROWNFIELD_FRAMEWORK.md`  
**Prerequisito**: Conoscenza di `1_DESIGN`, `2_EXECUTION`, `3_OPERATIONS` · invocazione via `4_AI_AGENT`  
**Versione**: 1.1  
**Ultima modifica**: 2026-09-04  
**Compatibile con**: `0_META` v1.7, `1_DESIGN` v3.4, `2_EXECUTION` v2.3, `3_OPERATIONS` v1.1, `4_AI_AGENT` v1.7, `7_COLLABORATION` v1.3  

---

## 📋 QUANDO USARE QUESTO DOCUMENTO

| Situazione | Azione |
|------------|--------|
| Progetto **nuovo** (greenfield) | **Non** caricare questo file — usa `1_DESIGN` → `2_EXECUTION` |
| Progetto **già avviato** o **finito** senza manuale | **Sì** — inizia da Area A (Baseline) |
| Refactor per **collo di bottiglia** | Area B + tier STANDARD/CRITICO sui singoli interventi |
| **Rewrite** parziale in altro linguaggio | Area D + ADR obbligatorio (`1_DESIGN` Pilastro 2) |
| Gap **backend ↔ frontend** | Area C |
| Prod esistente **senza** monitoring/runbook | Area E (Legacy Fit) |

**Regola ingresso**: su codebase esistente, **Area A è obbligatoria** prima del primo merge di refactor, salvo tier **ASSESSMENT** (solo analisi).

---

## 📋 LE 5 AREE BROWNFIELD

```
 A. BASELINE & ONBOARDING      ──► Inventario e ingresso su codebase esistente
 B. BOTTLENECK & PERFORMANCE   ──► Profiling e decisione ottimizza vs riscrivi vs scala
 C. FULL-STACK & API BOUNDARY  ──► Confine backend–frontend, contratti, schema drift
 D. POLYGLOT & REWRITE PARZIALE ──► Migrazione modulo/language con strangler fig
 E. LEGACY FIT                 ──► Progetto finito ma immaturo operativamente
```

**Tier adozione sul progetto** (oltre a LIGHT/STANDARD/CRITICO per singoli task):

| Tier adozione | Criteri | Cosa fare |
|---------------|---------|-----------|
| **ASSESSMENT** | Prima applicazione manuale su codebase esistente | Solo Area A (+ E se già in prod) · **zero merge codice** |
| **INCREMENTAL** | Baseline completata, change per modulo | Area pertinente (B/C/D) + tier task su ogni intervento |
| **FULL** | Redesign architetturale del sistema legacy | Area A + `1_DESIGN` completo + `2_EXECUTION` + `3_OPERATIONS` B/C |

---

### A. 📋 BASELINE & ONBOARDING
- **Obiettivo**: Fotografare lo stato reale prima di cambiare qualsiasi cosa.
- **Checklist**:
  - [ ] Inventario stack: linguaggi, moduli, dipendenze critiche, ambienti (dev/staging/prod)
  - [ ] Mappa confini: frontend ↔ API/BFF ↔ backend ↔ DB ↔ servizi terzi
  - [ ] Seed [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) da TODO strutturali, gap noti, code smell documentati
  - [ ] ADR retroattive (minimo **100%** dipendenze critiche / SPOF potenziali — `1_DESIGN` Pilastro 2)
  - [ ] Tier adozione dichiarato: ASSESSMENT | INCREMENTAL | FULL
  - [ ] Soglia quantitativa: baseline scritta con **≥ 3** rischi P1/P2 identificati e owner

**Template mappa confini**:

```markdown
## Mappa confini — [Progetto]
| Confine | Tecnologia A | Tecnologia B | Contratto | Test esistenti |
|---------|--------------|--------------|-----------|----------------|
| UI → API | [React/Vue/…] | [REST/GraphQL/…] | [OpenAPI/schema] | [sì/no] |
| API → DB | [Node/Go/…] | [Postgres/…] | [ORM/migrations] | [sì/no] |
```

**Exit criteria Area A**: baseline approvata dall'owner · tier adozione scelto · ledger seedato.

---

### B. ⚡ BOTTLENECK & PERFORMANCE
- **Obiettivo**: Evitare rewrite o cambio linguaggio basati solo su intuizione.
- **Checklist qualitativa**:
  - [ ] Profiling/metriche **prima** del change (CPU, I/O, query lente, latenza p95/p99, memoria)
  - [ ] Collo di bottiglia classificato: **algoritmo | I/O | rete | DB | concurrency | infra**
  - [ ] Performance budget definito (es. p95 < X ms, throughput > Y req/s)
  - [ ] Re-test con **stesso benchmark** dopo il change · delta documentato
- **Matrice decisione** (ADR obbligatorio se si esce dalla prima riga):

| Segnale | Azione preferita |
|---------|------------------|
| Hot path < 5% codebase, fix localizzato | Ottimizza **stesso linguaggio** |
| Libreria/ecosystem limite strutturale | Rewrite **modulo isolato** (Area D) |
| Costo ops >> costo rewrite + test | Rewrite + Pilastro 5 idempotency |
| Bottleneck è indice DB / config / scaling | Scala/config · **non** rewrite |
| Frontend bundle / render blocking | Ottimizza frontend · non rewrite backend |

- **Checklist quantitativa**:
  - [ ] Profiling eseguito su carico **≥ 10×** medio o picco documentato
  - [ ] Miglioramento atteso **≥ 20%** sulla metrica target · altrimenti stop e rivaluta
  - [ ] Se rewrite: blast radius **≤ 1** dominio funzionale (`1_DESIGN` Pilastro 3)

---

### C. 🔗 FULL-STACK & API BOUNDARY
- **Obiettivo**: Chiudere gap backend–frontend con confini espliciti e testabili.
- **Checklist**:
  - [ ] Contratto API versionato (OpenAPI, GraphQL schema, protobuf, AsyncAPI)
  - [ ] Check **schema drift**: backend vs client vs mock · CI fallisce su drift non approvato
  - [ ] Test al confine:
    - contract test (consumer-driven se possibile)
    - integration backend ↔ frontend (o BFF)
    - e2e su **≥ 3** flussi critici cross-stack
  - [ ] Decisione BFF vs API diretta documentata (ADR se cambia confine)
  - [ ] Error model condiviso (codici, body, retry idempotenti — `1_DESIGN` Pilastro 5)
  - [ ] Auth/session/CORS documentati se SPA, mobile o multi-client
- **Checklist quantitativa**:
  - [ ] **100%** endpoint usati dal frontend hanno contratto versionato
  - [ ] **0** breaking change non comunicati tra release backend e client nello stesso sprint
  - [ ] Contract test in CI con esito **pass** prima di merge su moduli condivisi

---

### D. 🔄 POLYGLOT & REWRITE PARZIALE
- **Obiettivo**: Cambiare linguaggio o stack solo su moduli delimitati, senza big-bang.
- **Checklist**:
  - [ ] Rewrite limitato a **modulo con interfaccia stabile** verso il resto (API, queue, file format)
  - [ ] ADR con alternative (ottimizza vs rewrite vs buy) · `1_DESIGN` Pilastro 2 **Bloccante**
  - [ ] **Sunk cost check**: ripartendo da zero oggi, con quello che si sa ora, si sceglierebbe ancora il rewrite? Se la risposta è "no, ma abbiamo già investito X" → fermarsi e ridiscutere l'ADR
  - [ ] Piano **strangler fig**: % traffico 10% → 50% → 100% con rollback per fase
  - [ ] Idempotency su dual-write / dual-read durante migrazione (`1_DESIGN` Pilastro 5)
  - [ ] Rollback per modulo testato · non dipendere da "non si torna indietro"
  - [ ] Sunset modulo legacy con preavviso (`3_OPERATIONS` Area E)
- **Checklist quantitativa**:
  - [ ] Ogni fase strangler osservata **≥ 24h** con metriche stabili prima della fase successiva
  - [ ] **0** regressioni su flussi e2e critici durante migrazione parziale
  - [ ] Modulo legacy spento solo dopo **≥ 7 giorni** a 0% traffico in canary/shadow

---

### E. 🏚️ LEGACY FIT (progetto finito, ops immature)
- **Obiettivo**: Portare operatività minima su prod esistente senza redesign completo.
- **Checklist** (priorità decrescente):
  - [ ] Monitoring/SLO presenti? → altrimenti `3_OPERATIONS` Area B **prima** di nuove feature
  - [ ] Runbook top 3–5 incidenti? → [runbooks/](./runbooks/README.md)
  - [ ] Secrets fuori repo e rotazione pianificata? → `1_DESIGN` Pilastro 8
  - [ ] Ultimo incidente grave ha post-mortem? → `2_EXECUTION` Fase F
  - [ ] Ogni modifica persistente usa tier **≥ STANDARD** (non LIGHT su moduli core)
- **Soglia quantitativa**: completare **≥ 4/5** voci sopra prima di classificare il progetto "framework-ready".

---

## 📚 DATA PROVENANCE DELLE AREE (origine del manuale)

| Area | Fonte primaria | Riferimenti / pattern | Validazione nel manuale |
|------|----------------|----------------------|-------------------------|
| **A Baseline** | Legacy modernization | ThoughtWorks Strangler Fig; AWS Migration Evaluator; archeology sprint | Tier ASSESSMENT in `0_META` |
| **B Bottleneck** | Performance engineering | Google SRE performance; USE/RED methods; "measure don't guess" | Matrice decisione + ADR |
| **C API Boundary** | Contract-first integration | OpenAPI/Consumer-Driven Contracts (Pact); BFF (Sam Newman) | Contract test in `2_EXECUTION` B |
| **D Polyglot Rewrite** | Incremental migration | Strangler Fig Application; Branch by Abstraction; sunk cost fallacy (mental model) | Pilastri 3, 5 + Area E sunset · sunk cost check sopra |
| **E Legacy Fit** | Operate-first on brownfield | DORA on legacy; "stabilize before accelerate" | Runbook + SLO before features |

**Revisione provenance**: self-audit trimestrale (`0_META` Area C).

---

## 🔗 COLLEGAMENTO CON GLI ALTRI FRAMEWORK

```
Codebase ESISTENTE:
  5_BROWNFIELD Area A (baseline)
       │
       ├── Area B/C/D/E secondo il problema
       │
       └── Ogni intervento concreto → tier LIGHT / STANDARD / CRITICO
            → 1_DESIGN (pilastri pertinenti) → 2_EXECUTION → 3_OPERATIONS (se prod)
```

| Problema brownfield | Area | Poi applica |
|---------------------|------|-------------|
| Non so da dove iniziare | A | ASSESSMENT tier |
| Lento in prod | B | STANDARD/CRITICO + Pilastri 6, 9 |
| Frontend e backend disallineati | C | STANDARD + contract test |
| Rewrite Go/Rust/TS di un modulo | D | CRITICO + Pilastri 2, 3, 5 |
| Prod senza monitoring | E | `3_OPERATIONS` B + runbooks |

---

## 📌 Come Usare questo Documento

1. Conferma che il progetto **non è greenfield** → carica questo file.
2. Se l'obiettivo è ancora vago → [DISCOVERY_CHECKLIST.md](./DISCOVERY_CHECKLIST.md) prima di Area A.
3. Completa **Area A** (baseline) · tier adozione ASSESSMENT se è la prima volta.
4. Apri **Area B/C/D/E** solo se pertinenti al task corrente.
5. Per ogni change concreto, applica tier LIGHT/STANDARD/CRITICO (`0_META` / `4_AI_AGENT`).
6. Chiudi con [DEFINITION_OF_DONE.md](./DEFINITION_OF_DONE.md) · aggiorna [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) e ADR.
7. Review [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) trimestrale.
