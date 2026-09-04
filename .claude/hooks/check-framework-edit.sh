#!/usr/bin/env bash
# Hook PostToolUse su Edit/Write — riduce il tempo-di-rilevazione del drift strutturale da
# "al prossimo push" a "subito dopo il salvataggio". Solo avviso, non blocco: l'edit è già
# avvenuto quando questo hook gira, non può essere annullato da qui.
# Vedi ADR-005.md, HOOKS_ENFORCEMENT_PLAN.md unità 2.

set -uo pipefail

INPUT=$(cat)
FILE=$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // .tool_response.filePath // empty' 2>/dev/null)

[ -z "$FILE" ] && exit 0

BASENAME=$(basename "$FILE")
case "$BASENAME" in
  *_FRAMEWORK.md) ;;
  *) exit 0 ;;
esac

FILE_DIR=$(dirname "$FILE")
REPO_ROOT=$(git -C "$FILE_DIR" rev-parse --show-toplevel 2>/dev/null)
[ -z "$REPO_ROOT" ] && exit 0
[ -f "$REPO_ROOT/scripts/check_consistency.sh" ] || exit 0

OUTPUT=$(cd "$REPO_ROOT" && bash scripts/check_consistency.sh 2>&1)
STATUS=$?

[ "$STATUS" -eq 0 ] && exit 0

MSG="check_consistency.sh ha trovato problemi dopo la modifica a $BASENAME (non bloccante, vedi output):
$OUTPUT"

jq -n --arg msg "$MSG" '{
  systemMessage: $msg,
  hookSpecificOutput: {
    hookEventName: "PostToolUse",
    additionalContext: $msg
  }
}'
exit 0
