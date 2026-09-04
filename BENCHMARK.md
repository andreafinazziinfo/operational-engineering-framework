# Benchmark — Confronto Esterno del Manuale

**Artefatto**: trasversale (non un framework numerato) · **Owner**: owner manuale
**Ultima revisione**: 2026-09-04 · **Prossima revisione**: agganciata al self-audit trimestrale ([2026-10-24](./0_META_FRAMEWORK.md))

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
| 3 | Protocollo esecuzione agente AI (intent/trace/escalation) | 8/10 | Solido, ma un solo agente generalista contro checklist — nessun ruolo specializzato (BMAD) né enforcement deterministico (Hooks) |
| 4 | Governance del manuale stesso | **9/10** | Impianto raro (`0_META`) + [scripts/check_consistency.sh](./scripts/check_consistency.sh) automatizzato su ogni push/PR ([.github/workflows/check-consistency.yml](./.github/workflows/check-consistency.yml)), primo run reale osservato **success** su GitHub (run 33836961414, 15s). Non 10: un solo run non prova affidabilità nel tempo |
| 5 | Igiene collaborazione/sessione multi-agente | 7/10 | Appena aggiunta (`7_COLLABORATION`), copertura ampia sulla carta, zero stress-test reale nel tempo |
| 6 | Generazione artefatti implementabili (PRD/spec/stories) | 4/10 | [SPEC_TEMPLATE.md](./SPEC_TEMPLATE.md) esiste, agganciato a `2_EXECUTION` Fase A — mai usato su un task reale |
| 7 | Validazione esterna / adozione reale | 2/10 | Il *concetto* gira in 2 fork reali (non nominati, Pilastro 8) — piccolo segnale positivo, non zero — ma nessuna adozione fuori dall'owner |
| 8 | Allineamento a semplicità raccomandata (Anthropic) | 6/10 | Tier + loading on-demand + Skill aiutano; 8 file + skill + benchmark + FAQ restano comunque tanta superficie da rispettare |
| 9 | Loop di verifica efficacia (previene problemi reali o è overhead?) | **3/10** | [SELF_IMPROVEMENT_LOG.md](./SELF_IMPROVEMENT_LOG.md) creato con 5 voci reali di questa sessione (2 incidenti, 2 gap, 1 domanda aperta non risolta a forza). Meccanismo esiste e ha dati veri, non solo teoria — non oltre 3/10 finché non copre più di una sessione |

**Voto composito**: **6.3/10** (media aritmetica: 57/90, aggiornato dopo CI su `check-consistency.yml`). Non confrontarlo linearmente con il vecchio 3.2/5 — il passaggio a 10 punti ha reso i giudizi più severi dove c'era margine, non solo più fini.

**Cosa significa il voto qui**: 9-10/10 = "pari o sopra il miglior comparabile verificato"; 6-8 = "impianto solido, esecuzione/verifica incompleta"; 3-5 = "meccanismo esiste, non provato"; 0-2 = "assente o non manifatturabile in una sessione". Non è un tetto: un 9/10 va rivisto in basso se emerge un comparabile migliore (cadenza trimestrale, stessa Idempotency applicata a questo file).

### Come alzare ulteriormente ogni dimensione

