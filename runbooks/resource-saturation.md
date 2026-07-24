## Incidente: Saturazione CPU / RAM / disco

**Severità**: P2 (degradazione) | P1 (OOM kill / disco pieno su DB)  
**Rilevamento**: alert utilizzo **> 85%** sostenuto · latency p95 > 3× · pod restart loop

### Passi immediati (primi 15 min)

1. Identifica risorsa satura: CPU / RAM / disco / inode — dashboard `[infra-dashboard]`
2. Top consumer: processo, query, log volume, job batch
3. Mitigazione rapida: scale orizzontale `[servizio]` · kill job non critico · rotazione log emergency
4. Se disco DB **> 90%**: stop write non essenziali · espansione volume o purge staging
5. Circuit breaker su path che amplifica carico

### Rollback / mitigazione

- Riduci rate limit / queue consumer concurrency
- Sposta workload batch fuori finestra picco
- Se causato da deploy: rollback + capacity review

### Post-incidente

- [ ] Capacity headroom review (`1_DESIGN` Pilastro 9 — target **≥ 30%**)
- [ ] ADR se limite strutturale superato
- [ ] Debito tecnico se monitoring soglie non calibrate
