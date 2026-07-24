# 🏛️ SYSTEM DESIGN & ARCHITECTURE FRAMEWORK
## Pipeline Standard per Valutazione, Hardening e Progettazione di Sistemi Software

**Documento**: Guida Framework Architetturale & Checklist di Progettazione  
**Alias canonico**: `1_DESIGN`  
**File**: `1_DESIGN_FRAMEWORK.md`  
**Utilizzo**: Applicabile a qualsiasi piano tecnico, refactor o migrazione infrastrutturale — a prescindere dal dominio  
**Versione**: 3.1  
**Ultima modifica**: 2026-07-24  
**Compatibile con**: `2_EXECUTION` v2.1, `3_OPERATIONS` v1.1, `0_META` v1.5, `4_AI_AGENT` v1.5, `5_BROWNFIELD` v1.0  

---

## 📋 I 9 PILASTRI DELL'ECCELLENZA INGEGNERISTICA

```
 1. PRE-MORTEM ANALYSIS              ──► Identificazione preventiva dei Single Points of Failure (SPOF)
 2. ADR (DECISION RECORDS)           ──► Tracciamento motivato dei Trade-Off e delle alternative scartate
 3. BLAST RADIUS ISOLATION           ──► Segmentazione dei domini di guasto per evitare crash a catena
 4. DATA LINEAGE & PROVENANCE        ──► Tracciabilità immutabile dal dato grezzo all'output finale
 5. IDEMPOTENCY & ZERO-SIDE-EFFECT   ──► Garanzia di riesecuzione sicura a tolleranza zero duplicati
 6. CHAOS & RESILIENCE TEST          ──► Iniezione di guasti, latenza e rumore per validare la robustezza
 7. CIRCUIT BREAKERS & OBSERVABILITY ──► Interruttori automatici di protezione e telemetria
 8. SECURITY & SECRETS               ──► Gestione segreti, superficie di attacco, minimo privilegio
 9. COST & CAPACITY MODEL            ──► Stima costi/risorse a scala, exit strategy dai vendor
```

**Severità default**: Pilastri 2, 7, 8 = **Bloccante** | Pilastri 1, 3, 4, 5, 6 = **Alta** | Pilastro 9 = **Media**

---

### 1. 🔍 PRE-MORTEM ANALYSIS
- **Severità default**: Alta
- **Obiettivo**: Ipotizzare che il progetto sia già in produzione e sia **fallito miseramente**. Lavorare a ritroso per trovare ogni vulnerabilità prima di scrivere codice.
- **Checklist**:
  - [ ] Qual è il peggior Single Point of Failure del sistema?
  - [ ] Cosa succede se una dipendenza esterna (API, servizio terzo, cloud) va offline per 24 ore?
  - [ ] Cosa succede con input corrotti, mancanti o fuori range?
  - [ ] Come si comporta il sistema se RAM/disco/CPU vengono saturati improvvisamente?
  - [ ] Soglia quantitativa: elencati **≥ 5 scenari di guasto** con impatto stimato (P1/P2/P3) e mitigazione proposta?

---

### 2. 📜 ADR — ARCHITECTURE DECISION RECORDS
- **Severità default**: Bloccante
- **Obiettivo**: Documentare formalmente il *perché* di ogni scelta tecnologica o architetturale rispetto alle alternative.
- **Checklist**:
  - [ ] Ogni decisione architetturale rilevante ha un ADR numerato?
  - [ ] Ogni ADR elenca **≥ 2 alternative scartate** con motivazione?
  - [ ] Soglia quantitativa: **100%** delle dipendenze critiche (SPOF potenziali) coperte da ADR prima del merge?
- **Formato**:
  - **Titolo**: [es. ADR-001: Scelta di Postgres su MongoDB per il modulo X]
  - **Contesto**: il problema da risolvere.
  - **Scelta effettuata**: tecnologia/pattern selezionato.
  - **Alternative scartate**: perché sono state rifiutate.
  - **Conseguenze e trade-off**: cosa si guadagna, cosa si perde.
- **Template copiabile**:

```markdown
# ADR-NNN: [Titolo breve]
**Stato**: Proposto | Accettato | Deprecato
**Data**: YYYY-MM-DD

## Contesto
[Problema da risolvere]

## Scelta effettuata
[Decisione presa]

## Alternative scartate
- [Alternativa A]: [motivo rifiuto]

## Conseguenze e trade-off
[Guadagni e costi]
```

---

### 3. 🛡️ BLAST RADIUS ISOLATION
- **Severità default**: Alta
- **Obiettivo**: Contenere il "raggio dell'esplosione" di un guasto. Un modulo secondario non deve mai abbattere il core.
- **Checklist**:
  - [ ] I moduli non-critici sono isolati dal core applicativo?
  - [ ] Se un servizio esterno va in errore, il sistema degrada con grazia (fallback/cache) invece di crashare?
  - [ ] Database e servizi critici sono su rete privata/segmentata, non esposti direttamente?
  - [ ] Ogni container/processo ha limiti di risorse e privilegi minimi?
  - [ ] Soglia quantitativa: guasto di un modulo non critico impatta **≤ 1 dominio funzionale** (nessun crash a catena sul core)?

