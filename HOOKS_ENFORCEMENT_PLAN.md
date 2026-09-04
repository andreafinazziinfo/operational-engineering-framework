# Piano Tecnico — Hooks per Enforcement Deterministico

**Decisione a monte**: [ADR-005.md](./ADR-005.md) · **Backlog**: `NEXT_SESSION.md` #4 · **Gap che chiude**: `SELF_IMPROVEMENT_LOG.md` #4 (incidente git) e #9 (circuit breaker mancante)

**Stato**: implementazione in corso, owner ha approvato l'avvio (2026-09-04). Stato per unità:

| Unità | Stato |
|---|---|
| 4 — CI staleness check | ✅ Implementata e testata (positivo + negativo) |
| 1 — Hook blocco git distruttivo | ✅ Implementata e testata (logica in repo di prova isolato) |
| 2 — Hook check post-edit | ✅ Implementata e testata (link rotto iniettato → avviso; file pulito/non-framework → silenzio) |
| 3 — Hook reminder SessionStart | ✅ Implementata e testata (data odierna → silenzio; data forzata 34gg fa → banner) |

**Aggiornamento — verifica end-to-end completata in questa sessione, dopo `/hooks`:**

- **Unità 1**: ✅ verificata dal vivo — comando `git checkout -- README.md` (modifica di test innocua) → è comparsa la richiesta di conferma con la motivazione esatta prevista. Owner ha rifiutato (comportamento corretto), file ripristinato senza usare di nuovo `git checkout` (troncamento diretto del byte aggiunto, non `git checkout` per evitare di riattivare inutilmente l'hook su un comando già rifiutato).
- **Unità 2**: ✅ verificata dal vivo, **ma solo dopo aver trovato e corretto un incidente reale** — vedi `SELF_IMPROVEMENT_LOG.md` #10: `check_consistency.sh` impiegava 19.4s (615 link, un `python3` per link) contro un timeout hook di 15s, quindi l'hook veniva killato in silenzio prima di produrre output. Isolato catturando input/output reali dell'hook (non un sospetto, una misura). Corretto: batch in un solo processo `python3`, 19.4s → 1.4s. Dopo il fix, l'hook ha consegnato correttamente l'`additionalContext` con l'esito di `check_consistency.sh`.
- **Unità 3**: non ancora verificata end-to-end (richiede l'inizio di una sessione nuova per far scattare `SessionStart`) — logica comunque provata via pipe-test diretto.

Nota per la Engineering Gate: il Pilastro 6 (Chaos/robustezza sotto latenza reale) era stato marcato N/A come "non applicabile a config locale" — l'incidente #10 mostra che era invece rilevante: un hook sincrono *è* un caso di robustezza sotto vincolo di tempo. Corretto a valle, non prima, perché il piano iniziale non aveva previsto di misurare la latenza reale dello script prima di adottarlo in un hook — lezione per prossimi hook: misurare sempre il tempo di esecuzione reale del comando prima di fissare un timeout, non assumerlo.

---

## Declaration of Intent (`4_AI_AGENT` Sez. C)

```
Codebase: GREENFIELD (nessun hook esiste oggi in questo repo — .claude/settings.json non esiste)
Tier adozione (se brownfield): N/A
Classificazione task: STANDARD, con Pilastri 7 e 8 elevati esplicitamente oltre il minimo 1-2 richiesto da STANDARD
  — motivo: la feature stessa è infrastruttura di enforcement/sicurezza (esegue check automatici, può
  bloccare comandi shell), coerente con "se incerto, non assumere tier più leggero" (4_AI_AGENT Sez. A)
Framework applicati: 1_DESIGN Pilastri 1, 2, 3, 7, 8 · 2_EXECUTION completo (Fase A via SPEC_TEMPLATE)
Framework NON applicati e perché:
  - 3_OPERATIONS: nessun sistema in produzione con SLO da monitorare
  - 6_STRATEGY: iniziativa single-owner, non multi-team/portfolio
  - 5_BROWNFIELD: greenfield, nessun codice legacy da valutare
Rischi non mitigati: vedi Pre-Mortem in ADR-005.md — il rischio "disabilitazione silenziosa degli hook"
  non ha mitigazione tecnica, solo procedurale (registrare in SELF_IMPROVEMENT_LOG.md se succede)
```

---

## Engineering Gate (9 Pilastri)

> Framework: `1_DESIGN_FRAMEWORK.md` v3.4 · Tier: STANDARD (Pilastri 7/8 elevati)

| Pilastro | Status | Notes / mitigations |
|----------|--------|---------------------|
| 1 Pre-Mortem | ✅ | 5 scenari in `ADR-005.md` (falso positivo blocco, overhead check, hook mal scritto = SPOF, soglia CI mal calibrata, disabilitazione silenziosa) |
| 2 ADR (Bloccante) | ✅ | `ADR-005.md` — 4 alternative scartate, criterio di falsificazione (≥3 sessioni), reversibilità dichiarata (two-way door) |
| 3 Blast Radius | ✅ | 4 meccanismi separati (non un hook monolitico) — un bug in uno non disabilita gli altri; testare in worktree isolato prima di `main` |
| 4 Data Provenance | N/A | Non applicabile — nessuna pipeline dati, la feature è enforcement di processo |
| 5 Idempotency | ✅ | Risolto nell'unità 3: `SessionStart` fire-una-volta-per-sessione by design in Claude Code, nessuna logica extra necessaria. Non ancora verificato in sessione reale (solo pipe-test diretto) |
| 6 Chaos | N/A | Non applicabile a config locale — nessun servizio da sottoporre a fault injection |
| 7 Circuit Breakers (Bloccante) | ✅ | Questa feature **è** il circuit breaker (unità 1 e 4) — auto-riferimento coerente: il meccanismo 4 (CI schedule) è testato in negativo prima del merge (vedi unità 4) |
| 8 Security & Secrets (Bloccante) | ✅ | Nessun secret coinvolto; hook eseguono solo `bash`/`grep` locali già presenti nel repo (`check_consistency.sh`), nessuna nuova dipendenza esterna; principio del minimo privilegio: hook 1 blocca, non esegue comandi aggiuntivi con permessi elevati |
| 9 Cost & Capacity | N/A | Nessun costo infra — hook locali, CI già esistente (job aggiuntivo settimanale, costo trascurabile) |

**Gate verdict**: **GO-with-gaps** — tutti i pilastri applicabili ✅, gap residuo: nessuna delle 3 unità hook (1, 2, 3) è stata provata end-to-end in una sessione Claude Code reale (limite del watcher config, non del codice) — richiede `/hooks` o riavvio da parte dell'owner
**Owner sign-off required for NO-GO items**: N/A — nessun NO-GO

---

## Task Breakdown (`2_EXECUTION` Fase A) — unità di lavoro

Ogni unità ≤ 2h, ≤ 3 moduli toccati, in ordine di dipendenza. Compilate secondo `SPEC_TEMPLATE.md`.

### Unità di lavoro 1: Hook `PreToolUse` — blocco comandi git distruttivi

**Tier ereditato**: STANDARD
**Piano di origine**: ADR-005.md, riga tabella #1

**Scope**
- Cosa cambia: nuovo `.claude/settings.json` con hook `PreToolUse` su `Bash`, pattern match su `git checkout --`, `git reset --hard`, `git clean -f`, `git branch -D`; script di supporto che verifica `git status --porcelain` prima di decidere se bloccare.
- Cosa **non** cambia: nessun altro comando `Bash` è toccato; l'hook non modifica il comportamento di `git status`, `git stash`, `git commit`.

**Criterio di successo verificabile**
- [x] In un repo git isolato di prova (`/tmp`, non questo repo): `git checkout -- file.md` con modifiche pendenti → hook produce `permissionDecision: "ask"` con motivazione.
- [x] Lo stesso comando su un file **senza** modifiche pendenti → nessun output (nessun falso positivo).
- [x] `git stash` seguito da `git checkout --` → nessun output (lo stash ha già messo in sicurezza il lavoro).
- [x] Controlli negativi aggiuntivi: comando non-git, `git status`, `git branch -d` (minuscolo, sicuro) → mai attivato.
- [x] Tutti e 4 i pattern distruttivi testati (`checkout --`, `reset --hard`, `clean -f`, `branch -D`) → tutti producono `ask`.
- [ ] **Prova end-to-end in una sessione Claude Code reale**: non eseguita — il watcher di config non osservava `.claude/` prima che `settings.json` esistesse (verificato con il metodo sentinel della skill `update-config`, poi ripulito). Richiede `/hooks` o riavvio sessione, azione che l'agente non può compiere da solo — owner deve verificarlo.

**Falsificazione**
- [ ] Se dopo 3 sessioni reali l'hook blocca comandi legittimi più spesso di quanto prevenga incidenti reali → il pattern match è troppo aggressivo, va ristretto o reso solo-warning invece che blocking.

**Dipendenze**
- Blocca: nessuna altra unità dipende da questa per iniziare.
- Bloccato da: nessuna.

**Pilastri `1_DESIGN` rilevanti**
- [ ] Pilastro 7: è il meccanismo di circuit breaker stesso.
- [ ] Pilastro 3: isolato dagli altri 3 hook — file/config separato.

**Rollback**
- Rimuovere l'entry `PreToolUse` da `.claude/settings.json` — nessun altro file toccato, nessuno stato persistente da disfare.

**Owner / verificatore**
- Chi esegue: agente AI (implementazione) su indicazione owner.
- Chi verifica: owner, testando manualmente i 3 casi sopra in un worktree isolato prima di merge su `main` (`7_COLLABORATION` Area C/D — verifica indipendente richiesta, tier STANDARD).

---

### Unità di lavoro 2: Hook `PostToolUse` — check automatico su edit ai file framework

**Tier ereditato**: STANDARD
**Piano di origine**: ADR-005.md, riga tabella #2

**Scope**
- Cosa cambia: hook `PostToolUse` su `Edit`/`Write` con path match `*_FRAMEWORK.md`, esegue `scripts/check_consistency.sh` e stampa il risultato come avviso (non blocca il tool call già eseguito — non può, l'edit è già avvenuto).
- Cosa **non** cambia: `scripts/check_consistency.sh` stesso non viene modificato: l'unità aggiunge solo il trigger automatico, non nuova logica di check.

**Criterio di successo verificabile**
- [x] Link rotto iniettato apposta in `1_DESIGN_FRAMEWORK.md` (poi ripristinato da copia `/tmp`) → l'hook produce `systemMessage` con l'output esatto di `check_consistency.sh` (`BROKEN: ... TROVATI 1 link rotti`).
- [x] Modifica a `README.md` (non-framework) → nessun output (path match corretto).
- [x] Modifica "pulita" a `1_DESIGN_FRAMEWORK.md` (nessun link rotto) → nessun output.
- [ ] **Prova end-to-end in sessione reale**: non eseguita, stesso limite del watcher config dell'unità 1.

**Falsificazione**
- [ ] Se l'esecuzione ad ogni singolo `Edit` (invece che a fine batch/sessione) risulta fastidiosa su modifiche multi-file in sequenza → spostare il trigger da `PostToolUse` a `Stop` (fine turno) invece di ogni singola modifica — decisione da prendere con evidenza reale, non a priori.

**Dipendenze**
- Blocca: nessuna.
- Bloccato da: nessuna (indipendente dall'unità 1).

**Pilastri `1_DESIGN` rilevanti**
- [ ] Pilastro 7: riduce il tempo-di-rilevazione (TTD) del drift da "al prossimo push" a "immediato".

**Rollback**
- Rimuovere l'entry `PostToolUse` da `.claude/settings.json`.

**Owner / verificatore**
- Chi esegue: agente AI.
- Chi verifica: owner, osservando il comportamento su ≥ 2 modifiche reali ai file framework prima di considerarlo stabile.

---

### Unità di lavoro 3: Hook `SessionStart` — reminder `NEXT_SESSION.md`

**Tier ereditato**: STANDARD
**Piano di origine**: ADR-005.md, riga tabella #3

**Scope**
- Cosa cambia: hook `SessionStart` che legge la data "Ultima sessione" in `NEXT_SESSION.md` e stampa un banner se assente o > 14 giorni.
- Cosa **non** cambia: non impedisce l'inizio della sessione (soft reminder, non blocco) — coerente con la scelta di non essere troppo invasivi su un controllo temporale con soglia arbitraria.

**Criterio di successo verificabile**
- [x] `NEXT_SESSION.md` datato oggi (2026-09-04) → nessun banner.
- [x] Data forzata a 34 giorni fa (copia in `/tmp`, mai il file reale) → banner con messaggio corretto (giorni calcolati, soglia citata).
- [x] Idempotency (Pilastro 5, gap ⚠️ della gate table): **chiuso per costruzione**, non serve logica extra — `SessionStart` è un evento che fire-una-volta-per-sessione by design in Claude Code, non ad ogni turno. Il gap nella Engineering Gate era una preoccupazione a priori rivelatasi non necessaria all'implementazione.
- [ ] **Prova end-to-end in sessione reale**: non eseguita, stesso limite del watcher config delle altre unità.

**Falsificazione**
- [ ] Se in uso reale il banner comparisse più di una volta per sessione, l'assunto su "SessionStart fire-once" sarebbe falso e andrebbe rivisto con una guardia esplicita (es. file di lock in `/tmp` per session_id).

**Dipendenze**
- Blocca: nessuna.
- Bloccato da: nessuna.

**Pilastri `1_DESIGN` rilevanti**
- [ ] Pilastro 5 (Idempotency): stesso evento non deve produrre il banner più volte nella stessa sessione — unico punto dove questo piano lo marca ⚠️ nella gate table, va chiuso qui prima di dichiarare l'unità Done.

**Rollback**
- Rimuovere l'entry `SessionStart` da `.claude/settings.json`.

**Owner / verificatore**
- Chi esegue: agente AI.
- Chi verifica: owner, su almeno 1 sessione con data forzata > 14gg e 1 sessione normale.

---

### Unità di lavoro 4: Estensione CI — soglia di staleness su `SELF_IMPROVEMENT_LOG.md`

**Tier ereditato**: STANDARD
**Piano di origine**: ADR-005.md, riga tabella #4 · chiude gap #9

**Scope**
- Cosa cambia: `.github/workflows/check-consistency.yml` guadagna un trigger `schedule` (cron settimanale) e uno step che calcola i giorni trascorsi dall'ultima data `### YYYY-MM-DD` in `SELF_IMPROVEMENT_LOG.md`; fallisce il job (o stampa un warning, da decidere in review) se > 30 giorni.
- Cosa **non** cambia: il job `push`/`pull_request` esistente resta identico — questa è un'aggiunta, non una modifica del comportamento attuale (verificato da Check 1/2/3 di `check_consistency.sh` restare verdi).

**Criterio di successo verificabile**
- [x] Test in negativo (stesso pattern usato per Check 3 in `SELF_IMPROVEMENT_LOG.md` #6): data forzata a `2026-01-01` (246 giorni) in `SELF_IMPROVEMENT_LOG.md`, `INCLUDE_STALENESS_CHECK=1` → `FAIL`, `STALE:` riportato correttamente. Ripristinato da una copia in `/tmp` (non `git checkout`, lezione incidente #4), diff verificato = 0.
- [x] Test in positivo: con la data odierna (2026-09-04), `INCLUDE_STALENESS_CHECK=1` → `OK`, 0 giorni.
- [x] Comportamento di default invariato: `check_consistency.sh` senza il flag produce lo stesso output di prima (Check 1-3 identici, Check 4 = `SKIP`).

**Falsificazione**
- [ ] Se il primo trigger reale in produzione (dopo settimane) è un falso allarme (es. l'owner ha lavorato ma su altro, non sul manuale) → la soglia di 30gg era mal calibrata, non il meccanismo — alzarla, non rimuoverlo.

**Dipendenze**
- Blocca: nessuna.
- Bloccato da: nessuna (indipendente dagli hook 1-3, vive in CI non in `.claude/`).

**Pilastri `1_DESIGN` rilevanti**
- [ ] Pilastro 7: è esattamente il circuit breaker mancante identificato nel gap #9.
- [ ] Pilastro 2: soglia (30gg) dichiarata esplicitamente arbitraria e rivedibile, non presentata come definitiva.

**Rollback**
- Rimuovere il trigger `schedule` e lo step aggiunto dal workflow YAML — il job `push`/`pull_request` esistente non viene toccato.

**Owner / verificatore**
- Chi esegue: agente AI.
- Chi verifica: owner, rivedendo il diff del workflow YAML prima di merge (CI su `main` è superficie condivisa, non solo locale — verifica indipendente richiesta).

---

## Ordine di esecuzione consigliato

1. Unità 4 (CI, indipendente, rischio più basso — non tocca `.claude/settings.json` quindi non rischia di rompere la sessione stessa)
2. Unità 1 (blocco git — valore più alto, chiude un incidente reale già accaduto)
3. Unità 2 (check post-edit)
4. Unità 3 (reminder session — valore più basso, priorità minore)

**Nota**: nessuna unità è bloccante per le altre — possono anche essere fatte in ordine diverso o parzialmente, purché ognuna sia testata isolata (Blast Radius, Pilastro 3) prima di aggiungerne un'altra a `.claude/settings.json`.

---

## Definition of Done (tier STANDARD, `DEFINITION_OF_DONE.md`)

- [ ] Test pertinenti eseguiti per ogni unità (criteri di successo sopra)
- [ ] ADR presente (`ADR-005.md`) ✅ già fatto
- [ ] Test strategy definita prima del codice ✅ questo documento
- [ ] Pre-mortem minimo (≥ 3 scenari) ✅ 5 scenari in `ADR-005.md`
- [x] Documentazione aggiornata: `ADR-005.md` aggiunto all'indice ADR e al file tree in `README.md`, nuova sezione Changelog `2026-09-04 (b)` in `README.md` e `CHANGELOG.md`, corrette 2 claim stale sulla skill (ora verificata una volta, voce #8). `archify-out/` verificato **non** necessitare aggiornamento — il diagramma copre le fasi Discovery→Design→Execution→Ops, non menziona Skill/Hook come nodi (verificato via grep), quindi non stale rispetto a questa modifica
- [ ] Coverage N/A (config, non codice applicativo con test automatizzati in senso stretto — verifica manuale documentata sopra)

---

## Cosa questo piano NON copre (deferral esplicito)

- Enforcement dei Pilastri 2/8 in generale (es. un hook che verifica che ogni commit su file `*_FRAMEWORK.md` referenzi un ADR) — non richiesto da nessun incidente reale osservato finora, non costruire "perché si potrebbe" (regola anti-over-building).
- Un hook che impedisce del tutto (non solo avvisa) il merge se `check_consistency.sh` non è pulito — la CI già lo fa post-push; un blocco locale pre-commit è un'estensione naturale ma non ancora richiesta da un incidente osservato.
- Sincronizzazione di questi hook verso i fork consumer — stesso scope-cut già dichiarato per la skill in `ADR-004.md`.

## 🔗 Collegamenti

- Decisione → [ADR-005.md](./ADR-005.md)
- Gap che chiude → [SELF_IMPROVEMENT_LOG.md](./SELF_IMPROVEMENT_LOG.md) #4, #9
- Backlog di origine → [NEXT_SESSION.md](./NEXT_SESSION.md) #4
- Template usato → [SPEC_TEMPLATE.md](./SPEC_TEMPLATE.md)
- Tier/DoD → [DEFINITION_OF_DONE.md](./DEFINITION_OF_DONE.md)
