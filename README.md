# Manuale Framework Ingegneristico

Set di documenti per progettare, eseguire, operare e governare sistemi software — greenfield e brownfield — con layer agenti AI.

## Mappa dei documenti

| Alias | File | Versione | Quando usarlo |
|-------|------|----------|---------------|
| `0_META` | [0_META_FRAMEWORK.md](./0_META_FRAMEWORK.md) | 1.5 | Governance del manuale · maturity |
| `1_DESIGN` | [1_DESIGN_FRAMEWORK.md](./1_DESIGN_FRAMEWORK.md) | 3.1 | Piano tecnico / refactor strutturale |
| `2_EXECUTION` | [2_EXECUTION_FRAMEWORK.md](./2_EXECUTION_FRAMEWORK.md) | 2.1 | Dal piano al rilascio |
| `3_OPERATIONS` | [3_OPERATIONS_FRAMEWORK.md](./3_OPERATIONS_FRAMEWORK.md) | 1.1 | Post-deploy: incidenti, SLO, debito |
| `5_BROWNFIELD` | [5_BROWNFIELD_FRAMEWORK.md](./5_BROWNFIELD_FRAMEWORK.md) | 1.0 | Codebase esistente |
| `4_AI_AGENT` | [4_AI_AGENT_FRAMEWORK.md](./4_AI_AGENT_FRAMEWORK.md) | 1.5 | Protocollo agenti AI |

## Flusso completo

```
DISCOVERY_CHECKLIST (idea vaga)
         │
    GO ──┼── greenfield ──► 1_DESIGN ──► 2_EXECUTION ──► 3_OPERATIONS
         │
         └── brownfield ──► 5_BROWNFIELD (ASSESSMENT → INCREMENTAL/FULL)

Ogni task: LIGHT / STANDARD / CRITICO
Chiusura: DEFINITION_OF_DONE · Maturity: FRAMEWORK_MATURITY (review trimestrale)
```

## Classificazione task

| Tier | Criteri | Framework |
|------|---------|-----------|
| **LIGHT** | < 2h, non critico | `2_EXECUTION` B + D |
| **STANDARD** | > 2h o modulo persistente | `1_DESIGN` 1–2 + `2_EXECUTION` |
| **CRITICO** | Security, prod, denaro | `1_DESIGN` + `2_EXECUTION` + `3_OPERATIONS` B/C + threat model |

## Artefatti trasversali

| Artefatto | Scopo |
|-----------|--------|
| [DISCOVERY_CHECKLIST.md](./DISCOVERY_CHECKLIST.md) | Pre-design · go/no-go |
| [DEFINITION_OF_DONE.md](./DEFINITION_OF_DONE.md) | DoD per tier |
| [DR_BACKUP_PLAN.md](./DR_BACKUP_PLAN.md) | RTO/RPO · restore drill |
| [FRAMEWORK_MATURITY.md](./FRAMEWORK_MATURITY.md) | Score adozione 0–5 |
| [security/THREAT_MODEL_TEMPLATE.md](./security/THREAT_MODEL_TEMPLATE.md) | STRIDE · tier CRITICO |

## Artefatti operativi

| Artefatto | Scopo |
|-----------|--------|
| [CHANGELOG.md](./CHANGELOG.md) | Storico modifiche |
| [ADR-000.md](./ADR-000.md) · [ADR-001.md](./ADR-001.md) | Decisioni architettura manuale |
| [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) | Debito tecnico live |
| [runbooks/](./runbooks/README.md) | Runbook incident |
| [AGENTS.md](./AGENTS.md) | Entry point Cursor/agent |

## Ultima revisione

**2026-07-24** — Artefatti trasversali: discovery, DoD, DR, maturity, threat model · Meta v1.5 · AI v1.5