---

### 4. 🔗 DATA LINEAGE & PROVENANCE
- **Severità default**: Alta
- **Obiettivo**: Ogni dato/output deve essere tracciabile a ritroso fino alla sorgente esatta.
- **Checklist**:
  - [ ] Ogni record salva provenienza (fonte, timestamp di ingestione, versione)?
  - [ ] Esistono checksum/hash per verificare l'integrità dei dataset?
  - [ ] Ogni elaborazione registra lo snapshot esatto di input e parametri usati?
  - [ ] Soglia quantitativa: **100%** dei dataset/output critici tracciabili a sorgente in **≤ 3 hop** (fonte → transform → output)?
  - [ ] Retention metadati di lineage **≥ 90 giorni** (o allineata alla policy dati del dominio)?

---

### 5. 🔄 IDEMPOTENCY & ZERO-SIDE-EFFECT PIPELINE
- **Severità default**: Alta
- **Obiettivo**: Eseguire un job 1 volta o 100 volte deve produrre esattamente lo stesso stato, senza duplicati.
- **Checklist qualitativa**:
  - [ ] Le operazioni di scrittura usano upsert/`ON CONFLICT` o pattern equivalenti?
  - [ ] Gli script di setup/migrazione sono ri-eseguibili all'infinito senza fallire?
  - [ ] Ogni endpoint/job mutante accetta una chiave di idempotenza (`Idempotency-Key`, `request_id`, o equivalente)?
  - [ ] I consumer di code/eventi usano deduplicazione con finestra ≥ **2×** il tempo massimo di processing?
- **Checklist quantitativa (soglie minime)**:
  - [ ] **≥ 95%** delle operazioni di scrittura con retry automatico sono idempotenti (upsert o idempotency key)?
  - [ ] **Re-run test**: eseguire setup/migration/job critico **3 volte** → stesso row count / stesso stato finale (delta = **0**)?
  - [ ] **Retry policy** documentata: max tentativi (**≤ 5**), backoff esponenziale, nessun side effect dopo successo parziale non rollbackabile?
  - [ ] **Webhook/API mutanti**: finestra dedup idempotency key **≥ 24h** (o ≥ TTL business del dominio)?
  - [ ] **Message queue**: dedup store conserva message ID per **≥ 7 giorni** su flussi finanziari o irreversibili?
  - [ ] **Test automatizzato**: almeno 1 test per modulo core che invoca la stessa operazione 2× e verifica assenza duplicati?

**Exit criteria Pilastro 5**: tutte le voci qualitative rilevanti + almeno **4/6** soglie quantitative soddisfatte (le restanti con debito in [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md)).

---

### 6. 🧪 CHAOS & RESILIENCE TESTING
- **Severità default**: Alta
- **Obiettivo**: Testare la resilienza sottoponendo il sistema a condizioni estreme artificiali.
- **Checklist**:
  - [ ] Come risponde il sistema con latenza di rete artificialmente aumentata?
  - [ ] Il sistema resta corretto se un servizio dipendente restituisce errori/timeout casuali?
  - [ ] Il sistema tollera dati mancanti o malformati senza eccezioni non gestite?
  - [ ] Soglia quantitativa: error rate **< 2%** sotto guasto simulato su dipendenza non critica?
  - [ ] Soglia quantitativa: latenza p95 degrada **< 3×** baseline sotto fault injection, senza errori 5xx sul core?

---

### 7. ⚡ CIRCUIT BREAKERS & OBSERVABILITY
- **Severità default**: Bloccante
- **Obiettivo**: Rilevare anomalie istantaneamente e bloccare operazioni a rischio automaticamente.
- **Checklist**:
  - [ ] Esiste un interruttore automatico che blocca operazioni quando una soglia di rischio è superata?
  - [ ] Esistono heartbeat/healthcheck che notificano interruzioni (Discord/Telegram/email)?
  - [ ] Il sistema esporta metriche in tempo reale (Prometheus/Grafana/Netdata/Uptime Kuma)?
  - [ ] Soglia quantitativa: alert su error rate **> 1%** per **≥ 5 minuti** consecutivi su endpoint core?
  - [ ] Soglia quantitativa: time-to-detect (TTD) obiettivo **≤ 5 minuti** per guasti P1?

---

### 8. 🔐 SECURITY & SECRETS MANAGEMENT
- **Severità default**: Bloccante
- **Obiettivo**: Nessun segreto deve esistere in chiaro nel codice, nei log o nei backup non cifrati.
- **Checklist**:
  - [ ] I secrets sono in un vault (Doppler, Vault, .env cifrato) e mai committati in Git?
  - [ ] Ogni credenziale ha permessi minimi necessari (principio del minimo privilegio)?
  - [ ] I log mascherano automaticamente pattern simili a chiavi/token?
  - [ ] Esiste un piano di rotazione credenziali in caso di leak sospetto?
  - [ ] Gli esempi nel codice e nella documentazione non contengono dati sensibili reali?
  - [ ] Soglia quantitativa: scan secrets su CI con **0 leak** bloccanti; dipendenze con CVE **Critical/High** = **0** non mitigate?
  - [ ] Tier **CRITICO**: [threat model](./security/THREAT_MODEL_TEMPLATE.md) compilato e approvato?

