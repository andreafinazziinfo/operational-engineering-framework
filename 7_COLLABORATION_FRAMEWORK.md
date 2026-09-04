# 🤝 HUMAN-AI COLLABORATION & SESSION HYGIENE FRAMEWORK
## Come Owner e Agenti AI Lavorano Insieme nel Tempo: Sessioni, Delega, Verifica, Attrito

**Documento**: Layer trasversale — igiene di collaborazione owner↔agente AI attraverso sessioni multiple e concorrenti (Claude Code, Cursor, Antigravity, ecc.)
**Alias canonico**: `7_COLLABORATION`
**File**: `7_COLLABORATION_FRAMEWORK.md`
**Prerequisito**: Esistono `0_META`, `4_AI_AGENT` (vedi [README.md](./README.md)) — questo documento governa la relazione **nel tempo**, non sostituisce il protocollo per-task
**Versione**: 1.3
**Ultima modifica**: 2026-09-04
**Compatibile con**: `0_META` v1.7, `1_DESIGN` v3.4, `2_EXECUTION` v2.3, `3_OPERATIONS` v1.1, `4_AI_AGENT` v1.7, `5_BROWNFIELD` v1.1, `6_STRATEGY` v1.0
**Decisione architetturale**: [ADR-003.md](./ADR-003.md)

---

## 📋 PERCHÉ SERVE QUESTO LIVELLO

Gli altri sei framework operativi coprono **cosa costruire e come farlo bene** (design, delivery, ops, brownfield, strategy) e **come un agente applica quel ciclo a un task** (`4_AI_AGENT`). Nessuno risponde a domande che vivono a una cadenza diversa — non per task, ma per **sessione**:

- Cos'è "una sessione"? Quando ne apro una seconda invece di continuare quella attiva?
- Cosa succede alla working tree quando due sessioni (stesso agente o agenti diversi) lavorano in parallelo?
- Quando ha senso delegare a un sub-agent, e come verifico che il risultato sia affidabile?
- Un claim — mio o di un'altra sessione AI — è verificato o solo dichiarato?
- Come evito di re-imparare lo stesso attrito di tooling/permessi ogni volta?

Questo è un gap ricorrente, non ipotetico: perdita di file non tracciati tra sessioni concorrenti, ore di babysitting manuale su infra condivisa instabile, claim non verificati che arrivano a un merge, lo stesso attrito di ambiente scoperto a metà lavoro invece che all'inizio.

---

## 📋 LE 5 AREE DI IGIENE COLLABORATIVA

```
 A. SESSION IDENTITY & HANDOVER      ──► Cos'è "una sessione", quando aprirne una nuova, come si passa il testimone
 B. SHARED WORKING-TREE & INFRA      ──► Sessioni/worktree concorrenti, infra condivisa, perdita di stato
 C. DELEGATION & SUB-AGENT DISCIPLINE──► Quando delegare, a chi, con quale verifica del risultato
 D. VERIFICATION & TRUST BOUNDARY    ──► Claim propri e di altre sessioni/agenti AI: cosa si verifica prima di fidarsi
 E. TOOL & PERMISSION FRICTION       ──► Privilegi minimi, gotcha ricorrenti, registro vivo
```

**Severità default**: Aree B, D = **Bloccante** | Aree A, C = **Alta** | Area E = **Media**

