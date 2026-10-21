#!/bin/sh
# Add this checkout as a marketplace and install every plugin it lists, the
# way a fresh machine would: a throwaway Claude config, no git config, and no
# ssh, so a source that needs a GitHub key fails here.
set -eu

cd "$(dirname "$0")/.."

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

export CLAUDE_CONFIG_DIR="$tmp"
export GIT_SSH_COMMAND=/usr/bin/false
export GIT_CONFIG_GLOBAL=/dev/null
export GIT_CONFIG_NOSYSTEM=1
export GIT_TERMINAL_PROMPT=0

claude plugin marketplace add "$PWD"

ids=$(node -e '
const m = require("./.claude-plugin/marketplace.json");
for (const p of m.plugins) console.log(`${p.name}@${m.name}`);
')
for id in $ids; do
  claude plugin install "$id"
done
