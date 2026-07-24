# 🛰️ OPERATIONS & EVOLUTION FRAMEWORK
## Cosa Succede Dopo il Rilascio: Mantenere, Monitorare e Far Evolvere il Sistema

**Documento**: Guida operativa per la fase di vita successiva al primo deploy  
**Alias canonico**: `3_OPERATIONS`  
**File**: `3_OPERATIONS_FRAMEWORK.md`  
**Prerequisito**: Il sistema è già in produzione secondo `2_EXECUTION`  
**Versione**: 1.1  
**Ultima modifica**: 2026-07-24  
**Compatibile con**: `1_DESIGN` v3.1, `2_EXECUTION` v2.1, `0_META` v1.5, `4_AI_AGENT` v1.5, `5_BROWNFIELD` v1.0  

---

## 📋 LE 5 AREE DI OPERATIVITÀ CONTINUA

```
 A. INCIDENT RESPONSE     ──► Cosa fare quando qualcosa si rompe davvero, in tempo reale
 B. MONITORING & SLO      ──► Metriche continue e soglie di servizio da rispettare
 C. TECHNICAL DEBT LEDGER ──► Tracciamento esplicito dei compromessi presi "per ora"
 D. CHANGE MANAGEMENT     ──► Come si gestiscono modifiche future senza rompere l'esistente
 E. DEPRECATION & SUNSET  ──► Come si ritira in sicurezza un componente o l'intero sistema
```

**Nota tier CRITICO** (`0_META` / `4_AI_AGENT`): per nuovi task critici pre-deploy, attivare **Area B + C**. **Area A** solo durante un incidente attivo.

**SLA vs SLO**: gli **SLO** sono obiettivi interni misurabili (es. p95 latenza); gli **SLA** sono impegni verso utenti/clienti esterni — possono essere più restrittivi degli SLO.

---

### A. 🚨 INCIDENT RESPONSE
- **Obiettivo**: Reagire a un guasto reale in modo strutturato, non improvvisato.
- **Checklist**:
  - [ ] Esistono runbook per i **3–5 scenari** di guasto più probabili? → [runbooks/](./runbooks/README.md)
  - [ ] [DR_BACKUP_PLAN.md](./DR_BACKUP_PLAN.md) compilato con RTO/RPO · restore drill ≤ **90 giorni**?
  - [ ] È chiaro chi ha l'autorità di decidere uno stop/rollback in emergenza?
  - [ ] Ogni incidente produce un report scritto (cosa è successo, impatto, causa, fix)?
  - [ ] Il tempo di rilevamento (TTD) e di risoluzione (TTR) vengono misurati?
  - [ ] Soglia quantitativa TTD P1: **≤ 5 minuti** · TTR P1 target: **≤ 4 ore** (mitigazione entro **≤ 15 min**)

**Runbook disponibili**: vedi [runbooks/README.md](./runbooks/README.md) — personalizza placeholder per il tuo stack.

---

### B. 📊 MONITORING & SLO (Service Level Objectives)
- **Obiettivo**: Sapere se il sistema sta funzionando bene senza dover controllare manualmente.
- **Collegamento**: implementa l'osservabilità definita in `1_DESIGN` Pilastro 7 (Circuit Breakers & Observability).
- **Checklist**:
  - [ ] Sono definiti SLO espliciti (es. uptime 99.5%, latenza p95 < 200ms)?
  - [ ] Esistono dashboard consultabili in tempo reale (Grafana/Netdata/equivalenti)?
  - [ ] Gli alert sono calibrati per evitare sia il rumore eccessivo sia i falsi negativi?
  - [ ] Le metriche storiche vengono conservate per analisi di trend a lungo termine?
  - [ ] Se esistono SLA esterni, gli SLO interni sono sufficienti a rispettarli con margine?
  - [ ] Soglia quantitativa: retention metriche **≥ 90 giorni** · alert noise **< 3 falsi positivi/settimana** per canale P1

---

### C. 📒 TECHNICAL DEBT LEDGER
- **Obiettivo**: Ogni scorciatoia presa sotto pressione temporale deve essere visibile, non dimenticata.
- **Registro live**: [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md)
- **Checklist**:
  - [ ] Esiste un registro esplicito separato dai normali task, con impatto stimato?
  - [ ] Ogni voce di debito tecnico ha una data di revisione o una condizione di trigger?
  - [ ] Il debito tecnico viene rivisto periodicamente — **ogni 30 giorni** o a inizio sprint?
  - [ ] Voci da soglie idempotency non soddisfatte (`1_DESIGN` Pilastro 5, exit 4/6) registrate con trigger?
  - [ ] Soglia quantitativa: **0 voci Alto impatto** oltre **30 giorni** senza piano (allineato a circuit breaker `0_META`)?

Gli agenti AI che prendono scorciatoie devono aggiungere una riga in [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) (`4_AI_AGENT` Sezione D).

---

### D. 🔄 CHANGE MANAGEMENT
- **Obiettivo**: Introdurre modifiche future senza ripetere da zero l'intero processo di design.
- **Checklist**:
  - [ ] Le modifiche su codebase **esistente** passano da `5_BROWNFIELD` (baseline + area pertinente)?
  - [ ] Le modifiche minori su modulo già baselined passano solo da `2_EXECUTION`?
  - [ ] Le modifiche che alterano un Pilastro architetturale di `1_DESIGN` tornano a `1_DESIGN`?
  - [ ] Esiste un log delle versioni/modifiche architetturali nel tempo? → `CHANGELOG.md` + ADR aggiornate
  - [ ] Soglia quantitativa: change che tocca **> 3 moduli** o nuova dipendenza esterna → tier almeno **STANDARD**

---

### E. 🌅 DEPRECATION & SUNSET
- **Obiettivo**: Ritirare un componente o un intero sistema senza causare danni collaterali.
- **Checklist**:
  - [ ] È stato comunicato un periodo di preavviso a chi dipende dal componente?
  - [ ] Esiste un piano di migrazione dei dati/utenti verso il sostituto?
  - [ ] Il rollback dello spegnimento è possibile fino a una data limite definita?
  - [ ] I dati storici vengono archiviati secondo policy di retention prima dello spegnimento definitivo?
  - [ ] Soglia quantitativa: preavviso minimo **≥ 30 giorni** (API pubbliche) / **≥ 90 giorni** (breaking major)?

---

## 📚 DATA PROVENANCE DELLE AREE (origine del manuale)

| Area | Fonte primaria | Riferimenti / pattern | Validazione nel manuale |
|------|----------------|----------------------|-------------------------|
| **A Incident Response** | SRE on-call | Google SRE (incident management); PagerDuty/IR frameworks | [runbooks/](./runbooks/README.md) |
| **B Monitoring & SLO** | SRE observability | Google SRE Ch. 4–6; RED/USE methods; OpenTelemetry | Pilastro 7 `1_DESIGN` |
| **C Technical Debt Ledger** | Gestione debito esplicita | Ward Cunningham; Martin Fowler TD quadrant | [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) |
| **D Change Management** | ITIL / continuous delivery | DORA change failure rate; tier routing `0_META` | CHANGELOG + ADR |
| **E Deprecation & Sunset** | API lifecycle | Stripe API versioning; Google cloud deprecation policy | Preavviso quantitativo sopra |

**Revisione provenance**: self-audit trimestrale (`0_META` Area C).
