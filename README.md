# Claude Plugins

A Claude Code marketplace for my plugins. Each plugin lives in its own repo
and this one just lists them, so you only need to add one marketplace.

## Install

```
claude plugin marketplace add shanep/claude-plugins
claude plugin install boisestate@shanep
claude plugin install tune@shanep
```

## Plugins

- boisestate - Run Claude Code on boisestate.ai ([shanep/boisestate.ai](https://github.com/shanep/boisestate.ai))
- tune - Find where your sessions spend tokens ([shanep/claude-tune](https://github.com/shanep/claude-tune))

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
