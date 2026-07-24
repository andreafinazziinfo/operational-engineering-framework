# Runbook — Indice scenari

Runbook operativi collegati a `3_OPERATIONS` Area A · DR → [DR_BACKUP_PLAN.md](../DR_BACKUP_PLAN.md)

## Matrice severità incidenti

| Livello | Definizione | TTD target | TTR target | Esempio |
|---------|-------------|------------|------------|---------|
| **P1** | Servizio core down o data loss risk | ≤ 5 min | ≤ 4 h | DB unreachable, leak credenziali |
| **P2** | Degradazione significativa, workaround esiste | ≤ 15 min | ≤ 24 h | API terza offline, error rate alto |
| **P3** | Impatto limitato, nessun utente critico | ≤ 1 h | best effort | Saturazione risorse non core |

**Escalation**: P1 → comunicazione stakeholder immediata · P2 → ticket + owner on-call · P3 → backlog se non peggiora in 24h

Personalizza placeholder `[servizio]`, `[dashboard]`, `[comando]` con il tuo stack.

| Scenario | Severità tipica | File |
|----------|-----------------|------|
| API / servizio terzo offline | P1–P2 | [api-third-party-offline.md](./api-third-party-offline.md) |
| Database non raggiungibile | P1 | [database-unreachable.md](./database-unreachable.md) |
| Error rate alto post-deploy | P1–P2 | [high-error-rate-post-deploy.md](./high-error-rate-post-deploy.md) |
| Saturazione CPU/RAM/disco | P2 | [resource-saturation.md](./resource-saturation.md) |
| Credenziale / secret compromessa (sospetta) | P1 | [credential-leak-suspected.md](./credential-leak-suspected.md) |

**Obiettivi quantitativi** (allineati a `3_OPERATIONS`):
- Time-to-detect (TTD) P1: **≤ 5 minuti**
- Time-to-mitigate (primi passi): **≤ 15 minuti**
- Time-to-resolve P1: target **≤ 4 ore** (o rollback entro **≤ 30 minuti** se deploy recente)
