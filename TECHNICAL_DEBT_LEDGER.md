# Technical Debt Ledger

Registro condiviso dei compromessi architetturali e delle scorciatoie prese sotto pressione, e dell'attrito di collaborazione/tooling ricorrente.
**Governato da**: `3_OPERATIONS` Area C (Architetturale) · `7_COLLABORATION` Area E (Collaborazione/Tooling) · **Aggiornato da**: umani e agenti AI (`4_AI_AGENT` Sezione D)

| ID | Categoria | Descrizione | Impatto | Trigger revisione | Owner | Data |
|----|-----------|-------------|---------|-------------------|-------|------|
| — | — | *Nessuna voce al momento — aggiungere righe sotto* | — | — | — | — |

## Regole

- Ogni voce deve avere **trigger di revisione** (data o evento), non solo "da fare prima o poi".
- **Categoria**: **Architetturale** (scorciatoia di design/codice, `3_OPERATIONS` C) | **Collaborazione/Tooling** (attrito di sessione, delega, verifica, permessi ricorrente ≥ 2 volte, `7_COLLABORATION` Area E).
- Impatto: **Alto** | **Medio** | **Basso**.
- Voci da idempotency Pilastro 5 non soddisfatte (< 4/6 soglie): impatto minimo **Medio**, trigger prima del prossimo deploy critico.
- Revisione periodica obbligatoria: **ogni 30 giorni** o all'inizio di ogni sprint (vedi `3_OPERATIONS` Area C).

## Esempio

| ID | Categoria | Descrizione | Impatto | Trigger revisione | Owner | Data |
|----|-----------|-------------|---------|-------------------|-------|------|
| TD-001 | Architetturale | Skip integration test su modulo X | Medio | Prima del prossimo release major | @owner | YYYY-MM-DD |
| TD-002 | Collaborazione/Tooling | `git worktree remove` dimenticato post-cd, worktree orfani accumulati | Basso | Prossima sessione che tocca lo stesso repo | @owner | YYYY-MM-DD |
