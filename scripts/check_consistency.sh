#!/usr/bin/env bash
# Verifica meccanica del manuale — link relativi rotti + versioni "Compatibile con" disallineate.
#
# Perché esiste: il self-audit 2026-07-24 aveva dichiarato "✅ Eseguito" un fix di link mai
# applicato, scoperto 6 settimane dopo per caso (vedi SELF_AUDIT_2026-07-24.md addendum,
# BENCHMARK.md dimensione 4). Un self-audit auto-dichiarato non è verifica: questo script lo è.
#
# Uso: ./scripts/check_consistency.sh   (dalla root del repo, o da qualsiasi punto)
# Exit code: 0 = tutto pulito, 1 = trovati problemi (lista su stdout)

set -uo pipefail
cd "$(dirname "$0")/.." || exit 2
FAIL=0

echo "=== 1. Link relativi rotti ==="
# Un solo processo python3 in batch invece di uno per link (~615 link nel repo):
# la versione precedente spawnava un subprocess per link, ~19s totali su questa
# macchina — abbastanza da far scadere il timeout dell'hook PostToolUse
# check-framework-edit.sh (HOOKS_ENFORCEMENT_PLAN.md unità 2, scoperto testando
# l'hook dal vivo, non ipotetico). Stesso comportamento, ordini di grandezza più veloce.
BROKEN_LINKS=0
PAIRS_FILE=$(mktemp)
while IFS= read -r -d '' f; do
  d=$(dirname "$f")
  while IFS= read -r link; do
    [ -z "$link" ] && continue
    printf '%s\t%s\t%s\n' "$f" "$d" "$link" >> "$PAIRS_FILE"
  done < <(grep -oE '\]\(\.[^)]+\)' "$f" 2>/dev/null | sed -E 's/^\]\((.*)\)$/\1/' | sed 's/#.*//' | sort -u)
done < <(find . -name "*.md" -not -path "./.git/*" -print0)

