# Adoption Guide — Adottare il Manuale in un Progetto

**Scopo**: guida passo-passo per collegare un progetto (nuovo o esistente) al manuale canonico via git submodule (`ADR-006.md`). Non è teoria: ogni passo qui è ricavato da **2 migrazioni reali eseguite lo stesso giorno** su due fork consumer indipendenti — una con storia granulare a 9 commit verificati indipendentemente, l'altra con un commit unico e push/PR autorizzati direttamente dall'owner. Dove qualcosa è dedotto e non ancora testato, è dichiarato esplicitamente.

**Prerequisito**: leggi `ADR-004.md` (skill), `ADR-005.md` (Hooks), `ADR-006.md` (perché submodule e non copia manuale) prima di iniziare.

---

## Percorso A — Progetto con una copia esistente da migrare (verificato 2 volte)

Il caso più comune se il progetto ha già una skill tipo `lead-architect-plan` o una cartella `docs/framework/` copiata a mano tempo fa.

### 0. Declaration of Intent

BROWNFIELD — esiste già consumo del manuale da migrare. Tier **STANDARD minimo**; eleva esplicitamente Pilastro 3 (Blast Radius) e 7 (Circuit Breaker) se: il repo ha sessioni/worktree concorrenti attivi, oppure gli Hook eseguiranno bash automaticamente su un repo con lavoro reale in corso. Non CRITICO se reversibile (`git submodule deinit` disfa tutto) e non tocca credenziali/produzione.

### 1. Audit reale prima di toccare nulla — non fidarti di `CLAUDE.md`/`AGENTS.md`

Entrambe le migrazioni hanno trovato che la documentazione esistente sottostimava la divergenza. Verifica di persona:
- Confronta la versione di ogni `*_FRAMEWORK.md` locale con l'header del canonico — non assumere che siano allineate.
- `grep -rl` nell'intero repo per ogni path sotto la cartella del manuale locale, **conta** i risultati — una delle due sessioni ne ha trovati ~2-3× di più di quanto stimato inizialmente.
- Per ogni file dentro la cartella del manuale locale, classifica: **(a)** copia stale pura del canonico (verrà sostituita 1:1 dal submodule, sicura da cancellare) — **(b)** stesso nome del canonico ma contenuto realmente divergente (va preservato, non cancellato) — **(c)** non esiste affatto nel canonico (di proprietà del progetto al 100%). Non dare per scontato lo status di un file solo dal nome.
- Se il progetto ha una propria sequenza ADR con namespace distinto da quello del canonico (es. un prefisso di progetto) — verificalo con un `ls` reale, non ricordarlo da una sessione precedente: **una delle due migrazioni ha inizialmente attribuito questa caratteristica al fork sbagliato**, corretto solo verificando con evidenza diretta.

### 2. Rehome del contenuto project-specific (categorie b e c)

