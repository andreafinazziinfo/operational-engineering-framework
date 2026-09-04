---
name: operational-engineering-framework
description: Applies the Operational Engineering Framework (9-pillar design gate, execution phases, brownfield areas, AI-agent task protocol, collaboration/session hygiene, strategy layer) to technical plans, refactors, migrations, session start, and delegation decisions. Use when authoring or reviewing a technical plan/design doc, scoping a refactor/migration/new subsystem, starting a work session on a repo that adopts this manual, delegating to a sub-agent, or when the user mentions: engineering gate, pre-mortem, ADR, blast radius, idempotency, chaos testing, circuit breakers, security gate, cost model, brownfield, tier LIGHT/STANDARD/CRITICO, session handover, shared working tree, sub-agent delegation, portfolio/roadmap, or "framework"/"manuale".
---

# Operational Engineering Framework — Skill Canonica

Versione canonica generalizzata della skill nota come `lead-architect-plan` nei fork CycleLab/Titan (decisione: [ADR-004.md](../../../ADR-004.md)) — rinominata `operational-engineering-framework` per allinearla al nome del repo/progetto invece di ereditare un nome legacy specifico di un fork. Copre tutti gli 8 file del manuale, non solo i 3 originariamente wrappati.

## Riferimento canonico

Manuale: [README.md](../../../README.md)

| Cosa serve | File |
|---|---|
| Governance del manuale, versioning, RACI | [0_META_FRAMEWORK.md](../../../0_META_FRAMEWORK.md) |
| Strategy/portfolio (solo iniziative multi-team) | [6_STRATEGY_FRAMEWORK.md](../../../6_STRATEGY_FRAMEWORK.md) |
| 9 Pilastri + checklist quantitative | [1_DESIGN_FRAMEWORK.md](../../../1_DESIGN_FRAMEWORK.md) |
| 6 fasi execution | [2_EXECUTION_FRAMEWORK.md](../../../2_EXECUTION_FRAMEWORK.md) · unità di lavoro → [SPEC_TEMPLATE.md](../../../SPEC_TEMPLATE.md) |
| Post-deploy, incidenti, debito tecnico | [3_OPERATIONS_FRAMEWORK.md](../../../3_OPERATIONS_FRAMEWORK.md) |
| Protocollo agente per singolo task | [4_AI_AGENT_FRAMEWORK.md](../../../4_AI_AGENT_FRAMEWORK.md) |
| Codebase esistente/legacy | [5_BROWNFIELD_FRAMEWORK.md](../../../5_BROWNFIELD_FRAMEWORK.md) |
| Igiene sessione, delega, verifica cross-agente | [7_COLLABORATION_FRAMEWORK.md](../../../7_COLLABORATION_FRAMEWORK.md) |
| Post-mortem compilabile (Fase F) | [POST_MORTEM_TEMPLATE.md](../../../POST_MORTEM_TEMPLATE.md) |
| Confronto esterno del manuale stesso | [BENCHMARK.md](../../../BENCHMARK.md) |
| Incidenti/gap reali → cosa è cambiato | [SELF_IMPROVEMENT_LOG.md](../../../SELF_IMPROVEMENT_LOG.md) |
| Handover di sessione (stato attuale, non un log) | [NEXT_SESSION.md](../../../NEXT_SESSION.md) |
| Domande frequenti umano-orientate | [FAQ.md](../../../FAQ.md) |
| Verifica meccanica link + versioni | [scripts/check_consistency.sh](../../../scripts/check_consistency.sh) |
| Pre-design go/no-go (idea vaga, zero codice) | [DISCOVERY_CHECKLIST.md](../../../DISCOVERY_CHECKLIST.md) |
| Definition of Done per tier | [DEFINITION_OF_DONE.md](../../../DEFINITION_OF_DONE.md) |

**Nota versioni**: non hardcodare mai un numero di versione qui — leggi l'header del file target. Causa diretta di staleness osservata nella versione precedente di questa skill (vedi `ADR-004`); coerente con il Recency Check di `7_COLLABORATION` Area D.

## Quando invocare

- Idea vaga, senza metriche, prima di qualsiasi piano tecnico → DISCOVERY_CHECKLIST.md, zero codice
- Inizio di una nuova sessione su un repo che adotta questo manuale → applica prima `7_COLLABORATION` (una volta, non per task)
- Creare o aggiornare un piano tecnico, ADR, wave doc, prompt di sessione
- Scoping di refactor, migrazione, nuovo sottosistema
- Review di un piano prima che inizi l'implementazione
- Delegare a un sub-agent
- L'utente chiede di "hardenare" o "architettare" una feature

## Workflow

