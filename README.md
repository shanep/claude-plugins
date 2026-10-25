# Claude Plugins

A Claude Code marketplace for my plugins. Each plugin lives in its own repo
and this one just lists them, so you only need to add one marketplace.

## Install

```
claude plugin marketplace add shanep/claude-plugins
claude plugin install boisestate@shanep
claude plugin install tune@shanep
claude plugin install krascha@shanep
claude plugin install drboom@shanep
claude plugin install workflow@shanep
```

## Plugins

- boisestate - Run Claude Code on boisestate.ai ([shanep/boisestate.ai](https://github.com/shanep/boisestate.ai))
- tune - Find where your sessions spend tokens ([shanep/claude-tune](https://github.com/shanep/claude-tune))
- krascha - Find out who the machines hunt first ([shanep/krascha](https://github.com/shanep/krascha))
- drboom - Dr. BOOM's Claude Code setup: names, a status line, a stats band, a spinner and sound profiles ([shanep/claude-DrBOOM](https://github.com/shanep/claude-DrBOOM))
- workflow - Keep parallel sessions in one repo out of each other's files ([shanep/claude-workflow](https://github.com/shanep/claude-workflow))

## Auto-update

Claude Code only auto-updates third-party marketplaces when you ask it to. Add
this to `~/.claude/settings.json` so new plugin versions show up on their own:

```json
"extraKnownMarketplaces": {
  "shanep": {
    "source": { "source": "github", "repo": "shanep/claude-plugins" },
    "autoUpdate": true
  }
}
```

## Adding a plugin

Add an entry to `.claude-plugin/marketplace.json` with a `url` source and the
repo's https URL. A `github` source clones over ssh, so it fails on machines
without a GitHub key.

## Checks

A push to main goes live right away on every machine with auto-update on,
including student machines, so the manifest gets checked before it leaves.

- `scripts/check.sh` runs `claude plugin validate --strict .` and fails if any
  plugin is not a `url` source with an https URL.
- `scripts/test-install.sh` adds this checkout as a marketplace and installs
  every plugin into a throwaway config with ssh turned off.

The pre-commit hook runs the first one and the pre-push hook runs both. Claude
Code sets `core.hooksPath` to `.githooks` when a session starts here (see
`.claude/settings.json`). Outside Claude Code, run this once after cloning:

```
git config core.hooksPath .githooks
```

GitHub Actions runs both scripts on Ubuntu and macOS for every push to main,
every pull request, and once a week, since the plugins live in other repos and
can break without a change here.
