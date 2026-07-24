## Incidente: Error rate alto post-deploy

**Severità**: P1 (se > 5% su core) | P2 (se 1–5%)  
**Rilevamento**: alert error rate **> 1% per ≥ 5 min** su endpoint core (`1_DESIGN` Pilastro 7) · spike 5xx in Grafana

### Passi immediati (primi 15 min)

1. Correlazione temporale: deploy in ultime **2 ore**? → `[CI/deploy-log]`
2. Confronta canary vs stable: canary fallisce?
3. Se error rate **> 5%** o SLO violati: **rollback immediato** — script `[comando-rollback]` (target **≤ 30 min** dal rilevamento)
4. Se 1–5%: freeze ulteriori deploy · isolare commit sospetto
5. Preserva log e trace ID campione per debug

### Rollback / mitigazione

- Esegui rollback testato (`2_EXECUTION` Fase E)
- Ripristina versione precedente · verifica metriche **≥ 30 min** stabili
- Feature flag off su path nuovo se rollback parziale

### Post-incidente

- [ ] Post-Mortem reale (`2_EXECUTION` Fase F) entro **48h**
- [ ] Voce debito tecnico se test pre-deploy insufficienti
- [ ] Aggiorna checklist Review Gate se gap evidente
