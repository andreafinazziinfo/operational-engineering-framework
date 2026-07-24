# 💰 FinOps & Budget

**Artefatto executive** · Area D · [6_STRATEGY](../6_STRATEGY_FRAMEWORK.md)  
**Priorità adozione**: **P0**  
**Versione**: 1.0  
**Ultima modifica**: 2026-07-24  
**Owner FinOps**: _________________ · **Budget anno**: _________________

---

## 🎯 Obiettivo

Governare spend cloud e infrastruttura: budget annuale/mensile, alert burn rate, chargeback/showback e template TCO per servizi revenue-bearing o tier CRITICO.

---

## 📊 Budget e burn rate

| Periodo | Budget | Spent MTD | % utilizzo | Forecast EOM | Stato |
|---------|--------|-----------|:----------:|--------------|-------|
| Gen 2026 | | | | | 🟢/🟡/🔴 |
| … | | | | | |

**Soglie alert** (configurare su billing tool / Prometheus / cloud native):

| Livello | Soglia | Azione |
|---------|--------|--------|
| 🟢 OK | < 80% budget mensile | Nessuna |
| 🟡 Warning | **≥ 80%** | Notifica owner FinOps + eng lead |
| 🔴 Critical | **≥ 95%** | Freeze nuove risorse · review entro **48h** |
| 🚨 Overrun | > 100% | Escalation CFO · voce [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md) |

- **Checklist mensile**:
  - [ ] Forecast EOM entro **± 10%** del budget?
  - [ ] Anomalie spike > **20%** WoW investigate?
  - [ ] Idle resources > **$X**/mese identificati e pianificati?
  - [ ] Allineamento a [1_DESIGN](../1_DESIGN_FRAMEWORK.md) Pilastro 9 (cost model)?

---

## 🏷️ Chargeback / Showback

| Team / Prodotto | Cost center | Allocazione | % spend mese | Owner |
|-----------------|-------------|-------------|:------------:|-------|
| Platform | | Shared infra | | |
| Product A | | Direct + allocated | | |

**Regola default**: showback mensile · chargeback trimestrale se maturity [FRAMEWORK_MATURITY](../FRAMEWORK_MATURITY.md) **≥ 3**.

**Driver allocazione**: CPU-hours · storage GB · egress · requests · flat % per shared services.

---

## 📐 Template TCO (per servizio)

Compilare per ogni servizio **CRITICO** o con revenue diretto:

| Voce | Mese 1 | Mese 12 | Anno 1 | Note |
|------|--------|---------|--------|------|
| Compute | | | | |
| Storage | | | | |
| Egress / CDN | | | | |
| Managed DB | | | | |
| SaaS / API third-party | | | | |
| Engineering (amortized) | | | | opzionale |
| **Totale** | | | | |

**Unit economics** (se applicabile):

```
Cost per active user = Totale mese / MAU
Cost per transaction = Totale mese / transazioni
Gross margin impact = (Revenue − Infra COGS) / Revenue
```

**Soglia review**: gross margin impact infra **< −5pp** QoQ → item roadmap FinOps in [TECH_PRODUCT_ROADMAP.md](./TECH_PRODUCT_ROADMAP.md).

---

## 🔗 Collegamenti

| Documento | Relazione |
|-----------|-----------|
| [TECH_PRODUCT_ROADMAP.md](./TECH_PRODUCT_ROADMAP.md) | Init infra in Now |
| [ENTERPRISE_RISK_REGISTER.md](./ENTERPRISE_RISK_REGISTER.md) | Overrun · vendor lock-in |
| [1_DESIGN](../1_DESIGN_FRAMEWORK.md) | Pilastro 9 · capacity |
| [3_OPERATIONS](../3_OPERATIONS_FRAMEWORK.md) | Right-sizing · saturation |
| [PORTFOLIO_PRIORITIZATION.md](./PORTFOLIO_PRIORITIZATION.md) | Effort vs cost saving |
| [0_META](../0_META_FRAMEWORK.md) | Tier CRITICO · dati finanziari |

---

## 📌 Best practice

- Tag obbligatori: `env`, `team`, `product`, `cost-center`
- Reserved capacity / savings plan review **semestrale**
- Nessun segreto billing in repo — riferimenti a vault/account ID anonimizzati
