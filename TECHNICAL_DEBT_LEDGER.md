# Technical Debt Ledger

Registro condiviso dei compromessi architetturali e delle scorciatoie prese sotto pressione.  
**Governato da**: `3_OPERATIONS` Area C · **Aggiornato da**: umani e agenti AI (`4_AI_AGENT` Sezione D)

| ID | Descrizione | Impatto | Trigger revisione | Owner | Data |
|----|-------------|---------|-------------------|-------|------|
| — | *Nessuna voce al momento — aggiungere righe sotto* | — | — | — | — |

## Regole

- Ogni voce deve avere **trigger di revisione** (data o evento), non solo "da fare prima o poi".
- Impatto: **Alto** | **Medio** | **Basso**.
- Voci da idempotency Pilastro 5 non soddisfatte (< 4/6 soglie): impatto minimo **Medio**, trigger prima del prossimo deploy critico.
- Revisione periodica obbligatoria: **ogni 30 giorni** o all'inizio di ogni sprint (vedi `3_OPERATIONS` Area C).

## Esempio

| ID | Descrizione | Impatto | Trigger revisione | Owner | Data |
|----|-------------|---------|-------------------|-------|------|
| TD-001 | Skip integration test su modulo X | Medio | Prima del prossimo release major | @owner | YYYY-MM-DD |
