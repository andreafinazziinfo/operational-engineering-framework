# Self-Audit Manuale — 2026-07-24

Audit applicando i **9 Pilastri di `1_DESIGN`** al manuale stesso (`0_META` Area C), dopo introduzione layer `6_STRATEGY`.

**Auditor**: owner manuale · **Prossimo audit**: 2026-10-24

---

## Esito sintetico

| Area | Esito | Note |
|------|-------|------|
| Pre-Mortem | ✅ | Trigger trimestrale + circuit breaker esteso |
| ADR | ✅ | ADR-000, ADR-001, **ADR-002** (strategy layer) |
| Blast Radius | ✅ | Alias file = nomi canonici · link executive corretti post-fix |
| Data Provenance | ✅ | Tabelle in Design, Execution, Operations, AI, Strategy |
| Idempotency | ✅ | Pilastro 5 · soglie 4/6 |
| Chaos Test | ✅ | Tier LIGHT + CRITICO non negoziabile |
| Circuit Breaker | ✅ | + maturity org + GO senza portfolio |
| Security | ✅ | Threat model · no secret negli esempi |
| Cost Model | ✅ | FinOps executive + Pilastro 9 Design |

**Maturity manuale (dogfooding)**: **5/5** — set completo operativo + C-level

**Maturity org (repo come organizzazione)**: **4/5** — P2 presenti · adozione reale dipende dal team

---

## Gap rilevati e piano di miglioramento

| # | Gap | Severità | Azione | Stato |
|---|-----|----------|--------|-------|
| 1 | Link rotti in artefatti P2 (`../adr/`, Pilastro 9 path errato) | Alta | Correzione cross-link in `executive/` | ⚠️ Marcato eseguito ma non lo era — 11 link rimasti rotti in 4 file P2, trovati e corretti solo il 2026-09-04 (vedi addendum sotto). Esempio concreto del perché serve `BENCHMARK.md`/Verification invece di fidarsi solo del self-audit |
| 2 | P2 assenti da `executive/README.md` | Media | Indice P2 aggiunto | ✅ Eseguito |
| 3 | `0_META` non referenziava `6_STRATEGY` | Alta | v1.6 · flusso · RACI · calendar | ✅ Eseguito |
| 4 | Discovery senza business case | Media | §2b business case | ✅ Eseguito |
| 5 | Maturity solo per progetto | Media | Sezione org in FRAMEWORK_MATURITY | ✅ Eseguito |
| 6 | Ops senza comms stakeholder | Media | Checklist Area A + template executive | ✅ Eseguito |
| 7 | `4_AI_AGENT` senza strategy gate | Alta | v1.6 · loading · escalation | ✅ Eseguito |
| 8 | README senza layer 6 | Media | README v2 con strategy | ✅ Eseguito |
| 9 | Self-audit non persistito | Bassa | Questo documento | ✅ Eseguito |
| 10 | `6_STRATEGY` indice P2 incompleto in framework body | Bassa | Riferimento `executive/README` P2 | ✅ Via README |

---

## Cross-consistency check (post-miglioramento)

- [x] 7 file `*_FRAMEWORK.md` (0–6 + 4)
- [x] `4_AI_AGENT` mapping include `6_STRATEGY`
- [x] Versioni header + CHANGELOG allineate
- [x] Nessun path a cartelle inesistenti (`adr/`, `discovery/`, `1_DESIGN/PILASTRO_9`)
- [x] ADR-002 documenta decisione strategy layer
- [x] AGENTS.md aggiornato come entry point

---

## Raccomandazioni prossimo trimestre

1. Compilare **almeno un esempio compilato** per PORTFOLIO e RISK (optional sample in repo)
2. Valutare badge maturity org in README dopo prima adozione reale
3. Review `RESPONSIBLE_AI_POLICY` se normativa EU AI Act evolve

---

## Collegamenti

- Governance → [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md) v1.7
- Strategy → [6_STRATEGY_FRAMEWORK.md](./6_STRATEGY_FRAMEWORK.md)
- Changelog → [CHANGELOG.md](./CHANGELOG.md)

---

## Addendum — 2026-09-04: introduzione `7_COLLABORATION`

Self-audit **delta** (9 Pilastri applicati alla scrittura del nuovo layer, non un audit completo del manuale — quello resta previsto per il **2026-10-24** trimestrale).

| Pilastro | Severità | Esito |
|---|---|---|
| Pre-Mortem | Alta | ✅ Rischio "diventa lettera morta o confligge con `4_AI_AGENT` §E" mitigato con sezione di confine esplicita nel nuovo documento |
| ADR | Bloccante | ✅ [ADR-003.md](./ADR-003.md) — Accettato, 4 alternative scartate |
| Blast Radius | Alta | ✅ Nessun escalation trigger duplicato/contraddetto — verificato riga per riga contro `4_AI_AGENT` §E |
| Data Lineage | Alta | ✅ Tabella Data Provenance nel nuovo documento · nessun riferimento a progetti specifici (regola Pilastro 8) |
| Idempotency | Alta | ✅ Soglie quantitative per ognuna delle 5 aree (non solo checklist qualitative) |
| Chaos Test | Alta | ✅ Soglie pensate per reggere sotto deadline (es. "0 worktree orfani", non un processo elaborato) |
| Circuit Breaker | Bloccante | ✅ "Circuit Breaker della Collaborazione" dedicato, 5 segnali quantitativi, distinto da quello del manuale e da quello per-task |
| Security | Bloccante | ✅ Nessun segreto/nome progetto reale negli esempi |
| Cost Model | Media | ⚠️ Confronto esplicito costo-overhead vs costo-non-averlo non quantificato in v1.0 — da valutare alla prima revisione se l'adozione reale lo richiede |

