# Agent Instructions — Manuale Framework Ingegneristico

Segui **`4_AI_AGENT_FRAMEWORK.md`** come protocollo obbligatorio.

## Passo -3: Inizio sessione (una volta, prima del primo task)

Carica **[7_COLLABORATION_FRAMEWORK.md](./7_COLLABORATION_FRAMEWORK.md)** — working tree condivisa, delega a sub-agent, verifica di claim propri e di altre sessioni/agenti AI, attrito tool/permessi. Non ricaricare per ogni task: cadenza per-sessione, non per-task.

## Passo -2: Strategy (iniziativa multi-team / revenue / portfolio)

Obiettivo a livello azienda → **[6_STRATEGY_FRAMEWORK.md](./6_STRATEGY_FRAMEWORK.md)** + artefatto pertinente in **[executive/](./executive/README.md)**  
Verifica riferimento portfolio/roadmap **prima** di Discovery su prod revenue.

## Passo -1: Discovery (idea vaga)

Obiettivo senza metriche → **[DISCOVERY_CHECKLIST.md](./DISCOVERY_CHECKLIST.md)** (incluso §2b business case) · **zero codice**  
GO greenfield → `1_DESIGN` · GO brownfield → `5_BROWNFIELD` ASSESSMENT

## Passo 0: Greenfield o Brownfield?

| Tipo | Carica |
|------|--------|
| **GREENFIELD** | `1_DESIGN` → `2_EXECUTION` |
| **BROWNFIELD** | `5_BROWNFIELD` · prima volta = ASSESSMENT |

## Flusso minimo

1. Classifica codebase + tier (`4_AI_AGENT` A)
2. Dichiara intent (C) · carica solo file pertinenti (B)
3. Esegui checklist tier / area brownfield / area strategy se richiesta
4. Verifica **[DEFINITION_OF_DONE.md](./DEFINITION_OF_DONE.md)** prima di chiudere
5. Trace (D) · stop su escalation (E)

## Tier CRITICO — extra obbligatori

- [security/THREAT_MODEL_TEMPLATE.md](./security/THREAT_MODEL_TEMPLATE.md)
- [DR_BACKUP_PLAN.md](./DR_BACKUP_PLAN.md) se tocca prod
- DoD CRITICO completa
- [executive/RESPONSIBLE_AI_POLICY.md](./executive/RESPONSIBLE_AI_POLICY.md) se AI in path critico

## File framework

`0_META` · `6_STRATEGY` · `1_DESIGN` · `2_EXECUTION` · `3_OPERATIONS` · `5_BROWNFIELD` · `4_AI_AGENT` · `7_COLLABORATION`  
(suffisso `_FRAMEWORK.md`)

## Maturity

- **Progetto**: [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) · target minimo **3** su prod con utenti
- **Organizzazione**: stessa sezione **maturity org** · target **≥ 3** scale-up

Review trimestrale · self-audit → [SELF_AUDIT_2026-07-24.md](./SELF_AUDIT_2026-07-24.md)

Indice: [README.md](./README.md)
