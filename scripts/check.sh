#!/bin/sh
# Check the marketplace manifest. A push to main goes live on every machine
# that added this marketplace, so this runs on each commit and in CI.
set -eu

cd "$(dirname "$0")/.."

claude plugin validate --strict .

# A github source clones over ssh, so it fails on machines without a GitHub
# key. Every plugin has to be a url source with an https URL.
node - .claude-plugin/marketplace.json <<'EOF'
const fs = require('fs');
const manifest = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'));
let bad = 0;
for (const plugin of manifest.plugins ?? []) {
  const source = plugin.source;
  const ok = source !== null && typeof source === 'object' &&
    source.source === 'url' && /^https:\/\//.test(source.url ?? '');
  if (!ok) {
    console.error(`${plugin.name}: source must be {"source": "url", "url": "https://..."}, not ${JSON.stringify(source)}`);
    bad++;
  }
}
if (bad) process.exit(1);
console.log('All plugin sources are https urls');
EOF