**Cadenza di caricamento**: questo documento si carica **a inizio sessione**, una volta — non per ogni task come `4_AI_AGENT` (vedi [Relazione con 4_AI_AGENT](#-relazione-con-4_ai_agent) sotto).

---

### A. 🔄 SESSION IDENTITY & HANDOVER
- **Severità default**: Alta
- **Obiettivo**: Sapere sempre cos'è "una sessione" attiva, evitare lavoro duplicato o perso quando si passa il testimone — stesso agente, agente diverso, o umano che riprende in mano.
- **Checklist**:
  - [ ] Prima di aprire una nuova sessione su una working tree già in uso, è chiaro se sta **sostituendo** o **affiancando** quella attiva?
  - [ ] Ogni sessione dichiara all'inizio: cosa sta per toccare (path/moduli) e la durata stimata?
  - [ ] Al termine (o all'esaurimento del contesto) esiste un documento di handover leggibile da chiunque riprenda?
  - [ ] L'handover include: stato attuale, decisioni prese, cosa **non** è stato verificato, prossimo passo esplicito?
  - [ ] Se due sessioni sono concorrenti per scelta (non per errore), il confine tra loro (path/moduli non sovrapposti) è dichiarato esplicitamente?
  - [ ] Soglia quantitativa: **100%** delle sessioni che superano una soglia di durata concordata, o che cambiano agente/tool, producono un handover scritto prima di chiudere?
  - [ ] Soglia quantitativa: **0** sessioni "orfane" (aperte, mai chiuse né passate a testimone) rilevate a fine settimana?

---

### B. 🌳 SHARED WORKING-TREE & INFRA HYGIENE
- **Severità default**: Bloccante
- **Obiettivo**: La working tree e l'infra condivisa (runner CI, container, cache) non devono perdere stato né collidere tra sessioni o progetti concorrenti.
- **Checklist**:
  - [ ] `git status` (stato reale, non memoria) è obbligatorio prima di ogni operazione potenzialmente distruttiva, per ogni sessione — umano o AI?
  - [ ] **Comandi che scartano modifiche non committate** (`git checkout --`, `git restore`, `git reset --hard`, `git clean`) vengono eseguiti solo dopo aver verificato che il target non ha modifiche non salvate — mai per assunzione, mai dentro una catena `comando1 || comando2` dove il fallback non è verificato?
  - [ ] Quando è incerto se un file abbia modifiche preziose, si preferisce `git stash` (reversibile) a `git checkout --`/`git reset --hard` (distruttivo)?
  - [ ] Lavoro non committato che si accumula per ore su più file (rischio reale, non ipotetico — vedi checkpoint sotto) ha un punto di salvataggio (commit, anche intermedio) prima di procedere con altri comandi git rischiosi?
  - [ ] I worktree temporanei vengono rimossi esplicitamente a fine uso (`git worktree remove`), non lasciati a marcire?
  - [ ] Se più progetti condividono lo stesso runner/infra, le risorse condivise (porte, nomi container, path cache) sono isolate per job/progetto?
  - [ ] Runner instabile o rete non affidabile: esiste un timeout + retry esplicito, invece di babysitting manuale indefinito?
  - [ ] File non tracciati generati da una sessione sono protetti da un rischio noto di essere sovrascritti/rimossi da un'altra sessione concorrente?
  - [ ] Soglia quantitativa: **0** episodi di perdita file non tracciati per collisione tra sessioni concorrenti in **30 giorni**?
  - [ ] Soglia quantitativa: babysitting manuale di un job instabile **≤ 2 tentativi** prima di escalation o fix strutturale (non ore di attesa passiva)?
  - [ ] Soglia quantitativa: **100%** dei worktree temporanei rimossi entro fine sessione (0 worktree orfani a fine settimana)?
  - [ ] Soglia quantitativa: **0** comandi `git checkout --`/`reset --hard`/`clean` eseguiti su un file senza aver controllato `git status` nell'immediato prima?

---

### C. 🧩 DELEGATION & SUB-AGENT DISCIPLINE
- **Severità default**: Alta
- **Obiettivo**: Delegare a un sub-agent (o a un altro tool AI) solo quando il costo di farlo è inferiore al costo di farlo da soli, e sempre con un modo di verificare il risultato.
- **Checklist**:
  - [ ] La delega avviene solo quando il task è ben delimitato (scope chiaro, criterio di successo verificabile) o serve isolare output rumoroso dal contesto principale?
  - [ ] Ogni delega dichiara: cosa deve fare il sub-agent, cosa **non** deve toccare, come verrà verificato il risultato?
  - [ ] L'output di un sub-agent è trattato come bozza da verificare, non come fatto acquisito, prima di essere incorporato?
  - [ ] Task ambigui o che richiedono giudizio del principale **non** vengono delegati solo per liberare contesto, quando farlo perderebbe comprensione necessaria?
  - [ ] **Circle of competence**: chi delega sa davvero valutare se l'output del sub-agent è corretto, o sta delegando anche il giudizio finale? Se non sa valutarlo, la delega richiede un criterio di verifica esterno (test, secondo agente, revisione umana) prima di essere accettata?
  - [ ] Soglia quantitativa: **100%** delle deleghe con un criterio di verifica dichiarato **prima** di lanciare il sub-agent?
  - [ ] Soglia quantitativa: **0** output di sub-agent incorporati senza almeno una verifica indipendente (lettura diff, test, cross-check) su tier STANDARD/CRITICO?

---

### D. 🔍 VERIFICATION & TRUST BOUNDARY
- **Severità default**: Bloccante
- **Obiettivo**: Nessun claim — proprio o di un'altra sessione/agente AI — entra come "fatto" senza essere verificabile.
- **Checklist**:
  - [ ] Ogni claim di stato ("il CI è verde", "il test passa", "il modulo X è migrato") è verificato con un comando/log riproducibile, non solo dichiarato?
  - [ ] I contributi di un'altra sessione o di un altro strumento AI sulla stessa working tree passano da una verifica esplicita (diff letto, provenienza tracciata) prima di essere considerati definitivi?
  - [ ] Esiste un gate esplicito per **dati fabbricati** — numeri, percentuali, risultati di test inventati o non rieseguiti — prima che entrino in un documento o in un merge?
  - [ ] Quando due sessioni/agenti producono claim contrastanti sullo stesso stato, è la **verifica** — non l'anzianità del claim — a decidere?
  - [ ] **Goodhart's Law**: il lavoro è verificato contro l'obiettivo reale (il problema è risolto), non contro il proxy che lo misura (il test passa, la checklist è compilata, il CI è verde)? Un fix che soddisfa la lettera del test ma non l'intento viene trattato come non fatto?
  - [ ] **Recency/Currency Check**: claim su stato tecnologico, versione di libreria, o "best practice attuale" sono verificati con una ricerca live quando sono time-sensitive, non dichiarati per fiducia nella memoria del modello? Il cutoff di conoscenza di un agente AI non è mai la fonte primaria su cosa è vero *oggi*
  - [ ] Soglia quantitativa: **100%** dei claim quantitativi (percentuali, conteggi, esiti test) citati in documenti o handover hanno un comando/log di origine verificabile?
  - [ ] Soglia quantitativa: **0** merge di contributi di un'altra sessione/agente AI su tier STANDARD/CRITICO senza almeno una verifica indipendente?

**Collegamento**: estende il Pilastro 4 (Data Lineage & Provenance) di `1_DESIGN` dal dato applicativo al **contributo AI stesso** — stessa logica, oggetto diverso.

---

### E. 🔧 TOOL & PERMISSION FRICTION
- **Severità default**: Media
- **Obiettivo**: Rendere visibile l'attrito ricorrente di tooling/permessi invece di re-impararlo ogni sessione.
- **Checklist**:
  - [ ] L'agente AI opera a **minimo privilegio** (no permessi elevati) per design, non per limite tecnico accidentale?
  - [ ] Le incompatibilità di ambiente/CLI vengono rilevate con un check esplicito a inizio sessione, non scoperte a metà di un processo lungo?
  - [ ] Gli attriti ricorrenti (comando che fallisce sempre allo stesso modo, step manuale dimenticato) sono registrati invece di essere ririsolti a memoria ogni volta?
  - [ ] Esiste un posto solo — non sparso in sessioni passate — dove cercare "questo problema l'ho già visto"? → [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) categoria **Collaborazione/Tooling**
  - [ ] Soglia quantitativa: attrito ricorrente osservato **≥ 2 volte** → riga nel ledger entro la sessione in cui si ripresenta?
  - [ ] Soglia quantitativa: check di compatibilità ambiente/CLI eseguito entro i primi **5 minuti** di sessione su task che dipendono da tool esterni non standard?

---

## 🔗 RELAZIONE CON `4_AI_AGENT`

**Differenza**: `4_AI_AGENT` governa come **un** agente applica il manuale a **un task** (classificazione, loading, declaration, trace, escalation) — cadenza **per task**. Questo documento governa come owner e agente(i) lavorano insieme **nel tempo**, attraverso sessioni multiple e potenzialmente concorrenti — cadenza **per sessione**.

**In pratica**:
- `7_COLLABORATION` si carica **una volta, a inizio sessione**.
- `4_AI_AGENT` si carica **per ogni task** dentro quella sessione (Sezione B, Loading Protocol).
- Un trigger di escalation di `4_AI_AGENT` §E (es. credenziali, bypass circuit breaker) resta **task-level** — si ferma quel task.
- Un trigger di circuit breaker di questo documento (sotto) è **sessione-level** — si ferma la sessione/collaborazione, non solo il task in corso.
- Nessuna sovrapposizione di contenuto: se un trigger sembra appartenere a entrambi, resta in `4_AI_AGENT` §E (specifico) — questo documento copre solo ciò che è **specifico alla relazione nel tempo** (Aree A–E sopra).

---

## 🛑 CIRCUIT BREAKER DELLA COLLABORAZIONE

Segnale esplicito che l'igiene di collaborazione **si è rotta**, distinto dal circuit breaker del manuale (`0_META`) e da quello di un singolo task (`4_AI_AGENT` §E):

1. **≥ 2** episodi di perdita file/lavoro per collisione di working tree in **30 giorni**
2. **≥ 1** episodio di dato fabbricato o non verificato arrivato a merge su tier STANDARD/CRITICO
3. Babysitting manuale di infra condivisa ripetuto **> 2 volte** senza una riga di debito/fix strutturale nel ledger
4. **≥ 3** sessioni "orfane" (senza handover) nello stesso mese
5. Un'incompatibilità di ambiente/CLI causa **> 30 minuti** di lavoro a vuoto rilevati **dopo** il fatto, non da un check preventivo

**Azione**: fermare nuove sessioni parallele e nuove deleghe, eseguire audit con Area D (Verification & Trust Boundary), aggiornare [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md).

---

## 📚 DATA PROVENANCE DELLE AREE (origine del manuale)

| Area | Fonte primaria | Riferimenti / pattern | Validazione nel manuale |
|------|----------------|----------------------|-------------------------|
| **A Session Identity & Handover** | Pratica on-call/handoff | SRE on-call handover; pair/mob programming handoff | Checklist quantitativa sopra |
| **B Shared Working-Tree & Infra** | Git worktree + CI isolation practice | `git worktree` docs; runner/job resource scoping, ephemeral CI environments; defense in depth (backup/checkpoint come livello ridondante, non l'unico controllo) | Circuit breaker collaborazione · incidente reale 2026-09-04 (v1.3, vedi CHANGELOG) |
| **C Delegation & Sub-Agent Discipline** | Orchestrazione multi-agente | Pattern supervisor/worker; HITL delegation guidelines; circle of competence (mental model) | Soglie quantitative sopra |
| **D Verification & Trust Boundary** | HITL AI + provenance | Estensione del Pilastro 4 (`1_DESIGN`) al contributo AI stesso; Goodhart's Law + recency/staleness check (mental model, ricerca 2026 su knowledge cutoff) | Collegamento esplicito §D · check Goodhart e recency sopra |
| **E Tool & Permission Friction** | Least-privilege + gestione debito | NIST/OWASP least privilege; `TECHNICAL_DEBT_LEDGER.md` (Ward Cunningham) | Riuso ledger, categoria dedicata |

**Provenance del documento nel complesso**: sintesi di attrito operativo ricorrente osservato su sessioni AI-assisted concorrenti, generalizzato — nessun riferimento a progetti specifici (regola esplicita, coerente con Pilastro 8 `1_DESIGN`). Revisione provenance: ad ogni self-audit trimestrale (`0_META` Area C).

---

## 🔧 Note d'Uso

- Come per `1_DESIGN`, ogni checklist item ha **Severità** implicita dall'Area (Bloccante/Alta/Media) — vedi tabella severità sopra.
- Le Aree B e D sono **Bloccanti**: una sessione non dovrebbe procedere con lavoro STANDARD/CRITICO se una soglia bloccante di quelle aree è ignorata senza debito registrato.
- **Idempotency del documento**: applicare le stesse Aree alla stessa situazione (es. "due sessioni concorrenti sulla stessa working tree") deve produrre lo stesso comportamento ogni volta — le soglie quantitative sopra esistono per questo, non solo le checklist qualitative.

## 📌 Come Usare questo Documento

1. Carica questo documento **a inizio sessione**, non per singolo task.
2. Prima di aprire una seconda sessione concorrente sulla stessa working tree → applica Area A + B.
3. Prima di delegare a un sub-agent → applica Area C.
4. Prima di incorporare un output — tuo di una sessione precedente, o di un altro agente AI — → applica Area D.
5. Se incontri lo stesso attrito una seconda volta → applica Area E, registra nel ledger.
6. Per il singolo task **dentro** la sessione, passa a `4_AI_AGENT` (Loading Protocol Sezione B).
