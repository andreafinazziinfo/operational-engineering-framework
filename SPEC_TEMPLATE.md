# Spec Template — Unità di Lavoro Implementabile

**Scopo**: trasformare un piano approvato (`1_DESIGN`) in unità di lavoro che un agente — umano o AI — può eseguire senza dover reinterpretare il contesto da zero. Compila una copia di questo template per ogni voce della checklist Fase A "Task Breakdown" in [2_EXECUTION_FRAMEWORK.md](./2_EXECUTION_FRAMEWORK.md).

**Perché esiste**: gap identificato in [BENCHMARK.md](./BENCHMARK.md) — il manuale aveva gate di rischio (`1_DESIGN`) e checklist di esecuzione (`2_EXECUTION` Fase A) ma nessun artefatto concreto per scomporre un design in unità implementabili, a differenza di framework spec-driven come BMAD-METHOD (PRD → architecture → stories).

**Ispirazione dichiarata**: pattern PRD→story di [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD) (MIT license, citato in `BENCHMARK.md`) — concetto riadattato, non struttura copiata. BMAD usa ruoli nominati (PM, Architect, Dev, QA) che si passano artefatti in sequenza; questo template è pensato per un agente generalista contro gate+soglia, coerente con la guidance Anthropic su semplicità/composabilità (vedi `BENCHMARK.md`).

---

## Come si usa

1. Una unità di lavoro = un elemento della checklist "Task Breakdown" (`2_EXECUTION` Fase A) — max **1-2 ore**, stesso limite già richiesto lì.
2. Compila i campi **prima** di scrivere codice, non a posteriori come documentazione.
3. Se l'unità richiede più di 2 ore o tocca **> 3 moduli** → torna a `1_DESIGN` (soglia già presente in `5_BROWNFIELD` Area D), non spezzarla arbitrariamente per farla stare nel template.
4. Non duplicare qui i pilastri di `1_DESIGN` o le aree di `7_COLLABORATION` — richiamali per riferimento, un solo posto per ogni regola.

---

## Template (copiabile)

```markdown
### Unità di lavoro: [nome breve]

**Tier ereditato**: LIGHT / STANDARD / CRITICO (`0_META`)
**Piano di origine**: [link ADR o documento 1_DESIGN]

**Scope**
- Cosa cambia: [...]
- Cosa **non** cambia — confine esplicito (`1_DESIGN` Pilastro 3, Blast Radius): [...]

**Criterio di successo verificabile**
- [ ] [comando/test/log riproducibile che deve passare — non "funziona" generico, coerente con `7_COLLABORATION` Area D]

**Falsificazione** (`1_DESIGN` Pilastro 2, se l'unità implica una scelta tecnica)
- [ ] Cosa dimostrerebbe che questo approccio era sbagliato: [...]

**Dipendenze**
- Blocca: [...]
- Bloccato da: [...]

**Pilastri `1_DESIGN` rilevanti** (solo quelli applicabili — non tutti e 9 per ogni unità)
- [ ] Pilastro N: [...]

**Rollback**
- Come si annulla se sbagliato: [...]

**Owner / verificatore**
- Chi esegue: [...]
- Chi verifica — Circle of competence (`7_COLLABORATION` Area C): [...] · verifica indipendente richiesta se tier ≥ STANDARD (`7_COLLABORATION` Area D)
```

---

## Cosa questo template NON è

- Non è un sistema multi-agente a ruoli (niente PM/Architect/Dev/QA separati) — un solo agente lo compila ed esegue.
- Non sostituisce `1_DESIGN` — presuppone che i 9 pilastri siano già stati applicati al piano a monte.
- Non è obbligatorio per tier LIGHT sotto le 2 ore dove il criterio di successo è già ovvio — usarlo quando aiuta a non perdere contesto tra sessioni (vedi `7_COLLABORATION` Area A, Handover), non come burocrazia fine a sé stessa.

## 🔗 Collegamenti

- Fase A (dove si usa) → [2_EXECUTION_FRAMEWORK.md](./2_EXECUTION_FRAMEWORK.md)
- Pilastri richiamati → [1_DESIGN_FRAMEWORK.md](./1_DESIGN_FRAMEWORK.md)
- Tier → [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md)
- Verifica/delega → [7_COLLABORATION_FRAMEWORK.md](./7_COLLABORATION_FRAMEWORK.md) Aree C, D
- Gap che questo file chiude → [BENCHMARK.md](./BENCHMARK.md) dimensione 6
