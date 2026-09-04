# Post-Mortem Template

**Scopo**: artefatto compilabile per la checklist Fase F "Post-Mortem Reale" in [2_EXECUTION_FRAMEWORK.md](./2_EXECUTION_FRAMEWORK.md) — quella aveva la checklist, non un template da riempire. Stesso gap, stesso trattamento già dato a Fase A con [SPEC_TEMPLATE.md](./SPEC_TEMPLATE.md).

**Quando compilarlo**: entro **48 ore** da un incidente P1/P2 o una release fallita (soglia già in `2_EXECUTION` Fase F). Non per ogni bug minore — un post-mortem su un typo è overhead, non rigore.

---

## Template (copiabile)

```markdown
# Post-Mortem: [nome breve incidente/release fallita]

**Data**: YYYY-MM-DD
**Severità**: P1 / P2 / P3 (vedi matrice in `README.md` / `runbooks/`)
**Durata**: TTD (time to detect) ___ · TTR (time to resolve) ___

## Cosa doveva succedere
[...]

## Cosa è successo davvero
[...]

## Pre-Mortem vs realtà (`1_DESIGN` Pilastro 1)
| Rischio previsto nel Pre-Mortem | Si è materializzato? | Rischio non previsto emerso |
|---|---|---|
| | Sì/No | |

## Causa radice
[Five Whys o equivalente — non fermarsi al primo sintomo]

## ADR coinvolto (`1_DESIGN` Pilastro 2)
- [ ] L'ADR originale va aggiornato con una nota "esito reale"? Quale: ___
- [ ] La **reversibilità** dichiarata nell'ADR originale corrispondeva alla realtà, o annullare è costato più/meno del previsto?

## Miglioramento al framework
- [ ] C'è un miglioramento da riportare nei framework stessi (nuovo checklist item, soglia rivista)? → `0_META` + `CHANGELOG.md`
- [ ] Compromessi presi sotto pressione durante la risposta → riga in [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md)

## Azioni correttive
| Azione | Owner | Data limite | Stato |
|---|---|---|---|
| | | | |

## Verifica (`7_COLLABORATION` Area D)
- [ ] Ogni claim quantitativo sopra (TTD, TTR, causa) ha un log/comando di origine, non è dichiarato a memoria?
```

---

## Cosa questo template NON è

- Non sostituisce un incident report in tempo reale (`3_OPERATIONS` Area A) — questo è **dopo**, a mente lucida.
- Non è colpevolizzazione individuale — la colonna causa radice cerca processo/sistema, non persone (Hanlon's razor: prima incompetenza/processo, poi malizia).
- Non è obbligatorio su P3 minori — soglia già in `2_EXECUTION` Fase F: entro 48h su P1/P2, discrezionale sotto.

## 🔗 Collegamenti

- Fase F (dove si usa) → [2_EXECUTION_FRAMEWORK.md](./2_EXECUTION_FRAMEWORK.md)
- Pre-Mortem originale → [1_DESIGN_FRAMEWORK.md](./1_DESIGN_FRAMEWORK.md) Pilastro 1
- Incident response in tempo reale → [3_OPERATIONS_FRAMEWORK.md](./3_OPERATIONS_FRAMEWORK.md) Area A · [runbooks/](./runbooks/README.md)
- Debito emerso → [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md)
