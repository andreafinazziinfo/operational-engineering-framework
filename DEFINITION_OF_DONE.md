# Definition of Done — Per Tier

Checklist unificata: un task/feature è **Done** solo se soddisfa il tier applicabile.  
Allineato a `0_META`, `2_EXECUTION`, `4_AI_AGENT`.

---

## Tier ASSESSMENT (solo brownfield, zero merge)

- [ ] Baseline scritta (`5_BROWNFIELD` Area A)
- [ ] Ledger seedato se debito noto
- [ ] Tier adozione progetto dichiarato (INCREMENTAL / FULL)
- [ ] **Nessun merge codice** in questa fase

---

## Tier LIGHT

- [ ] Test pertinenti eseguiti (o N/A documentato per solo-docs)
- [ ] Review Gate minimo (`2_EXECUTION` D): lint + diff letto
- [ ] Execution trace prodotto (`4_AI_AGENT` D)
- [ ] Nessun debito tecnico nascosto (o voce in [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md))

---

## Tier STANDARD

Tutto **LIGHT**, più:

- [ ] ADR se decisione architetturale rilevante (`1_DESIGN` Pilastro 2)
- [ ] Test strategy definita **prima** del codice (`2_EXECUTION` B)
- [ ] Coverage **≥ 80%** moduli core toccati (o giustificazione scritta)
- [ ] Pre-mortem minimo su modulo (`1_DESIGN` Pilastro 1, ≥ 3 scenari se modulo persistente)
- [ ] Documentazione aggiornata (README/API se comportamento cambia)

---

## Tier CRITICO

Tutto **STANDARD**, più:

- [ ] Pilastri Bloccanti Design: **2 (ADR), 7 (Circuit Breaker), 8 (Security)** verificati
- [ ] [Threat model](./security/THREAT_MODEL_TEMPLATE.md) compilato per feature/change
- [ ] Idempotency Pilastro 5: **≥ 4/6** soglie (o debito approvato in ledger)
- [ ] Rollback testato o piano rollback scritto (`2_EXECUTION` E)
- [ ] Security scan CI: **0** leak · **0** CVE Critical/High non mitigate
- [ ] SLO/monitoring verificati se tocca prod (`3_OPERATIONS` B)
- [ ] Nessun rischio non mitigato in Declaration of Intent senza approvazione umana

---

## Tier adozione FULL (redesign legacy)

- [ ] `5_BROWNFIELD` Area A completa
- [ ] `1_DESIGN` 9 pilastri su scope redesign
- [ ] `2_EXECUTION` ciclo completo fino a release
- [ ] `3_OPERATIONS` B + C attivi
- [ ] [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) target ≥ 4 definito

---

## Verifica rapida (umano o agente)

```
Task: _______________  Tier: _______________
[ ] DoD tier soddisfatta · eccezioni: _______________
Firma/trace: _______________
```
