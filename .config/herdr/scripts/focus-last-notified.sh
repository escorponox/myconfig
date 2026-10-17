#!/bin/sh
# Focus the agent that most recently asked for attention (blocked or done),
# even after its notification toast has expired.
#
# state_change_seq is a server-wide counter, so the highest value among
# blocked/done agents is the latest one to change into those states.
# Focusing an agent marks it seen (done -> idle), so pressing the key again
# moves on to the next most recent one.

herdr="${HERDR_BIN_PATH:-herdr}"

target=$("$herdr" agent list | jq -r '
  .result.agents
  | map(select(.agent_status == "blocked" or .agent_status == "done"))
  | map(select(.focused | not))
  | sort_by(.state_change_seq)
  | last
  | .pane_id // empty
')

if [ -z "$target" ]; then
  "$herdr" notification show "No agents waiting" >/dev/null
  exit 0
fi

"$herdr" agent focus "$target" >/dev/null
