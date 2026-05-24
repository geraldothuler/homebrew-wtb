require "download_strategy"

class Wtb < Formula
  desc "Workflow toolbox — single entry point of the workflow platform (CLI + MCP)"
  homepage "https://github.com/geraldothuler/workflow-toolkit"
  version "1.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/geraldothuler/workflow-toolkit/releases/download/v1.1.1/wtb-1.1.1-darwin-arm64",
        using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "6d16f8f84f7c92cb5110fc0fc4ebf296f469388059a3e52d19b855c2a714729d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/geraldothuler/workflow-toolkit/releases/download/v1.1.1/wtb-1.1.1-linux-amd64",
        using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "b83b2f95340cbf8ecd8f4765cfd1844b126eb91746a68ebe1f312137cdc29fa9"
    end
    on_arm do
      url "https://github.com/geraldothuler/workflow-toolkit/releases/download/v1.1.1/wtb-1.1.1-linux-arm64",
        using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "f67419618e1dddd45e8b45f2f01d857cfde1af7572156f48209e1247a2d20107"
    end
  end

  def install
    bin.install Dir["*"].first => "wtb"
  end

  def caveats
    <<~EOS
      wtb is distributed from a private GitHub repository.
      Export HOMEBREW_GITHUB_API_TOKEN with a PAT that has `repo` scope before installing/upgrading:

          export HOMEBREW_GITHUB_API_TOKEN=ghp_xxx

      Create token: https://github.com/settings/tokens (classic, `repo` scope).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wtb --version")
  end
end
