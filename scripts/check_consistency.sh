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
BROKEN_LINKS=0
while IFS= read -r -d '' f; do
  d=$(dirname "$f")
  while IFS= read -r link; do
    [ -z "$link" ] && continue
    target=$(python3 -c "import os,sys; print(os.path.normpath(os.path.join('$d', '$link')))" 2>/dev/null)
    if [ ! -e "$target" ]; then
      echo "BROKEN: $f -> $link"
      BROKEN_LINKS=$((BROKEN_LINKS + 1))
    fi
  done < <(grep -oE '\]\(\.[^)]+\)' "$f" 2>/dev/null | sed -E 's/^\]\((.*)\)$/\1/' | sed 's/#.*//' | sort -u)
done < <(find . -name "*.md" -not -path "./.git/*" -print0)

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
EXPECTED_ARTIFACTS="SPEC_TEMPLATE.md POST_MORTEM_TEMPLATE.md BENCHMARK.md SELF_IMPROVEMENT_LOG.md NEXT_SESSION.md TECHNICAL_DEBT_LEDGER.md DEFINITION_OF_DONE.md DISCOVERY_CHECKLIST.md FAQ.md"

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
if [ "$FAIL" -eq 0 ]; then
  echo "=== RISULTATO: pulito ==="
else
  echo "=== RISULTATO: problemi trovati — vedi sopra ==="
fi
exit $FAIL
