# Disaster Recovery & Backup Plan

Template operativo collegato a `3_OPERATIONS` Area A e Pilastro 3 (`1_DESIGN` Blast Radius).  
Compilare **per progetto** — copiare sezione sotto in `DR_[PROGETTO].md` o compilare inline.

---

## Obiettivi di recovery

| Metrica | Target progetto | Note |
|---------|-----------------|------|
| **RTO** (Recovery Time Objective) | ___ ore | Tempo max per ripristino servizio |
| **RPO** (Recovery Point Objective) | ___ ore/min | Perdita dati massima accettabile |
| **MTTR** operativo (P1) | ≤ 4 h | Allineato a [runbooks/README.md](./runbooks/README.md) |

**Default consigliati** (tier CRITICO):

- RTO **≤ 4 h** · RPO **≤ 1 h** su dati transazionali · RPO **≤ 24 h** su dati analitici

---

## Scope

- [ ] Servizi in scope: _______________
- [ ] Dati in scope: DB ___ · object storage ___ · secrets vault ___
- [ ] Regioni / zone: _______________
- [ ] Escluso (degradazione accettabile): _______________

---

## Backup

| Asset | Frequenza | Retention | Cifrato | Test restore |
|-------|-----------|-----------|---------|--------------|
| Database prod | | ≥ 30 gg | sì | |
| Config / IaC | | | | |
| Secrets (metadata) | | | vault | |
| Log audit (se richiesto) | | | | |

- [ ] Backup **automatici** · non solo manuali
- [ ] Backup in **region/account separato** dal primary (blast radius)
- [ ] **Restore drill** eseguito ≥ **1×/trimestre** · ultimo: ___ · esito: ___

---

## Procedure di restore

### Database

1. Identificare punto restore (RPO)
2. Comando/procedura: `_______________`
3. Verifica integrità post-restore: `_______________`
4. Tempo stimato restore: ___ min

### Applicazione full stack

1. Rollback deploy → [runbooks/high-error-rate-post-deploy.md](./runbooks/high-error-rate-post-deploy.md)
2. Failover region (se previsto): `_______________`
3. Comunicazione stakeholder template: _______________

---

## Failover multi-region (se applicabile)

- [ ] DNS / load balancer failover documentato
- [ ] Replica read/write testata
- [ ] Runbook failover: passi ≤ 15 · owner: ___

---

## Escalation DR

| Severità | Condizione | Azione |
|----------|------------|--------|
| **DR-P1** | Perdita dati prod o region down | Attiva piano restore · owner DR: ___ |
| **DR-P2** | Backup fallito 2× consecutive | Fix backup before next window |
| **DR-P3** | Drill fallito | Ticket entro 7 gg |

---

## Checklist operativa trimestrale

- [ ] Restore drill eseguito e documentato
- [ ] RTO/RPO ancora validi per carico attuale
- [ ] Backup retention allineata a policy legali
- [ ] Aggiornamento post-incidente se DR testato in emergenza reale

---

## Collegamenti

- Incident runtime → [runbooks/](./runbooks/README.md)
- Debito "backup non testato" → [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md)
- Tier CRITICO richiede RTO/RPO compilati prima del go-live
