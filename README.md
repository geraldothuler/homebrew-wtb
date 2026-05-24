# homebrew-wtb

Homebrew tap for **wtb** — workflow toolbox CLI (workflow platform single entry point, CLI + MCP server).

## Install

```bash
brew tap geraldothuler/wtb
brew install wtb
```

Or one-liner:

```bash
brew install geraldothuler/wtb/wtb
```

## Upgrade

```bash
brew update && brew upgrade wtb
```

## Supported platforms

| OS | Arch | Status |
|----|------|--------|
| macOS | arm64 (Apple Silicon) | ✓ |
| macOS | amd64 (Intel) | not built — see `geraldothuler/workflow-toolkit` discovery doc |
| Linux | amd64 | ✓ |
| Linux | arm64 | ✓ |

## Verify

```bash
wtb --version       # wtb version 1.1.1
wtb mcp --help      # MCP install/uninstall/doctor/schema
```

## Upstream

Source code + release workflow: [geraldothuler/workflow-toolkit](https://github.com/geraldothuler/workflow-toolkit).

Formula updates are manual today. When a new tag is published upstream, this formula receives a PR with new SHA256 + version.
