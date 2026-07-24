# Threat Model — [Feature / Modulo / Change]

**Obbligatorio per tier CRITICO** · consigliato per STANDARD su moduli con auth/dati utente.  
Collegato a `1_DESIGN` Pilastro 8 · review in `2_EXECUTION` Fase D.

**Data**: YYYY-MM-DD · **Owner**: ___ · **Stato**: Bozza | Approvato

---

## 1. Scope

- **Cosa si modifica**: _______________
- **Confini**: cosa è fuori scope _______________
- **Dati trattati**: PII · pagamenti · credenziali · nessuno
- **Ambienti**: dev / staging / prod

---

## 2. Asset da proteggere

| Asset | Sensibilità | Dove risiede |
|-------|-------------|--------------|
| | Alta/Media/Bassa | |

---

## 3. Attori e trust boundary

| Attore | Trust level | Accesso |
|--------|-------------|---------|
| Utente anonimo | | |
| Utente autenticato | | |
| Admin / operatore | | |
| Servizio interno | | |
| Terza parte (API) | | |

**Diagramma confini** (opzionale): `[client] → [API] → [DB]`

---

## 4. STRIDE (minimo 1 minaccia per categoria rilevante)

| Categoria | Minaccia | Mitigazione | Residuo |
|-----------|----------|-------------|---------|
| **S** Spoofing | | | |
| **T** Tampering | | | |
| **R** Repudiation | | | |
| **I** Info disclosure | | | |
| **D** Denial of service | | | |
| **E** Elevation of privilege | | | |

*Omettere categorie non applicabili con motivazione.*

---

## 5. Superficie di attacco

- [ ] Endpoint nuovi/modificati: _______________
- [ ] Input utente: validazione ___ · sanitization ___
- [ ] Secrets: vault · mai in log · rotazione ___
- [ ] Dipendenze nuove: scan CVE eseguito · esito ___
- [ ] AuthN/AuthZ: modello ___ · test negativi previsti

---

## 6. Controlli obbligatori (checklist)

- [ ] Principio minimo privilegio su credenziali
- [ ] Rate limiting su endpoint esposti
- [ ] Audit log su azioni sensibili
- [ ] Errori senza leak stack trace / dati interni in prod
- [ ] Piano risposta se minaccia si materializza → [runbooks/credential-leak-suspected.md](../runbooks/credential-leak-suspected.md)

---

## 7. Approvazione

- [ ] Review security (umano o checklist CRITICO DoD)
- [ ] Rischi residui accettati: ___ · approvato da: ___ · data: ___

---

## Archiviazione

Salvare come `security/threat-models/THREAT-NNN-[slug].md` nel repo progetto · referenziare in ADR correlata.
