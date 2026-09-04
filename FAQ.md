# FAQ — Domande Frequenti sul Manuale

Non è un manuale parallelo: ogni risposta rimanda al file canonico invece di ripetere checklist o soglie — se questa pagina e un file numerato dicessero cose diverse, vince sempre il file numerato. Pensata per un umano che riprende il repo dopo mesi, o per orientarsi rapidamente prima di caricare i file giusti.

---

## Per iniziare

**Da dove comincio se uso questo manuale per la prima volta su un progetto?**
Da [AGENTS.md](./AGENTS.md) se sei un agente AI, da [README.md](./README.md) → sezione Quick Start se sei umano. La prima domanda reale è greenfield o brownfield: se il codice esiste già, si parte da [5_BROWNFIELD_FRAMEWORK.md](./5_BROWNFIELD_FRAMEWORK.md) Area A (baseline), zero merge.

**Devo leggere tutti gli 8 file prima di iniziare?**
No — è esattamente il problema che risolve [4_AI_AGENT_FRAMEWORK.md](./4_AI_AGENT_FRAMEWORK.md) §B (Loading Protocol) o la skill [.claude/skills/operational-engineering-framework](./.claude/skills/operational-engineering-framework/SKILL.md): si carica solo ciò che serve al tier del task in corso.

**Cos'è un "tier" e chi lo decide?**
LIGHT/STANDARD/CRITICO, definiti in [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md) — chi esegue il task lo dichiara (umano o agente), non è una scelta implicita. Un task che tocca produzione, security o denaro reale non può mai essere classificato LIGHT.

---

## Quale file per quale situazione

**Quando uso `1_DESIGN` vs `5_BROWNFIELD`?**
`1_DESIGN` per un piano tecnico nuovo (greenfield) o quando `5_BROWNFIELD` ti ci rimanda dopo la baseline. `5_BROWNFIELD` è sempre il primo file su codice già esistente, anche se poi confluisce in `1_DESIGN`.

**Quando uso `6_STRATEGY`?**
Solo per iniziative multi-team, revenue o portfolio — non per un singolo task, anche grande. Se stai scrivendo codice, quasi certamente non ti serve.

**Qual è la differenza tra `4_AI_AGENT` e `7_COLLABORATION`?**
`4_AI_AGENT` governa come un agente applica il manuale a **un task** — si ricarica ogni volta. `7_COLLABORATION` governa come owner e agente(i) lavorano insieme **nel tempo**, tra sessioni — si carica una volta a inizio sessione. Dettaglio nella sezione "Relazione con 4_AI_AGENT" dentro [7_COLLABORATION_FRAMEWORK.md](./7_COLLABORATION_FRAMEWORK.md).

**Quando compilo `SPEC_TEMPLATE.md` e quando no?**
Su STANDARD/CRITICO, o quando il contesto rischia di perdersi tra sessioni. Su un task LIGHT sotto le 2 ore con un output ovvio, è overhead inutile — vedi la sezione "Cosa questo template NON è" in [SPEC_TEMPLATE.md](./SPEC_TEMPLATE.md).

---

## Sessione e collaborazione

**Cosa faccio se due sessioni lavorano sulla stessa working tree in contemporanea?**
Il confine tra le due va dichiarato esplicitamente (path/moduli non sovrapposti) — [7_COLLABORATION_FRAMEWORK.md](./7_COLLABORATION_FRAMEWORK.md) Area B. `git status` prima di ogni operazione distruttiva non è opzionale.

**Sto per delegare a un sub-agent — cosa devo controllare prima?**
Se sai valutare l'output che riceverai (Circle of competence) e hai dichiarato un criterio di verifica *prima* di lanciarlo — [7_COLLABORATION_FRAMEWORK.md](./7_COLLABORATION_FRAMEWORK.md) Area C. Un output di sub-agent non verificato non entra mai in un merge su tier ≥ STANDARD.

**Come faccio in pratica il Recency/Currency Check?**
Se stai per affermare qualcosa di time-sensitive (versione di libreria, "best practice attuale", stato di un tool esterno) senza averlo verificato con una ricerca live in questa sessione, fermati e verificalo — non fidarti del training data. Checklist in [1_DESIGN_FRAMEWORK.md](./1_DESIGN_FRAMEWORK.md) Pilastro 2 e [7_COLLABORATION_FRAMEWORK.md](./7_COLLABORATION_FRAMEWORK.md) Area D.

---

## Verifica e fiducia

**Perché il self-audit dice 5/5 ma `BENCHMARK.md` dice 5.9/10?**
Sono due misure diverse per design. Il [self-audit](./SELF_AUDIT_2026-07-24.md) verifica se il manuale rispetta **le proprie regole** — per costruzione può arrivare a 5/5 senza dire nulla sul mondo esterno. [BENCHMARK.md](./BENCHMARK.md) confronta il manuale con framework reali verificati online. Nessuno dei due sostituisce l'altro.

**Cosa faccio se scopro che un pilastro è stato saltato sotto deadline?**
Non lo nascondi: registri la scorciatoia in [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) con trigger di revisione esplicito. Se è successo più di 2 volte su componenti sensibili, controlla il Circuit Breaker in [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md).

**Un output AI (mio di sessione precedente, o di un altro tool) sembra corretto — basta il "sembra"?**
No — è esattamente il pattern Goodhart's Law che [7_COLLABORATION_FRAMEWORK.md](./7_COLLABORATION_FRAMEWORK.md) Area D chiede di evitare: verifica contro l'obiettivo reale (un comando/log riproducibile), non contro il proxy ("sembra giusto", "il test passa").

---

## Governance del manuale stesso

**Chi approva una modifica al manuale?**
Chiunque — umano o agente — può proporla; solo l'owner del repo approva prima del merge. Matrice completa in [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md) §B (RACI).

**Perché una modifica al manuale a volte richiede un ADR e a volte no?**
Un ADR serve per decisioni architetturali (nuovo file, nuovo layer, cambio di come il manuale viene consumato — es. [ADR-003.md](./ADR-003.md), [ADR-004.md](./ADR-004.md)). Un checklist item aggiunto dentro un pilastro esistente no (es. i mental model aggiunti in `1_DESIGN`/`7_COLLABORATION`) — non è una nuova decisione, è un affinamento di una regola già accettata.

**Come uso la skill `operational-engineering-framework` invece di leggere i file a mano?**
Se il tuo tool supporta lo standard SKILL.md (Claude Code, Cursor, Antigravity e altri — dicembre 2025 in poi), [.claude/skills/operational-engineering-framework/SKILL.md](./.claude/skills/operational-engineering-framework/SKILL.md) applica l'intero manuale on-demand. **Non ancora verificata in una sessione reale** — se non si attiva quando dovrebbe, è un dato da registrare, non da ignorare (vedi [ADR-004.md](./ADR-004.md) Pre-Mortem).

---

## Collegamenti

- Indice completo → [README.md](./README.md)
- Entry point agenti AI → [AGENTS.md](./AGENTS.md)
- Governance → [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md)
