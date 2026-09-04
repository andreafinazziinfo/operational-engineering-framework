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

## 🔗 Collegamenti

- Gap che questo file inizia a chiudere → [BENCHMARK.md](./BENCHMARK.md) dimensione 9
- Debito ancora aperto (diverso da lezioni chiuse) → [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md)
- Post-mortem di progetti che consumano il manuale (diverso da questo — quello è per sistemi in produzione) → [POST_MORTEM_TEMPLATE.md](./POST_MORTEM_TEMPLATE.md)
- Self-audit trimestrale → [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md) Area C
