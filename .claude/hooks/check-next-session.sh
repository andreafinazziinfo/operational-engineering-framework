#!/usr/bin/env bash
# Hook SessionStart — reminder se NEXT_SESSION.md manca o è più vecchio di 14 giorni.
# Soft reminder, non blocca l'inizio sessione. Fires una sola volta per sessione per natura
# dell'evento SessionStart (Idempotency, 1_DESIGN Pilastro 5 — nessuna logica extra necessaria).
# Vedi ADR-005.md, HOOKS_ENFORCEMENT_PLAN.md unità 3.

set -uo pipefail
cat >/dev/null  # drain stdin, non ci serve il payload dell'evento

FILE="NEXT_SESSION.md"
THRESHOLD_DAYS=14

if [ ! -f "$FILE" ]; then
  exit 0
fi

LAST_DATE=$(grep -oE 'Ultima sessione\*\*: [0-9]{4}-[0-9]{2}-[0-9]{2}' "$FILE" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' | head -1)
[ -z "$LAST_DATE" ] && exit 0

LAST_EPOCH=$(date -d "$LAST_DATE" +%s 2>/dev/null)
[ -z "$LAST_EPOCH" ] && exit 0
NOW_EPOCH=$(date +%s)
DAYS=$(( (NOW_EPOCH - LAST_EPOCH) / 86400 ))

[ "$DAYS" -le "$THRESHOLD_DAYS" ] && exit 0

MSG="NEXT_SESSION.md non aggiornato da $DAYS giorni (soglia: $THRESHOLD_DAYS, ultima sessione: $LAST_DATE) — leggilo prima di iniziare (7_COLLABORATION Area A)."

jq -n --arg msg "$MSG" '{systemMessage: $msg}'
exit 0
