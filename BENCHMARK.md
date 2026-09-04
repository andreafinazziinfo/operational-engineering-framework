# Benchmark — Confronto Esterno del Manuale

**Artefatto**: trasversale (non un framework numerato) · **Owner**: owner manuale
**Ultima revisione**: 2026-09-04 (terza revisione della giornata, dopo l'esecuzione e il merge reale di `ADR-006.md` su 2 fork) · **Prossima revisione**: agganciata al self-audit trimestrale ([2026-10-24](./0_META_FRAMEWORK.md))

---

## 🎯 Perché un benchmark separato dal self-audit

Il [self-audit](./SELF_AUDIT_2026-07-24.md) (`0_META` Area C) verifica se il manuale rispetta **le proprie regole** — i 9 pilastri applicati a sé stesso. È autoreferenziale per costruzione: un self-audit 5/5 dice solo che il manuale è coerente con sé stesso, non che regge il confronto con l'esterno.

Questo file fa l'opposto: confronta il manuale con **framework esterni reali, verificati online** — non a memoria — per evitare esattamente il pattern che [7_COLLABORATION](./7_COLLABORATION_FRAMEWORK.md) Area D chiama Goodhart's Law: ottimizzare per il proxy (il proprio checklist) invece che per l'obiettivo reale (essere davvero un buon framework).

---

## 📚 Framework comparati (fonti verificate, 2026-09-04)

| Framework | Cosa è | Rilevanza |
|---|---|---|
| **BMAD-METHOD** | Framework multi-agente open-source (48.4k star GitHub, MIT, v6) — persone nominate (Analyst, PM, Architect, Scrum Master, Dev, QA) che si passano artefatti durevoli: PRD → architecture.md → epics → stories | Il comparabile più diretto: risponde "chi fa cosa e cosa consegna", filosofia opposta e complementare al nostro "cosa deve essere vero prima di procedere" |
| **Panorama Spec-Driven Development 2026** | GitHub Spec Kit, AWS Kiro, Google Antigravity, OpenSpec, Tessl — quasi ogni tool AI-coding serio ha una variante: spec strutturato prima, l'agente implementa contro quello | Evidenzia un gap: il nostro manuale non genera un artefatto implementabile pezzo per pezzo |
| **AWS Well-Architected Framework** | 6 pilastri: operational excellence, security, reliability, cost optimization, performance efficiency, **sustainability** | Framework di qualità architetturale puro, in gran parte prosa qualitativa (non soglie numeriche come le nostre) |
| **Google Cloud Well-Architected Framework** | Allineato a SRE, DORA, FinOps, SAIF | Stessa famiglia di AWS, conferma l'assenza di un pilastro "sustainability" nel nostro manuale |
| **Anthropic — "Building Effective Agents"** | Guida ufficiale: le implementazioni di maggior successo non usavano framework complessi ma pattern semplici e componibili; raccomanda di ridurre l'astrazione muovendosi verso produzione | Fonte primaria per il rischio "downgrade" discusso nella governance — non è solo un'opinione interna |

---

## 📊 Rubric a 9 dimensioni (voto esterno, **0–10**)

Diverso apposta dalla scala 0–5 di [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) (quella misura l'adozione di un progetto sul manuale; questa misura il manuale contro l'esterno). Scala passata da 0–5 a **0–10** il 2026-09-04 su richiesta owner — non è un semplice ×2: ogni dimensione è stata ripensata da zero con la risoluzione doppia, ed è uscita **leggermente più severa**, non uguale. Vedi nota sotto su cosa significa la scala.

| # | Dimensione | Voto | Nota |
|---|---|:---:|---|
| 1 | Copertura ciclo di vita (strategy→ops→brownfield) | 9/10 | Più completo di AWS Well-Architected su questo asse, ma non "niente altro da coprire" — sustainability e test strategy restano gap minori dichiarati |
| 2 | Verificabilità (checklist + soglie quantitative) | 9/10 | Punto di forza reale vs prosa qualitativa AWS/Google — ma le soglie sono verificate a mano (self-report), non da enforcement automatico |
| 3 | Protocollo esecuzione agente AI (intent/trace/escalation) | **9/10** | Gap dichiarato (nessun enforcement deterministico) **chiuso**: [ADR-005.md](./ADR-005.md) — 3 Hooks Claude Code, 2 verificati dal vivo in questa sessione (blocco git distruttivo, check post-edit), 1 solo via pipe-test. Non 10: resta un solo agente generalista, nessun ruolo specializzato (BMAD) |
| 4 | Governance del manuale stesso | 9/10 | Invariato, ma con una sfumatura nuova: l'audit dogfooding di oggi ha trovato che il manuale violava la propria regola Pilastro 8 ("zero riferimenti a progetti specifici") in 9 file, per un tempo indefinito, rilevato solo perché l'owner l'ha chiesto esplicitamente — non da `check_consistency.sh` (che non controlla questa classe di leak, vedi [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) TD-001). La governance corregge quando qualcuno guarda, non ancora da sola |
| 5 | Igiene collaborazione/sessione multi-agente | **8/10** | Prima evidenza reale multi-sessione: coordinare 2 sessioni Claude Code delegate in parallelo su repo diversi ha prodotto 2 incidenti concreti (Area B — comando mutante su working tree condivisa; Area D — trust boundary tra sessioni, un falso allarme corretto). Non 9-10: gli incidenti sono stati della sessione coordinatrice stessa, non ancora un caso di team reale con più persone |
| 6 | Generazione artefatti implementabili (PRD/spec/stories) | 5/10 | **Prima vera prova d'uso**: [HOOKS_ENFORCEMENT_PLAN.md](./HOOKS_ENFORCEMENT_PLAN.md) ha compilato 4 unità di lavoro in formato `SPEC_TEMPLATE.md`, eseguite fino a Done e verificate. Resta 1 di ≥ 3 occasioni d'uso richieste per salire oltre — un solo task (per quanto reale) non è ancora un pattern |
| 7 | Validazione esterna / adozione reale | 2/10 | Invariato — nessuna nuova adozione fuori dall'owner |
| 8 | Allineamento a semplicità raccomandata (Anthropic) | 7/10 | Gli Hooks seguono esattamente il pattern che Anthropic raccomanda (*regole imposte → Hooks, non più logica infilata nella Skill*) — allineamento architetturale migliore, anche se la superficie totale di file è cresciuta (non 8, ma 7/10 perché la direzione è quella giusta, non la quantità) |
| 9 | Loop di verifica efficacia (previene problemi reali o è overhead?) | **6/10** | Terza revisione della giornata: `ADR-006.md` non solo deciso ma **eseguito e mergiato su 2 progetti reali indipendenti**, con 4 incidenti in più trovati e corretti durante l'esecuzione (#11-#14), non solo durante la scrittura del manuale. Il loop ha funzionato anche fuori dal proprio repo, su lavoro delegato reale — non solo su modifiche a se stesso. Non oltre 6/10: resta un solo giorno di osservazione, nessun trend su settimane/mesi |

**Voto composito**: **7.1/10** (media aritmetica: 64/90, terza revisione 2026-09-04). Salito da 6.9/10 grazie a `ADR-006.md` eseguito e mergiato su 2 fork reali, non solo deciso — dimensioni 5 e 9 toccate da evidenza multi-repo, non per giudizio più permissivo sulle altre.

**Cosa significa il voto qui**: 9-10/10 = "pari o sopra il miglior comparabile verificato"; 6-8 = "impianto solido, esecuzione/verifica incompleta"; 3-5 = "meccanismo esiste, non provato"; 0-2 = "assente o non manifatturabile in una sessione". Non è un tetto: un 9/10 va rivisto in basso se emerge un comparabile migliore (cadenza trimestrale, stessa Idempotency applicata a questo file).

### Come alzare ulteriormente ogni dimensione

| # | Dimensione | Voto | Cosa la alzerebbe |
|---|---|:---:|---|
| 1 | Copertura ciclo di vita | 9/10 | Pilastro sustainability + test strategy dedicata (gap minori, mai prioritizzati) |
| 2 | Verificabilità | 9/10 | Enforcement automatico delle soglie (non solo checklist manuale) — vedi riga 4 |
| 3 | Protocollo esecuzione agente AI | 9/10 | Verificare gli Hooks su altri 2-3 task reali (oggi solo 2 dei 3 hook verificati dal vivo) prima di considerarlo maturo |
| 4 | Governance del manuale | 9/10 | Un check meccanico per riferimenti a progetti specifici (TD-001) — non costruire ora, solo se il pattern si ripresenta |
| 5 | Igiene collaborazione | 8/10 | Un caso con più persone reali (non solo owner + sessioni delegate) — non manifatturabile in sessione |
| 6 | Generazione artefatti implementabili | 5/10 | `SPEC_TEMPLATE.md` usato su altre 2+ occasioni reali indipendenti (oggi è 1 di 3) |
| 7 | Validazione esterna | 2/10 | Non manifatturabile — richiede adozione reale fuori dall'owner |
| 8 | Allineamento a semplicità | 7/10 | Osservare se l'uso reale sui fork consumer rivela file ridondanti da tagliare |
| 9 | Loop di verifica efficacia | 6/10 | Continuare a popolare `SELF_IMPROVEMENT_LOG.md` su sessioni e settimane future, non solo un giorno — un trend richiede tempo, non solo eventi |

**Le leve restanti buildable senza aspettare adozione esterna** (righe 3, 6, 9): non richiedono più *costruire* qualcosa di nuovo — Hooks e `SPEC_TEMPLATE.md` esistono già e funzionano — richiedono **uso ripetuto reale**. Coerente con la richiesta dell'owner del 2026-09-04: il framework è al punto in cui l'editing ulteriore in isolamento rende meno di iniziare a usarlo davvero sui progetti consumer. Riga 7 (validazione esterna) resta l'unica non manifatturabile in alcun modo dall'owner solo.

---

## ✅ Cosa il manuale fa meglio dei comparabili

- Soglie quantitative per checklist — più verificabile di AWS/Google Well-Architected
- Governance esplicita del manuale stesso (`0_META`) — assente nei comparabili
- Copertura end-to-end unica: layer C-level (`6_STRATEGY`) + igiene collaborazione multi-sessione (`7_COLLABORATION`), nessuno dei framework confrontati copre entrambi

## ⚠️ Gap strutturali reali

1. ~~**Generazione artefatti implementabili**~~ — **battle-tested una prima volta** (2026-09-04, seconda revisione): `SPEC_TEMPLATE.md` usato in [HOOKS_ENFORCEMENT_PLAN.md](./HOOKS_ENFORCEMENT_PLAN.md), 4 unità reali eseguite fino a Done. 5/10, non oltre finché non capita altre 2 volte indipendenti.
2. **Validazione esterna** — non affrontato, non manifatturabile in una sessione: mai adottato fuori da uso interno diretto dell'owner (a parte il segnale debole dei 2 fork).
3. ~~**Loop di verifica efficacia**~~ — **soglia multi-sessione superata** (2026-09-04): [SELF_IMPROVEMENT_LOG.md](./SELF_IMPROVEMENT_LOG.md) ha ora voci da 2 sessioni distinte, inclusi 2 incidenti reali trovati e risolti dal loop stesso. 5/10, non un trend consolidato finché non copre più di 2 sessioni.
4. ~~**Verifica meccanica del self-audit**~~ — **chiuso** (2026-09-04): [scripts/check_consistency.sh](./scripts/check_consistency.sh) scritto e verificato (testato che rileva sia link rotti sia versioni disallineate iniettati apposta). Resta da istituzionalizzarlo nel ciclo trimestrale reale, non solo farlo esistere.
5. **Nuovo, minore**: nessun check meccanico per riferimenti a progetti/fork specifici nel contenuto (Pilastro 8) — trovato per caso il 2026-09-04, non da verifica automatica. [TD-001](./TECHNICAL_DEBT_LEDGER.md).

Il gap 2 (validazione esterna) resta l'unico non manifatturabile in alcun modo dall'owner solo.

---

## 🔗 Collegamenti

- Self-audit interno (coerenza con sé stesso) → [SELF_AUDIT_2026-07-24.md](./SELF_AUDIT_2026-07-24.md)
- Governance → [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md)
- Goodhart's Law check (proxy vs obiettivo reale) → [7_COLLABORATION_FRAMEWORK.md](./7_COLLABORATION_FRAMEWORK.md) Area D
- Maturity progetto/org (adozione, diverso da questo benchmark) → [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md)

**Revisione**: trimestrale, agganciata al self-audit (`0_META` Area C). Aggiornare le fonti se cambia il panorama (nuove versioni BMAD, nuovi tool spec-driven, nuova guidance ufficiale sugli agenti AI).