if [ -s "$PAIRS_FILE" ]; then
  while IFS=$'\t' read -r broken_f broken_link; do
    echo "BROKEN: $broken_f -> $broken_link"
    BROKEN_LINKS=$((BROKEN_LINKS + 1))
  done < <(python3 -c "
import os, sys
for line in sys.stdin:
    line = line.rstrip('\n')
    if not line:
        continue
    f, d, link = line.split('\t')
    target = os.path.normpath(os.path.join(d, link))
    if not os.path.exists(target):
        print(f + '\t' + link)
" < "$PAIRS_FILE")
fi
rm -f "$PAIRS_FILE"

if [ "$BROKEN_LINKS" -eq 0 ]; then
  echo "OK — 0 link rotti"
else
  echo "TROVATI $BROKEN_LINKS link rotti"
  FAIL=1
fi

echo ""
echo "=== 2. Coerenza versioni (\"Compatibile con\") ==="

# File numerati con header Versione/Compatibile con
FRAMEWORK_FILES="0_META_FRAMEWORK.md 1_DESIGN_FRAMEWORK.md 2_EXECUTION_FRAMEWORK.md 3_OPERATIONS_FRAMEWORK.md 4_AI_AGENT_FRAMEWORK.md 5_BROWNFIELD_FRAMEWORK.md 6_STRATEGY_FRAMEWORK.md 7_COLLABORATION_FRAMEWORK.md"

declare -A REAL_VERSION
for f in $FRAMEWORK_FILES; do
  [ -f "$f" ] || continue
  alias=$(echo "$f" | sed 's/_FRAMEWORK\.md$//')
  v=$(grep -m1 '^\*\*Versione\*\*' "$f" | grep -oE '[0-9]+\.[0-9]+')
  REAL_VERSION["$alias"]="$v"
done

MISMATCH=0
for f in $FRAMEWORK_FILES; do
  [ -f "$f" ] || continue
  compat_line=$(grep -m1 '^\*\*Compatibile con\*\*' "$f")
  for alias in "${!REAL_VERSION[@]}"; do
    real="${REAL_VERSION[$alias]}"
    # cerca riferimenti tipo `ALIAS` vX.Y nella riga Compatibile con di $f
    claimed=$(echo "$compat_line" | grep -oE "\`${alias}\` v[0-9]+\.[0-9]+" | grep -oE '[0-9]+\.[0-9]+' | head -1)
    if [ -n "$claimed" ] && [ "$claimed" != "$real" ]; then
      echo "STALE: $f dichiara $alias v$claimed, ma $alias è a v$real"
      MISMATCH=$((MISMATCH + 1))
    fi
  done
done

if [ "$MISMATCH" -eq 0 ]; then
  echo "OK — versioni coerenti su tutti gli 8 file"
else
  echo "TROVATE $MISMATCH dichiarazioni di versione disallineate"
  FAIL=1
fi

echo ""
echo "=== 3. Copertura skill canonica (.claude/skills/operational-engineering-framework/SKILL.md) ==="

SKILL_FILE=".claude/skills/operational-engineering-framework/SKILL.md"
# Artefatti trasversali che la skill deve conoscere per pianificare/eseguire un task.
# Non ogni file .md del repo (CHANGELOG, LICENSE, ADR storiche non servono qui) — solo
# quelli che uno svolgimento reale di un task dovrebbe usare o aggiornare.
EXPECTED_ARTIFACTS="SPEC_TEMPLATE.md POST_MORTEM_TEMPLATE.md BENCHMARK.md SELF_IMPROVEMENT_LOG.md NEXT_SESSION.md TECHNICAL_DEBT_LEDGER.md DEFINITION_OF_DONE.md DISCOVERY_CHECKLIST.md FAQ.md ADOPTION_GUIDE.md"

MISSING_FROM_SKILL=0
if [ -f "$SKILL_FILE" ]; then
  for artifact in $EXPECTED_ARTIFACTS; do
    if ! grep -q "$artifact" "$SKILL_FILE"; then
      echo "MISSING dalla skill: $artifact non referenziato in $SKILL_FILE"
      MISSING_FROM_SKILL=$((MISSING_FROM_SKILL + 1))
    fi
  done
  if [ "$MISSING_FROM_SKILL" -eq 0 ]; then
    echo "OK — skill referenzia tutti gli artefatti trasversali attesi"
  else
    echo "TROVATI $MISSING_FROM_SKILL artefatti non referenziati nella skill"
    FAIL=1
  fi
else
  echo "SKIP — $SKILL_FILE non trovato"
fi

echo ""
echo "=== 4. Staleness SELF_IMPROVEMENT_LOG.md (solo se INCLUDE_STALENESS_CHECK=1) ==="

# Circuit breaker per il loop di auto-miglioramento (ADR-005, gap #9 in SELF_IMPROVEMENT_LOG.md):
# check_consistency.sh verifica coerenza strutturale, non se il loop di logging è ancora vivo.
# Disattivato di default per non cambiare il comportamento del job push/pull_request esistente —
# attivato solo dal job CI schedulato settimanale (o manualmente per test).
if [ "${INCLUDE_STALENESS_CHECK:-0}" = "1" ]; then
  LOG_FILE="SELF_IMPROVEMENT_LOG.md"
  STALENESS_THRESHOLD_DAYS=30
  if [ -f "$LOG_FILE" ]; then
    LAST_DATE=$(grep -oE '^### [0-9]{4}-[0-9]{2}-[0-9]{2}' "$LOG_FILE" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' | sort -u | tail -1)
    if [ -z "$LAST_DATE" ]; then
      echo "TROVATO: nessuna data di voce riconosciuta in $LOG_FILE"
      FAIL=1
    else
      LAST_EPOCH=$(date -d "$LAST_DATE" +%s 2>/dev/null)
      NOW_EPOCH=$(date +%s)
      DAYS_SINCE=$(( (NOW_EPOCH - LAST_EPOCH) / 86400 ))
      if [ "$DAYS_SINCE" -gt "$STALENESS_THRESHOLD_DAYS" ]; then
        echo "STALE: ultima voce in $LOG_FILE è del $LAST_DATE, $DAYS_SINCE giorni fa (soglia: $STALENESS_THRESHOLD_DAYS)"
        FAIL=1
      else
        echo "OK — ultima voce $LAST_DATE, $DAYS_SINCE giorni fa (soglia: $STALENESS_THRESHOLD_DAYS)"
      fi
    fi
  else
    echo "SKIP — $LOG_FILE non trovato"
  fi
else
  echo "SKIP — check disattivato di default (attivo solo nel job CI schedulato settimanale)"
fi

echo ""
if [ "$FAIL" -eq 0 ]; then
  echo "=== RISULTATO: pulito ==="
else
  echo "=== RISULTATO: problemi trovati — vedi sopra ==="
fi
exit $FAIL
