# homebrew-wtb

Homebrew tap for **wtb** — workflow toolbox CLI (workflow platform single entry point, CLI + MCP server).

The upstream repository ([geraldothuler/workflow-toolkit](https://github.com/geraldothuler/workflow-toolkit)) is **private**, so the formula uses `GitHubPrivateRepositoryReleaseDownloadStrategy` and requires a GitHub PAT with `repo` scope.

## Install

1. Create a personal access token at https://github.com/settings/tokens (classic, `repo` scope).
2. Export it before installing:
   ```bash
   export HOMEBREW_GITHUB_API_TOKEN=ghp_xxx
   ```
   Optionally persist it in `~/.zshrc` / `~/.bashrc`.
3. Install:
   ```bash
   brew tap geraldothuler/wtb
   brew install wtb
   ```

   Or one-liner: `brew install geraldothuler/wtb/wtb`.

## Upgrade

```bash
export HOMEBREW_GITHUB_API_TOKEN=ghp_xxx  # if not in shell rc
brew update && brew upgrade wtb
```

## Supported platforms

| OS | Arch | Status |
|----|------|--------|
| macOS | arm64 (Apple Silicon) | ✓ |
| macOS | amd64 (Intel) | not built — see discovery doc upstream |
| Linux | amd64 | ✓ |
| Linux | arm64 | ✓ |

## Verify

```bash
wtb --version       # wtb version 1.1.1
wtb mcp --help      # MCP install/uninstall/doctor/schema
```

## Upstream

Source code + release workflow: [geraldothuler/workflow-toolkit](https://github.com/geraldothuler/workflow-toolkit) (private).

Formula updates are manual today. When a new tag is published upstream, this formula receives a commit with new SHA256 + version.
