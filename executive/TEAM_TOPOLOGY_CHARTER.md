# 🏗️ Team Topology Charter

**Artefatto executive** · Area E · [6_STRATEGY](../6_STRATEGY_FRAMEWORK.md)  
**Priorità adozione**: **P1**  
**Versione**: 1.0  
**Ultima modifica**: 2026-07-24  
**Owner**: _________________ · **Prossima review**: _________________

---

## 🎯 Obiettivo

Documentare come i team sono organizzati (platform vs product, stream-aligned), applicare **Conway's Law** consapevolmente e assegnare **DRI** (Directly Responsible Individual) per ogni servizio in produzione.

---

## 🧩 Modello topology (Team Topologies)

| Tipo team | Missione | Esempi | Interazione |
|-----------|----------|--------|-------------|
| **Stream-aligned** | Delivery end-to-end per flusso utente/business | Checkout squad · Billing squad | X-as-a-Service da platform |
| **Platform** | Abilitatori · golden paths · infra condivisa | K8s · CI/CD · observability | X-as-a-Service · partnership |
| **Enabling** | Trasferimento competenza temporaneo | Security champions · FinOps coach | Facilitating · time-boxed |
| **Complicated-subsystem** | Domini specialistici | ML pipeline · realtime engine | X-as-a-Service |

- **Checklist charter**:
  - [ ] Ogni servizio prod mappato a **1** team stream-aligned owner?
  - [ ] Platform espone SLA interni (es. deploy < 30 min · dashboard < 5 min setup)?
  - [ ] Enabling team con **exit date** (non permanente)?
  - [ ] Conway esplicito: architettura moduli ↔ confini team documentati?

---

## 📐 Conway's Law — applicazione consapevole

> *"Le organizzazioni progettano sistemi che replicano la struttura comunicativa dell'organizzazione."*

| Scelta org | Effetto architettura atteso | Mitigazione se indesiderato |
|------------|----------------------------|----------------------------|
| 3 team frontend separati | 3 BFF / API duplicate | Platform API · design system condiviso |
| Monolite team unico | Monolite deploy | Accettabile fino a N engineer (soglia **~8**) |
| Platform sottodimensionata | Shadow IT · drift infra | Investimento platform in [TECH_PRODUCT_ROADMAP](./TECH_PRODUCT_ROADMAP.md) Now |

**Soglia**: team stream-aligned **> 10** persone → valutare split per sottodominio (ADR obbligatorio).

---

## 👤 DRI per servizio

| Servizio | DRI | Team | On-call | Runbook | ADR architettura |
|----------|-----|------|---------|---------|------------------|
| api-core | | | Sì/No | [runbooks/](../runbooks/README.md) | ADR-xxx |
| worker-jobs | | | | | |

**Regola DRI**: una sola persona accountable per incident P1 fino a handoff · non un "team generico".

- **Checklist DRI**:
  - [ ] **100%** servizi tier CRITICO con DRI + backup DRI?
  - [ ] DRI partecipa ad ARB per change architetturali sul servizio?
  - [ ] Rotazione on-call documentata in [3_OPERATIONS](../3_OPERATIONS_FRAMEWORK.md)?

---

## 🔗 Collegamenti

| Documento | Relazione |
|-----------|-----------|
| [ARB_PROCESS.md](./ARB_PROCESS.md) | Gate decisioni cross-team |
| [TECH_PRODUCT_ROADMAP.md](./TECH_PRODUCT_ROADMAP.md) | Capacity per team |
| [1_DESIGN](../1_DESIGN_FRAMEWORK.md) | Blast radius ↔ confini team |
| [2_EXECUTION](../2_EXECUTION_FRAMEWORK.md) | Ownership merge/deploy |
| [3_OPERATIONS](../3_OPERATIONS_FRAMEWORK.md) | On-call · SLO |
| [5_BROWNFIELD](../5_BROWNFIELD_FRAMEWORK.md) | Legacy ownership |
| [0_META](../0_META_FRAMEWORK.md) | RACI manuale |

---

## 📌 Review

- Charter review **semestrale** o dopo riorganizzazione
- Nuovo servizio prod → DRI assegnato entro **5 giorni** lavorativi dal go-live