**Esito**: nessun pilastro Bloccante rosso. Gap Pilastro 9 non bloccante, annotato per revisione trimestrale (non è uno shortcut architetturale/di collaborazione ai sensi della definizione in `7_COLLABORATION` Area E, quindi non aggiunto al ledger — è una nota di qualità del documento).

**Fuori scope di questa modifica** (segnalato, non deciso): sincronizzazione verso i fork che consumano il manuale (submodule vs copia manuale) — verificato che oggi sono copie divergenti, non symlink.

---

## 📎 Addendum — 2026-09-04 (continua): 11 link rotti trovati e corretti

Un controllo automatico dei link su tutto il repo (fatto per verificare le modifiche di questa sessione, non per audit dedicato) ha trovato 11 link rotti pre-esistenti in 4 artefatti P2 (`RESPONSIBLE_AI_POLICY.md`, `VENDOR_SCORECARD.md`, `M&A_TECH_DD_CHECKLIST.md`, `HORIZON_BETS.md`) — path verso una struttura a cartelle mai esistita in questa forma (`1_DESIGN/PILASTRO_9.md`, `4_AI_AGENT/README.md`, `5_BROWNFIELD/README.md`, `discovery/DISCOVERY_SPIKE.md`) e doppio `../../` verso `6_STRATEGY_FRAMEWORK.md`. Il gap #1 sopra li dichiarava risolti dal 2026-07-24 — non lo erano. Corretti ora, verificati con lo stesso script: **0 link rotti su tutto il repo**.

Non è un incidente grave, ma è un esempio concreto e non ipotetico di perché il gap "Loop di verifica efficacia" in [BENCHMARK.md](./BENCHMARK.md) è reale: un self-audit può dichiararsi "fatto" senza esserlo, se nessuno lo riverifica meccanicamente.

---

## 📎 Addendum — 2026-09-04 (sessione separata, dopo `/clear`): audit dogfooding Pilastri 1, 2, 4, 7, 8

Eseguito da una sessione nuova (non quella che ha scritto le modifiche del giorno), su richiesta esplicita dell'owner via `NEXT_SESSION.md` punto 3. Applica solo i 5 pilastri indicati lì (i più rilevanti per un manuale, non un audit completo a 9).

**Verifica preliminare baseline**: sia questo file sia `BENCHMARK.md` risultano aggiornati alla stessa data odierna (2026-09-04) — nessun drift da segnalare, `scripts/check_consistency.sh` esce pulito (0 link rotti, versioni coerenti, Check 3 copertura skill ok).

| Pilastro | Severità | Esito |
|---|---|---|
| 1 Pre-Mortem | Alta | ✅ 5 scenari SPOF identificati (dipendenza dalla revisione umana come unico verificatore reale; skill/CLAUDE.md non caricati senza alert; corruzione sintattica di un `*_FRAMEWORK.md` non rilevata da check_consistency.sh, che verifica solo link/versioni; context budget saturo in sessione CRITICO tronca la lettura senza dirlo; "log farming" — voci vaghe in `SELF_IMPROVEMENT_LOG.md` per apparire produttivi, Goodhart). Nessuna azione nuova: SPOF #1 già noto/strutturale, gli altri annotati, non bloccanti oggi |
| 2 ADR (Bloccante) | Bloccante | ✅ N/A per nuovo ADR — questa sessione è un audit/verifica, non una decisione architetturale. Criterio di falsificazione rispettato nella voce di log associata (vedi `SELF_IMPROVEMENT_LOG.md` #8: dichiarato esplicitamente "un solo data point, non un pattern") |
| 4 Data Provenance | Alta | ✅ Ogni claim di questo addendum traccia a un file+sezione specifico, ≤ 3 hop. Verificato meccanicamente da `check_consistency.sh` |
| 7 Circuit Breakers (Bloccante) | Bloccante | ⚠️ **Gap reale, non bloccante oggi**: `check_consistency.sh`+CI è un breaker automatico per drift strutturale (link/versioni/copertura skill), ma **non esiste un breaker equivalente per il loop di auto-miglioramento stesso** (`BENCHMARK.md` dimensione 9) — nessuna soglia tipo "se N sessioni passano senza una voce reale in `SELF_IMPROVEMENT_LOG.md`, segnala che il meccanismo è probabilmente morto". Oggi il loop ha prodotto un segnale positivo genuino (voce #8, prima volta da una sessione diversa da quella che ha scritto il framework) — ma nulla se ne accorgerebbe se smettesse di succedere. Non costruire ora solo perché notato (regola anti-over-building del manuale) — registrato come domanda aperta, vedi `SELF_IMPROVEMENT_LOG.md` #9 |
| 8 Security | Bloccante | ✅ Nessun segreto/PII/nome progetto reale introdotto negli artefatti toccati oggi (verificato a mano sulla voce di log aggiunta) |

**Esito**: nessun pilastro Bloccante rosso. Un gap reale annotato (Pilastro 7 sul loop stesso), non bloccante, coerente con gap già dichiarato in `BENCHMARK.md` dimensione 9 — questo audit lo rende più specifico (manca un trigger a soglia, non solo "poche voci").

**Conferma baseline**: `SELF_AUDIT_2026-07-24.md` (corpo + addenda precedenti) e `BENCHMARK.md` restano accurati — nessuna revisione necessaria oltre questo addendum.