```
0. SESSION START (una volta, non ripetere per ogni task):
   carica 7_COLLABORATION_FRAMEWORK.md — working tree condivisa, delega, verifica cross-agente
   se esiste NEXT_SESSION.md nel repo, leggilo prima di iniziare — è l'handover della sessione precedente

1. CLASSIFY task: greenfield/brownfield (4_AI_AGENT Sez. A) → tier LIGHT/STANDARD/CRITICO
   → dichiara intent (4_AI_AGENT Sez. C)

2. LOAD solo i file pertinenti al tier (4_AI_AGENT Sez. B):
   LIGHT     → 2_EXECUTION Fase B + D
   STANDARD  → 1_DESIGN Pilastri 1-2 + 2_EXECUTION completo
   CRITICO   → 1_DESIGN completo (9 pilastri) + 2_EXECUTION + 3_OPERATIONS Area B + C
   BROWNFIELD prima volta → 5_BROWNFIELD Area A, zero merge

3. Per ogni pilastro applicabile → rispondi alla checklist (incluse soglie quantitative)

4. Se il piano si scompone in unità di lavoro → usa SPEC_TEMPLATE.md per Fase A

5. INSERISCI (o aggiorna) ## Engineering Gate (9 Pilastri) nel documento di piano (template sotto)

6. Flag ⚠️ gap → mitigazione proposta OPPURE deferral esplicito con motivo e owner

7. BLOCCA l'avvio implementazione se un pilastro Bloccante (2 ADR / 7 Circuit Breaker / 8 Security)
   non ha mitigazione documentata; idempotency < 4/6 su CRITICO → escalation (4_AI_AGENT Sez. E)

8. Prima di lanciare un sub-agent → applica 7_COLLABORATION Area C (Circle of competence):
   sai valutare l'output che riceverai, o serve un criterio di verifica esterno dichiarato prima?

9. Prima di accettare un output — tuo di sessione precedente, o di un altro agente/tool AI —
   → applica 7_COLLABORATION Area D (Goodhart's Law, Recency/Currency Check)

10. Dopo l'esecuzione → produci EXECUTION TRACE (4_AI_AGENT Sez. D), anche su LIGHT
    e verifica DEFINITION_OF_DONE.md per il tier prima di dichiarare il task chiuso

11. Se è successo qualcosa degno di nota (incidente, gap scoperto, o conferma di un pattern) →
    registra una riga in SELF_IMPROVEMENT_LOG.md, non solo nella tua risposta all'utente

12. A fine sessione (o quando il contesto sta per esaurirsi) → sovrascrivi NEXT_SESSION.md
    con stato attuale, cosa non è verificato, prossimo passo esplicito (7_COLLABORATION Area A)
```

## Template sezione piano (obbligatorio su STANDARD/CRITICO)

```markdown
## Engineering Gate (9 Pilastri)

> Framework: 1_DESIGN_FRAMEWORK.md (vedi header per versione corrente) · Tier: [LIGHT/STANDARD/CRITICO]

| Pilastro | Status | Notes / mitigations |
|----------|--------|---------------------|
| 1 Pre-Mortem | ✅ / ⚠️ / N/A | SPOF + ≥5 scenari + effetti di secondo ordine: … |
| 2 ADR (Bloccante) | ✅ / ⚠️ / N/A | ADR-XXX, alternative, criterio di falsificazione, recency check: … |
| 3 Blast Radius | ✅ / ⚠️ / N/A | Fault domains isolated: … |
| 4 Data Provenance | ✅ / ⚠️ / N/A | Lineage ≤ 3 hop: … |
| 5 Idempotency | ✅ / ⚠️ / N/A | Re-run strategy, soglie x/6: … |
| 6 Chaos | ✅ / ⚠️ / N/A | Stress tests: … |
| 7 Circuit Breakers (Bloccante) | ✅ / ⚠️ / N/A | Auto-halt + telemetry: … |
| 8 Security & Secrets (Bloccante) | ✅ / ⚠️ / N/A | Secrets, minimo privilegio, IP/dati sensibili del progetto: … |
| 9 Cost & Capacity | ✅ / ⚠️ / N/A | Costo 10×, headroom: … |

**Gate verdict**: GO / GO-with-gaps / NO-GO
**Owner sign-off required for NO-GO items**: yes / no / N/A
```

## ADR inline mini-format (quando non serve un file ADR separato)

```markdown
### ADR-[NNN]: [Titolo]
- **Contesto**: …
- **Scelta**: …
- **Alternative scartate**: … (≥ 2)
- **Trade-off**: …
- **Criterio di falsificazione**: …
```

## Review checklist finale (self-check prima di chiudere)

- [ ] Task classificato + intent dichiarato (`4_AI_AGENT` Sez. A/C)
- [ ] Tutte le righe pilastro compilate — nessuna cella vuota
- [ ] Ogni ⚠️ ha mitigazione o deferral datato con owner
- [ ] Pilastro 8: nessun segreto in doc/esempi; verifica IP/dati sensibili **specifica del progetto corrente** (questa skill non li conosce, il progetto sì)
- [ ] Se delega presente: criterio di verifica dichiarato prima del lancio (`7_COLLABORATION` Area C)
- [ ] Gate verdict esplicito
- [ ] Execution trace prodotto (`4_AI_AGENT` Sez. D); debito → `TECHNICAL_DEBT_LEDGER.md` (categoria Architetturale o Collaborazione/Tooling)

## Limiti dichiarati

- **Aggiornato 2026-09-04**: la skill è comparsa nell'elenco skill disponibili nella stessa sessione in cui è stata scritta — la claim originale "serve una sessione nuova perché non comparirà" era sbagliata (vedi `SELF_IMPROVEMENT_LOG.md`). Resta vero che **non è ancora verificato** che si auto-invochi correttamente su un task reale senza essere nominata esplicitamente — comparire nell'elenco è discoverability, non prova di invocazione corretta. Non trattare l'una come prova dell'altra.
- Nessun contenuto specifico di progetto qui per design (coerente con la regola "zero riferimenti a progetti specifici" del repo canonico). Un fork che ne ha bisogno (IP policy, tool interni) li aggiunge nella propria copia, non qui.
- Questo file va tenuto sincronizzato a mano con i nuovi artefatti trasversali del repo — `scripts/check_consistency.sh` ora verifica che ogni artefatto atteso sia referenziato qui (Check 3), ma non verifica che il *workflow* descritto sopra li usi correttamente.

## Adattare a un fork

Se questo file viene copiato in un progetto che ha spostato il manuale sotto un path diverso (es. `docs/framework/`, pattern usato in alcuni fork esistenti), aggiorna i path relativi sopra di conseguenza.

**Data ultimo confronto con la versione canonica**: [compilare alla copia — serve a rilevare la deriva nel tempo, vedi `ADR-004.md`]
