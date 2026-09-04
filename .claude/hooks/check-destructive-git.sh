#!/usr/bin/env bash
# Hook PreToolUse su Bash — chiude l'incidente #4 (SELF_IMPROVEMENT_LOG.md): un comando git
# distruttivo eseguito senza verificare prima git status. Non blocca in modo assoluto: forza
# solo la richiesta di conferma (permissionDecision "ask") quando il working tree è sporco.
# Vedi ADR-005.md, HOOKS_ENFORCEMENT_PLAN.md unità 1.

set -uo pipefail

INPUT=$(cat)
COMMAND=$(printf '%s' "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

[ -z "$COMMAND" ] && exit 0

DESTRUCTIVE=0
if echo "$COMMAND" | grep -qE '(^|;|&&|\|\|)[[:space:]]*git[[:space:]]+checkout[[:space:]]+--([[:space:]]|$)'; then
  DESTRUCTIVE=1
elif echo "$COMMAND" | grep -qE '(^|;|&&|\|\|)[[:space:]]*git[[:space:]]+reset[[:space:]]+--hard\b'; then
  DESTRUCTIVE=1
elif echo "$COMMAND" | grep -qE '(^|;|&&|\|\|)[[:space:]]*git[[:space:]]+clean[[:space:]]+(-[a-zA-Z]*f[a-zA-Z]*|--force)'; then
  DESTRUCTIVE=1
elif echo "$COMMAND" | grep -qE '(^|;|&&|\|\|)[[:space:]]*git[[:space:]]+branch[[:space:]]+(-D|--delete[[:space:]]+--force)'; then
  DESTRUCTIVE=1
fi

[ "$DESTRUCTIVE" -eq 0 ] && exit 0

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  exit 0
fi

DIRTY=$(git status --porcelain 2>/dev/null)

[ -z "$DIRTY" ] && exit 0

REASON="Comando git potenzialmente distruttivo ('$COMMAND') con modifiche non committate nel working tree. Incidente #4 in SELF_IMPROVEMENT_LOG.md: uno stash o un commit prima di procedere evita di perdere lavoro. Confermi comunque?"

jq -n --arg reason "$REASON" '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "ask",
    permissionDecisionReason: $reason
  }
}'
exit 0