| # | Dimensione | Voto | Cosa la alzerebbe |
|---|---|:---:|---|
| 1 | Copertura ciclo di vita | 9/10 | Pilastro sustainability + test strategy dedicata (gap minori, mai prioritizzati) |
| 2 | Verificabilità | 9/10 | Enforcement automatico delle soglie (non solo checklist manuale) — vedi riga 4 |
| 3 | Protocollo esecuzione agente AI | 8/10 | Hooks Claude Code per enforcement deterministico invece di sola Skill — non ancora costruito |
| 4 | Governance del manuale | 9/10 | Script automatizzato in CI — resta da osservarlo girare su push reali nel tempo, non solo al primo commit |
| 5 | Igiene collaborazione | 7/10 | Solo uso reale ripetuto nel tempo — non manifatturabile in sessione |
| 6 | Generazione artefatti implementabili | 4/10 | `SPEC_TEMPLATE.md` usato su ≥ 3 task reali senza doverlo modificare |
| 7 | Validazione esterna | 2/10 | Non manifatturabile — richiede adozione reale fuori dall'owner |
| 8 | Allineamento a semplicità | 6/10 | Stesso fix riga 3 (Hooks) + eventuale riduzione file se l'uso reale mostra ridondanze |
| 9 | Loop di verifica efficacia | 3/10 | Popolare `SELF_IMPROVEMENT_LOG.md` su più sessioni reali, non solo questa — 5 voci di un solo giorno non bastano a dire che il loop funziona nel tempo |

**Le uniche due leve buildable-ora senza aspettare adozione esterna**: riga 4 (script di verifica meccanica nel self-audit) e riga 9 (meccanismo del loop di efficacia) — stessa lezione: il self-audit rivelatosi inaffidabile è l'esempio concreto di *perché* serve verifica automatica invece che auto-dichiarata.

---

## ✅ Cosa il manuale fa meglio dei comparabili

- Soglie quantitative per checklist — più verificabile di AWS/Google Well-Architected
- Governance esplicita del manuale stesso (`0_META`) — assente nei comparabili
- Copertura end-to-end unica: layer C-level (`6_STRATEGY`) + igiene collaborazione multi-sessione (`7_COLLABORATION`), nessuno dei framework confrontati copre entrambi

## ⚠️ Gap strutturali reali

1. ~~**Generazione artefatti implementabili**~~ — **parzialmente chiuso** (2026-09-04): [SPEC_TEMPLATE.md](./SPEC_TEMPLATE.md) aggiunto, ispirato al concetto BMAD (idea → unità implementabile) ma nel nostro idioma gate+soglia. Resta 4/10 finché non è battle-tested — non salire oltre senza evidenza reale d'uso.
2. **Validazione esterna** — non affrontato, non manifatturabile in una sessione: mai adottato fuori da uso interno diretto dell'owner (a parte il segnale debole dei 2 fork).
3. **Loop di verifica efficacia** — non affrontato: nessun meccanismo che misuri se seguire un tier ha davvero prevenuto un problema reale, distinto dal solo tracciare che è stato seguito.
4. ~~**Verifica meccanica del self-audit**~~ — **chiuso** (2026-09-04): [scripts/check_consistency.sh](./scripts/check_consistency.sh) scritto e verificato (testato che rileva sia link rotti sia versioni disallineate iniettati apposta). Resta da istituzionalizzarlo nel ciclo trimestrale reale, non solo farlo esistere.

Il gap 2 (validazione esterna) resta dichiarato, non affrontato — non manifatturabile. Il gap 3 (loop di verifica efficacia) è **parzialmente chiuso** (2026-09-04): [SELF_IMPROVEMENT_LOG.md](./SELF_IMPROVEMENT_LOG.md) esiste con 5 voci reali — resta a 3/10 finché non copre più sessioni nel tempo.

---

## 🔗 Collegamenti

- Self-audit interno (coerenza con sé stesso) → [SELF_AUDIT_2026-07-24.md](./SELF_AUDIT_2026-07-24.md)
- Governance → [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md)
- Goodhart's Law check (proxy vs obiettivo reale) → [7_COLLABORATION_FRAMEWORK.md](./7_COLLABORATION_FRAMEWORK.md) Area D
- Maturity progetto/org (adozione, diverso da questo benchmark) → [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md)

**Revisione**: trimestrale, agganciata al self-audit (`0_META` Area C). Aggiornare le fonti se cambia il panorama (nuove versioni BMAD, nuovi tool spec-driven, nuova guidance ufficiale sugli agenti AI).