---

### 9. 💰 COST & CAPACITY MODEL
- **Severità default**: Media
- **Obiettivo**: Evitare sorprese di costo o saturazione risorse quando il sistema scala.
- **Checklist**:
  - [ ] È stato stimato il costo a 10x/100x il volume attuale (storage, compute, egress)?
  - [ ] Esiste una exit strategy se il vendor cloud cambia pricing o chiude il tier free?
  - [ ] È definito un limite di crescita prima che serva un redesign strutturale?
  - [ ] Soglia quantitativa: costo mensile stimato documentato per scenario **10×** volume (€/$ o ore compute)?
  - [ ] Soglia quantitativa: headroom capacità **≥ 30%** su CPU/RAM/storage al carico target 10×?

---

## 📚 DATA PROVENANCE DEI PILASTRI (origine del manuale)

Tracciabilità di *perché* ogni pilastro esiste nel manuale — richiesto dal Pilastro 4 applicato al manuale stesso (`0_META` Area C).

| Pilastro | Fonte primaria | Riferimenti / pattern | Validazione nel manuale |
|----------|----------------|----------------------|-------------------------|
| **1 Pre-Mortem** | Esperienza operativa + cultura postmortem | Google SRE Book (postmortem), Amazon "working backwards" | Trigger revisione trimestrale in `0_META` |
| **2 ADR** | Best practice industry | Michael Nygard — ADR format; ThoughtWorks Technology Radar | [ADR-000.md](./ADR-000.md) |
| **3 Blast Radius** | Resilienza distribuita | Netflix chaos principles; bulkhead pattern (Release It!, Nygard) | Tier CRITICO obbligatorio in `0_META` |
| **4 Data Lineage** | Data engineering + compliance | W3C PROV; GDPR art. 5(2) accountability; OpenLineage | Tabella sopra + sezione Pilastro 4 |
| **5 Idempotency** | Esperienza diretta su retry/queue | Stripe Idempotency-Key; exactly-once semantics (Kafka docs); HTTP Idempotency | Checklist quantitativa Pilastro 5 |
| **6 Chaos Test** | SRE / resilienza | Netflix Chaos Monkey; Gremlin; principio "fail in prod first in staging" | Tier LIGHT con non-negoziabilità CRITICO |
| **7 Circuit Breakers** | Microservices patterns | Michael Nygard — Circuit Breaker; OpenTelemetry; Prometheus alerting | Collegamento `3_OPERATIONS` Area B |
| **8 Security** | OWASP + incident response | OWASP Top 10; CIS Benchmarks; NIST secret management | Escalation trigger in `4_AI_AGENT` |
| **9 Cost Model** | FinOps + capacity planning | AWS Well-Architected (Cost Optimization pillar); FinOps Foundation | Versione LIGHT per ridurre costo di adozione |

**Provenance del manuale nel complesso**: sintesi di best practice industry (SRE, ADR, OWASP, FinOps) adattata a progetti one-person e workflow AI-assisted. Revisione provenance: ad ogni self-audit trimestrale (`0_META` Area C).

---

## 🔧 Note d'Uso

- Ogni checklist item dovrebbe avere **Severità** (Bloccante/Alta/Media) e **Owner** assegnato.
- Le domande booleane vanno accompagnate, dove possibile, da una **soglia quantitativa** (vedi Pilastri 1–9).
- Le decisioni prese qui (ADR) alimentano la **Fase F (Post-Mortem Reale)** di `2_EXECUTION` e [TECHNICAL_DEBT_LEDGER.md](./TECHNICAL_DEBT_LEDGER.md) (`3_OPERATIONS` Area C).
- **Idempotency del manuale**: applicare lo stesso tier (LIGHT/STANDARD/CRITICO) allo stesso tipo di task deve produrre la stessa profondità di checklist — mitigato da tier espliciti in `0_META` / `4_AI_AGENT`.

## 📌 Come Usare questo Documento

1. Apri questo documento prima di iniziare l'esecuzione di qualsiasi nuovo piano.
2. Scorri i 9 Pilastri e compila le checklist (qualitative + quantitative dove presenti).
3. **Exit criteria**: passa a `2_EXECUTION` solo quando tutti i pilastri **Bloccanti** (2, 7, 8) e i pilastri **Alta** rilevanti per il task rispondono positivamente.
4. Per task **LIGHT** o **STANDARD**, vedi tier in `0_META` / `4_AI_AGENT`.
5. Su **codebase esistente**, inizia da `5_BROWNFIELD` Area A prima di refactor o rewrite.