`git mv` (preserva la storia) verso una cartella sibling **fuori** dal path che diventerà il submodule — il nome non conta (una migrazione ha usato `docs/framework-project/`, l'altra `docs/project/`), la separazione sì. La sequenza ADR di progetto, se esiste, resta nella propria cartella, intatta, mai dentro il submodule.

### 3. Rimuovi solo i file di categoria (a)

Solo le copie stale confermate — mai un file che potrebbe essere (b) o (c) senza averlo verificato al passo 1.

### 4. Aggiungi il submodule

```
git submodule add <url-repo-canonico> docs/framework
git -C docs/framework checkout <commit-sha-esplicito>
git add docs/framework .gitmodules
```

Pin a un **commit esplicito**, non a un branch che si aggiorna da solo (coerente con `ADR-006`: "aggiornato deliberatamente"). Usa l'ultimo commit del canonico salvo motivo specifico per non farlo — una migrazione ha inizialmente pinnato un commit di 2 versioni indietro senza motivo, corretto dopo.

**Il submodule porta l'intero repo canonico**, non un sottoinsieme curato — `ADR-006` parla di "contenuto canonico puro" come intento, ma un submodule git non permette un checkout parziale. Aspettati quindi file con lo stesso nome (es. `CHANGELOG.md`, `TECHNICAL_DEBT_LEDGER.md`) sia dentro il submodule (parlano del manuale) sia nella cartella project-specific del passo 2 (parlano del tuo progetto) — è normale, non un bug.

### 5. Ricrea la skill alla radice del progetto — mai dentro il submodule

Claude Code **non** scansiona `.claude/` annidato dentro un submodule. La skill va fisicamente ricreata in `.claude/skills/operational-engineering-framework/SKILL.md` alla radice del tuo repo, con i riferimenti che puntano **dentro** il submodule (es. `../../../docs/framework/1_DESIGN_FRAMEWORK.md`).

Preserva ogni estensione project-specific che la vecchia skill aveva (policy IP, mandati su tool specifici tipo GitNexus, puntatore alla sequenza ADR di progetto) come sezione locale esplicita — non lasciarla cadere silenziosamente. Rimuovi la vecchia skill legacy per intero (e l'eventuale copia in formato Cursor, se il progetto supporta anche quello).

### 6. Wire degli Hook — stessa logica della skill

Crea (o estendi, se esiste già) `.claude/settings.json` alla radice del progetto. Ogni `command` degli hook punta allo script **dentro il submodule** (es. `bash docs/framework/.claude/hooks/check-destructive-git.sh`).

Se uno script da cui un hook dipende è lento su scala reale (è già successo: `check_consistency.sh` impiegava 19.4s su un repo con molti link, contro un timeout hook di 15s — killato in silenzio) **misura il tempo reale nel tuo repo**, non fidarti dei numeri del canonico. Un hook può legittimamente diventare un no-op silenzioso se il progetto non usa la convenzione che verifica (es. nessun `NEXT_SESSION.md`) — non forzare un file fittizio solo per farlo attivare.

### 7. Riscrivi i riferimenti — meccanicamente, poi verifica due volte

`grep -rl` per ogni vecchio path nell'intero repo, `sed` solo su stringhe esatte (mai un pattern generico che potrebbe toccare contenuto non correlato). Riverifica con un secondo grep che zero riferimenti vecchi restino. Attenzione: un sed con scope sbagliato può toccare testo che menziona per caso il path di un progetto sibling (è successo una volta, innocuo perché era solo prosa in un file Markdown, ma va controllato subito, non assunto innocuo).

### 8. Verifica prima di considerarlo fatto — non un dry-run, un test dal vivo

- `check_consistency.sh` (dal submodule) sul tuo repo → deve uscire pulito
- `git submodule status` → pin corretto
- **Test live degli Hook, non solo pipe-test**: `/hooks` per ricaricare la config, poi un comando Bash **reale** (es. sporca un file tracciato e prova `git checkout -- <file>`) — verifica che compaia davvero la richiesta di conferma, non solo che lo script produca l'output giusto se eseguito a mano. Un pipe-test dimostra che la logica è corretta, non che l'hook si attiva per davvero nella sessione.
- Ripulisci gli artefatti di test **senza riattivare l'hook appena verificato** — tronca/ripristina direttamente il file, non rieseguire lo stesso comando appena bloccato.

### 9. Fermati — non pushare/mergiare senza autorizzazione esplicita

Commit locali (uno per passo logico è più facile da revisionare/revertire di un commit unico, ma entrambi gli approcci hanno funzionato). **Se deleghi questa migrazione a un'altra sessione, dichiara esplicitamente nel prompt di kickoff se push/PR sono autorizzati o vanno richiesti** — non lasciarlo implicito: in una delle due migrazioni l'ambiguità su questo punto ha causato un falso allarme (una sessione coordinatrice ha scambiato la propria mancanza di visibilità su un'autorizzazione data altrove per un'autorizzazione mancante).

---

## Percorso B — Progetto nuovo, nessuna copia pregressa

**Non ancora testato con un'esecuzione reale** — dedotto dal Percorso A rimuovendo i passi di migrazione, non verificato di persona. Più semplice per costruzione: nessun contenuto da riconciliare o spostare.

1. `git submodule add <url-repo-canonico> docs/framework`, pin esplicito
2. Crea `.claude/skills/operational-engineering-framework/SKILL.md` alla radice, riferimenti verso il submodule (passo 5 sopra)
3. Crea `.claude/settings.json` con gli Hook (passo 6 sopra)
4. Verifica con lo stesso rigore del passo 8 sopra — non dare per scontato che, essendo più semplice, richieda meno verifica

---

## Insidie note (gotcha)

- **Cambiare branch in un repo con submodule appena aggiunto può fallire**: git si rifiuta se il branch di destinazione non conosce il submodule e i file dentro il suo path risultano non tracciati. Non è un errore, è un rifiuto di sicurezza — usa `git submodule deinit` prima di cambiare branch, non forzare un `checkout`.
- **Chi verifica il lavoro di un'altra sessione sullo stesso repo deve usare solo comandi di sola lettura** (`git show <branch>:<path>`, `git log <branch>`, `git diff <A>...<B>`) — mai `checkout`/`switch` su una working tree che un'altra sessione potrebbe star usando in quel momento. Vissuto in prima persona durante una di queste due migrazioni.
- **Dichiara sempre esplicitamente il confine push/PR** quando deleghi questa migrazione — vedi passo 9.

---

## Provenienza

Derivata da 2 migrazioni reali eseguite il 2026-09-04 su fork consumer indipendenti (non nominati — Pilastro 8). Vedi `ADR-004.md`, `ADR-005.md`, `ADR-006.md`, e le voci #11–#14 di [SELF_IMPROVEMENT_LOG.md](./SELF_IMPROVEMENT_LOG.md) per il dettaglio di cosa è stato trovato e corretto durante l'esecuzione.

## 🔗 Collegamenti

- Decisione submodule vs copia → [ADR-006.md](./ADR-006.md)
- Skill canonica → [ADR-004.md](./ADR-004.md)
- Hooks → [ADR-005.md](./ADR-005.md), [HOOKS_ENFORCEMENT_PLAN.md](./HOOKS_ENFORCEMENT_PLAN.md)
- Incidenti reali durante le migrazioni → [SELF_IMPROVEMENT_LOG.md](./SELF_IMPROVEMENT_LOG.md) #11–#14
