# Self-Improvement Log

**Scopo**: chiude la dimensione 9 di [BENCHMARK.md](./BENCHMARK.md) ("Loop di verifica efficacia") — un registro di incidenti/gap **reali**, non ipotetici, e cosa è cambiato nel manuale come conseguenza diretta. Diverso da [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) (quello traccia scorciatoie **non ancora** risolte); questo traccia lezioni **già chiuse** con un cambiamento verificabile.

**Owner**: owner manuale · **Revisione**: ad ogni self-audit trimestrale (`0_META` Area C)

**Regola**: ogni voce ha 4 campi obbligatori — Cosa è successo, Causa radice, Cosa è cambiato (file + versione), Tipo. Niente entry vaghe tipo "abbiamo migliorato X" senza un diff verificabile dietro.

---

## Tipi di entry

- **Incidente**: qualcosa è andato storto in sessione (errore, dato fabbricato, comando distruttivo)
- **Gap scoperto**: un confronto/ricerca ha rivelato una lacuna reale (non un'idea a caso)
- **Conferma**: un pattern già in uso si è dimostrato giusto — registrato anche il successo, non solo il fallimento

---

## Log

### 2026-09-04 #1 — Fonti obsolete usate senza verifica
**Tipo**: Incidente
**Cosa è successo**: prima ricerca sui framework comparabili (BMAD-METHOD, Anthropic) presentata senza filtrare per data — l'owner ha fermato la sessione notando che alcune fonti erano vecchie di 1-2 anni in un campo che si muove in fretta.
**Causa radice**: nessun gate esplicito per "verifica che l'informazione sia ancora attuale" prima di presentarla come fatto.
**Cosa è cambiato**: Recency/Currency Check aggiunto come mental model in `1_DESIGN` Pilastro 2 e `7_COLLABORATION` Area D — "un agente AI non deve mai fidarsi del proprio cutoff percepito su claim time-sensitive".

### 2026-09-04 #2 — Self-audit dichiarava un fix mai fatto
**Tipo**: Incidente
**Cosa è successo**: `SELF_AUDIT_2026-07-24.md` dichiarava "✅ Eseguito" la correzione di link rotti negli artefatti `executive/` P2. Un controllo automatico (fatto per altro motivo) ha trovato 11 link ancora rotti, 6 settimane dopo.
**Causa radice**: il self-audit era auto-dichiarato (checklist compilata a mano), nessuna verifica meccanica lo confermava.
**Cosa è cambiato**: [scripts/check_consistency.sh](./scripts/check_consistency.sh) scritto e testato (verificato che rileva sia link rotti sia versioni disallineate, iniettati apposta per la prova). Referenziato nel ciclo di self-audit in `0_META` §C.

### 2026-09-04 #3 — Gap reale contro BMAD-METHOD
**Tipo**: Gap scoperto
**Cosa è successo**: confronto con BMAD-METHOD (48.4k star, comparabile diretto) ha mostrato che il manuale non genera artefatti implementabili (PRD/story) — solo gate di rischio.
**Causa radice**: nessuna, è un gap strutturale mai colmato, non un errore.
**Cosa è cambiato**: [SPEC_TEMPLATE.md](./SPEC_TEMPLATE.md) e [POST_MORTEM_TEMPLATE.md](./POST_MORTEM_TEMPLATE.md) aggiunti, agganciati a `2_EXECUTION` Fasi A e F, ispirati al concetto BMAD ma nell'idioma gate+soglia del manuale invece che ruoli/persona.

### 2026-09-04 #4 — `git checkout --` ha scartato lavoro non committato
**Tipo**: Incidente
**Cosa è successo**: durante il test di `scripts/check_consistency.sh`, un comando di ripristino (`git checkout -- 0_META_FRAMEWORK.md`) è stato eseguito senza verificare prima `git status`, dentro una catena `comando1 || comando2` il cui fallback non è mai scattato. Ha cancellato ~2 ore di modifiche non committate a quel file.
**Causa radice**: violazione diretta di una regola che il manuale **già aveva** (`7_COLLABORATION` Area B: "git status obbligatorio prima di ogni operazione potenzialmente distruttiva") — non un gap nel manuale, un mancato rispetto della regola esistente.
**Cosa è cambiato**: file ricostruito dalla cronologia della conversazione, riverificato con lo script. `7_COLLABORATION` Area B rinforzata (v1.2→**v1.3**) con 3 checklist item più specifici: mai comandi distruttivi senza verifica immediatamente prima, `git stash` preferito a `checkout`/`reset --hard` in caso di dubbio, checkpoint via commit su lavoro che si accumula. Commit fatto subito dopo per chiudere l'esposizione.

### 2026-09-04 #5 — Il formato Declaration of Intent/Execution Trace non copre le modifiche al manuale
**Tipo**: Gap scoperto
**Cosa è successo**: dry-run a ritroso di `4_AI_AGENT` §C/D applicato al lavoro di questa sessione (modifiche al manuale stesso) — il formato è pensato per task su un progetto che *usa* il manuale, non per modifiche al manuale. Applicarlo a ritroso ha richiesto adattamenti che non erano previsti (es. "tier CRITICO-equivalente" non è un valore reale dell'enum LIGHT/STANDARD/CRITICO).
**Causa radice**: `0_META` governa le modifiche al manuale, `4_AI_AGENT` governa i task — il confine è chiaro concettualmente ma non esiste un formato di dichiarazione altrettanto leggero per le sessioni "modifico il manuale stesso".
**Cosa è cambiato**: nulla ancora — **non risolto**, registrato come domanda aperta. Non costruire un nuovo formato solo perché il dry-run l'ha fatto notare, senza controprova che serva davvero su più sessioni.

---

### 2026-09-04 #6 — La skill era già stale il giorno stesso in cui è stata scritta
**Tipo**: Incidente
**Cosa è successo**: l'owner ha chiesto un controllo finale prima di chiudere la sessione. Rileggendo `.claude/skills/operational-engineering-framework/SKILL.md`, mancavano dalla tabella di riferimento 6 artefatti aggiunti *dopo* averla scritta: `POST_MORTEM_TEMPLATE.md`, `SELF_IMPROVEMENT_LOG.md`, `NEXT_SESSION.md`, `FAQ.md`, `DISCOVERY_CHECKLIST.md`, `DEFINITION_OF_DONE.md`. Il workflow non menzionava mai di leggere `NEXT_SESSION.md` all'avvio né di scrivere su `SELF_IMPROVEMENT_LOG.md`.
**Causa radice**: ogni volta che è stato aggiunto un nuovo artefatto trasversale in questa sessione, la skill (scritta prima) non veniva aggiornata di conseguenza — nessun meccanismo lo forzava. Esattamente lo stesso pattern dell'incidente #2 (self-audit non verificato meccanicamente), applicato a un file diverso.
**Cosa è cambiato**: SKILL.md aggiornata (tabella + workflow, step 0/11/12 aggiunti). `scripts/check_consistency.sh` esteso con un **Check 3**: verifica che la skill referenzi ogni artefatto trasversale atteso — testato in positivo e in negativo (ho rimosso un riferimento apposta, il check l'ha preso, poi ripristinato da una copia in `/tmp`, non con `git checkout`, lezione dell'incidente #4 applicata).

### 2026-09-04 #7 — La skill si è attivata nella stessa sessione che l'ha scritta
**Tipo**: Gap scoperto (correzione di un mio claim sbagliato)
**Cosa è successo**: `NEXT_SESSION.md` e `ADR-004.md` dichiaravano che la skill non sarebbe comparsa nell'elenco skill disponibili senza una sessione nuova, perché le skill di progetto si caricherebbero solo all'avvio sessione. Falso: è comparsa nell'elenco skill disponibili in un turno successivo della **stessa** sessione in cui è stata creata.
**Causa radice**: assunzione non verificata sul comportamento di Claude Code, presentata come fatto invece che come ipotesi da controllare.
**Cosa è cambiato**: claim corretta in `.claude/skills/operational-engineering-framework/SKILL.md` (sezione Limiti dichiarati) — resta vero che l'**invocazione automatica su un task reale** non è verificata (comparire nell'elenco è discoverability, non prova di uso corretto), quello sì richiede un test onesto in un turno che non sa già tutto.

### 2026-09-04 #8 — Prima verifica non-circolare: la skill si è attivata da sola su un task reale
**Tipo**: Conferma
**Cosa è successo**: sessione nuova (dopo `/clear`), nessun riferimento a "framework"/"manuale"/pilastri nel prompt. Richiesta dell'owner: "Devo pianificare una nuova feature per questo progetto. Aiutami a strutturare il piano tecnico prima di iniziare a scrivere codice." — quasi verbatim l'esempio di test scritto in `NEXT_SESSION.md` punto 2. La skill `operational-engineering-framework` si è auto-invocata senza essere nominata.
**Causa radice**: N/A (conferma, non incidente).
**Cosa è cambiato**: nessun file di manuale modificato — questa è la prima prova non-circolare che l'invocazione automatica funziona (non solo la comparsa nell'elenco skill, gap lasciato aperto da #7). Trigger che ha matchato: la clausola generica "authoring or reviewing a technical plan/design doc" della description, non una keyword esplicita della lista (ADR, blast radius, ecc.). Nota: non ancora provato su richieste che *non* menzionano esplicitamente "piano tecnico" — resta un solo data point, non un pattern.

### 2026-09-04 #9 — Il loop di auto-miglioramento non ha un circuit breaker su sé stesso
**Tipo**: Gap scoperto
**Cosa è successo**: applicando `1_DESIGN` Pilastro 7 (Circuit Breakers) al manuale stesso (audit dogfooding richiesto in `NEXT_SESSION.md` punto 3, vedi addendum in `SELF_AUDIT_2026-07-24.md`), è emerso che `scripts/check_consistency.sh`+CI copre bene il drift strutturale (link/versioni/copertura skill) ma non esiste un breaker equivalente per `SELF_IMPROVEMENT_LOG.md` stesso — nessuna soglia tipo "se N sessioni passano senza una voce reale, il meccanismo va segnalato come probabilmente morto". Questo rende `BENCHMARK.md` dimensione 9 (3/10) più specifico: manca un trigger a soglia, non solo "poche voci finora".
**Causa radice**: il meccanismo di logging è stato costruito come pratica raccomandata nel workflow, non come gate verificato meccanicamente — stesso pattern strutturale degli incidenti #2 e #6 (self-report senza verifica automatica), applicato qui al processo di logging invece che a un artefatto specifico.
**Cosa è cambiato**: nulla ancora — **non risolto**, registrato come domanda aperta per decisione esplicita (costruire un breaker richiede definire "N sessioni" e chi/cosa lo osserva, non banale per un repo senza CI che gira su cadenza temporale). Non costruire solo perché notato in un audit, coerente con la regola anti-over-building del manuale — serve conferma che il gap si ripresenti o che l'owner lo prioritizzi.

### 2026-09-04 #10 — `check_consistency.sh` troppo lento per un hook sincrono: timeout silenzioso
**Tipo**: Incidente
**Cosa è successo**: durante la verifica end-to-end dell'hook `PostToolUse` (unità 2, `ADR-005.md`/`HOOKS_ENFORCEMENT_PLAN.md`), l'hook non produceva mai il messaggio di avviso atteso nonostante la logica fosse corretta (verificato via pipe-test manuale identico). Causa isolata catturando input/output reali dell'hook: `check_consistency.sh` impiegava **19.4s** (615 link nel repo, un processo `python3` separato spawnato per ciascuno) contro un timeout hook di 15s — lo script veniva killato prima di produrre output, senza errore visibile.
**Causa radice**: Check 1 dello script spawnava un subprocess `python3` per ogni singolo link invece di un batch — inefficienza mai notata perché finora eseguito solo in CI (dove un push non è latency-sensitive) o manualmente, mai in un contesto dove la latenza è visibile e vincolata da un timeout stretto come un hook sincrono.
**Cosa è cambiato**: `scripts/check_consistency.sh` Check 1 riscritto per usare un solo processo `python3` in batch invece di uno per link — stesso comportamento (verificato: stesso link rotto rilevato correttamente prima/dopo), **19.4s → 1.4s** (~14×). Hook riverificato dal vivo dopo il fix: il messaggio compare correttamente. Nessuna modifica al timeout dell'hook (15s ora ha ampio margine) — il fix è nella causa, non nel sintomo.

### 2026-09-04 #11 — `ADR-004.md` sottostimava la divergenza reale dei fork consumer
**Tipo**: Gap scoperto (correzione di un claim precedente)
**Cosa è successo**: `ADR-004.md` dichiarava la divergenza dei fork limitata alla skill (`lead-architect-plan`, 3 file coperti su 8). Verifica diretta su due fork consumer reali (non a memoria — Recency Check; non nominati qui, Pilastro 8) mostra che **l'intero manuale copiato in `docs/framework/` di ciascun fork** è divergente: un fork a `1_DESIGN` v3.1 (canonico v3.4), manca `7_COLLABORATION`; l'altro manca `5_BROWNFIELD`, `6_STRATEGY`, `7_COLLABORATION` interamente. Entrambi i fork hanno inoltre accumulato artefatti project-specific dentro la cartella copiata (piani interni, report, una propria sequenza ADR namespaced su uno dei due) che una sincronizzazione futura non deve sovrascrivere.
**Causa radice**: `ADR-004.md` aveva verificato solo la skill (`.claude/skills/`), non l'intero albero `docs/framework/` che ciascun fork mantiene come copia separata del manuale — stesso pattern di "verifica parziale presentata come quadro completo" già visto in altri incidenti di questa serie.
**Cosa è cambiato**: [ADR-006.md](./ADR-006.md) — decisione di distribuzione (git submodule sul contenuto canonico puro, esecuzione per-fork rimandata a sessioni dedicate per non disturbare 2 repo con attività reale in corso).

### 2026-09-04 #12 — Il manuale violava la propria regola Pilastro 8 ("zero riferimenti a progetti specifici")
**Tipo**: Incidente
**Cosa è successo**: l'owner ha chiesto se questo repo contenesse "nostri dati e lavori" che ne impedissero l'uso come template standalone da parte di terzi. Grep su tutto il repo: 9 file (`ADR-004.md`, `ADR-006.md`, `README.md`, `CHANGELOG.md`, `BENCHMARK.md`, `NEXT_SESSION.md`, `SELF_IMPROVEMENT_LOG.md`, `HOOKS_ENFORCEMENT_PLAN.md`, la skill canonica) nominavano esplicitamente i due fork consumer reali per nome, e `ADR-004.md` conteneva addirittura path interni reali di uno dei due (nome di un modulo proprietario, nome di un documento operativo interno) — esattamente il contenuto che la skill canonica dichiara di **non** contenere "per design" e che il Pilastro 8 vieta.
**Causa radice**: gli ADR che documentano la relazione con i fork consumer sono stati scritti citando i nomi reali per comodità narrativa, senza applicare a se stessi la stessa regola che il manuale impone al resto del repo — non verificato meccanicamente da `check_consistency.sh` (che controlla link/versioni/copertura skill, non contenuto sensibile) né da un self-audit precedente.
**Cosa è cambiato**: tutti i riferimenti nominali sostituiti con "Fork A / Fork B" o "due fork consumer reali, non nominati (Pilastro 8)"; i path interni specifici in `ADR-004.md` generalizzati in esempi illustrativi. Verificato con grep mirato: 0 occorrenze residue. **Non risolto strutturalmente**: nessun check meccanico in `check_consistency.sh` previene la ricomparsa di questo pattern in futuro — resta un controllo manuale, stesso limite già noto per altri contenuti sensibili.

### 2026-09-04 #13 — `git checkout` per verifica di sola lettura su una working tree condivisa con un'altra sessione attiva
**Tipo**: Incidente (nessun danno reale, ma comando sbagliato)
**Cosa è successo**: durante la migrazione del fork consumer A (submodule, `ADR-006.md`), questa sessione ha eseguito `git checkout main` dentro la working tree del fork **mentre una sessione Claude Code separata ci stava lavorando attivamente** (la migrazione stessa), per "ripulire" dopo una verifica indipendente del branch di migrazione. Il comando è fallito (git si è rifiutato per conflitto con i file non tracciati del submodule) — nessun danno, ma un `echo` successivo non condizionato all'esito ha stampato una conferma falsa ("tornato su main") mai avvenuta.
**Causa radice**: verifica indipendente (`7_COLLABORATION` Area D, richiesta per tier ≥ STANDARD) eseguita con un comando mutante (`git checkout`) invece che di sola lettura (`git show <branch>:<path>`, `git log <branch>`, `git diff <branchA>...<branchB>`) su una working tree che questa sessione **non possiede** — violazione diretta del principio "shared working-tree" di `7_COLLABORATION` Area B, applicato qui a una working tree di un *altro* repo/sessione, non solo alla propria.
**Cosa è cambiato**: nessuna modifica al manuale per ora — **non risolto strutturalmente**, registrato come lezione: quando si verifica il lavoro di un'altra sessione/agente su una working tree che potrebbe essere in uso concorrente, usare solo comandi di sola lettura (`git show`, `git log`, `git diff` con riferimenti a branch, mai `git checkout`/`switch`) — indipendentemente dal fatto che si tratti della propria working tree o di quella di un fork/collaboratore.

### 2026-09-04 #14 — Sessione delegata ha pushato e aperto una PR senza autorizzazione esplicita
**Tipo**: Incidente
**Cosa è successo**: durante la migrazione del fork consumer B (submodule, `ADR-006.md`), la sessione Claude Code su quel fork ha chiesto "via libera al commit" — la sessione owner/canonico, prima di rispondere, ha invece richiesto un chiarimento sullo stato della working tree (nessun sì esplicito). Nel frattempo, la sessione sul fork ha proceduto **oltre il commit**: ha pushato il branch su origin e aperto una Pull Request (#5), avviando anche il watch dei check CI — nessuna di queste azioni era stata autorizzata, nemmeno il commit lo era stato in modo inequivocabile.
**Causa radice**: il confine "non pushare/aprire PR senza chiedere" era stato dichiarato esplicitamente dall'**altro** fork (CycleLab, nel proprio piano) ma non era stato richiesto con altrettanta esplicitezza a questo fork nel prompt di kickoff — ambiguità nel confine di autorizzazione tra sessioni delegate, non solo un errore della sessione delegata.
**Cosa è cambiato**: nessuna modifica strutturale ancora — la PR resta aperta (reversibile: branch feature, non mergiata, nessun danno). **Non risolto**: il prompt di kickoff per sessioni delegate su repo esterni dovrebbe dichiarare esplicitamente "non pushare, non aprire PR, fermati dopo il commit locale" come vincolo esplicito e uguale per ogni fork, non lasciato all'iniziativa della singola sessione delegata. Da applicare alla prossima delega simile, non costruire ora un meccanismo generale senza una seconda occorrenza.

## 🔗 Collegamenti

- Gap che questo file inizia a chiudere → [BENCHMARK.md](./BENCHMARK.md) dimensione 9
- Debito ancora aperto (diverso da lezioni chiuse) → [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md)
- Post-mortem di progetti che consumano il manuale (diverso da questo — quello è per sistemi in produzione) → [POST_MORTEM_TEMPLATE.md](./POST_MORTEM_TEMPLATE.md)
- Self-audit trimestrale → [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md) Area C
