## Incidente: Database non raggiungibile

**Severità**: P1  
**Rilevamento**: connection pool exhausted · alert `db_up == 0` · errori "connection refused" / timeout su query

### Passi immediati (primi 15 min)

1. Verifica reachability: `[host:port]` da bastion / app pod · firewall / security group
2. Controlla metriche DB: CPU, connessioni, disco, replica lag
3. Se app satura pool: limita traffico ingress · scale read replica se read-heavy
4. Autorità rollback: `[owner-on-call]` decide stop write o failover
5. Attiva pagina stato / comunicazione se downtime > 5 min

### Rollback / mitigazione

- Failover a replica (se architettura lo prevede) — script: `[comando-failover]`
- Modalità read-only sull'app se solo replica disponibile
- Rollback deploy se migrazione schema recente sospetta

### Post-incidente

- [ ] Report scritto con timeline connessioni / query lente
- [ ] Verifica idempotency su retry post-recovery (`1_DESIGN` Pilastro 5)
- [ ] ADR se mancava piano failover documentato
