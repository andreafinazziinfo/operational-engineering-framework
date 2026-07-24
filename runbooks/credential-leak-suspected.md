## Incidente: Credenziale / secret compromessa (sospetta)

**Severità**: P1  
**Rilevamento**: secret scan CI · leak in log · segnalazione esterna · accesso anomalo IAM

### Passi immediati (primi 15 min)

1. **Revoca / rotazione immediata** del secret `[nome-secret]` — vault `[vault-url]`
2. Blocca deploy che usano ancora il secret vecchio
3. Audit access log ultimi **7 giorni** su risorse collegate
4. Valuta scope: solo dev o anche produzione?
5. Escalation umana obbligatoria (`4_AI_AGENT` Escalation Trigger)

### Rollback / mitigazione

- Rotazione credenziali DB/API con piano testato in staging prima prod
- Invalida sessioni/token derivati se applicabile
- Patch esposizione (rimuovi da log, rotate Git history se committato)

### Post-incidente

- [ ] Report incidente security · notifica se dati personali coinvolti
- [ ] Aggiorna Pilastro 8 checklist · verifica scan CI **0 leak**
- [ ] Post-Mortem + ADR su processo rotazione
