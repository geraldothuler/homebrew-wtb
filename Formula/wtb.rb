require "download_strategy"

# Custom strategy: download GitHub Release asset from a private repo
# by hitting the asset API endpoint with the HOMEBREW_GITHUB_API_TOKEN
# header (Accept: application/octet-stream returns the binary).
class GitHubReleaseAuthDownloadStrategy < CurlDownloadStrategy
  def fetch(timeout: nil)
    token = ENV.fetch("HOMEBREW_GITHUB_API_TOKEN") do
      raise CurlDownloadStrategyError,
            "HOMEBREW_GITHUB_API_TOKEN not set — required for private repo wtb"
    end
    @url = api_asset_url(@url, token)
    super
  end

  private

  # Convert https://github.com/<owner>/<repo>/releases/download/<tag>/<asset>
  # → https://api.github.com/repos/<owner>/<repo>/releases/assets/<id>
  def api_asset_url(browser_url, token)
    m = browser_url.match(
      %r{^https://github\.com/(?<owner>[^/]+)/(?<repo>[^/]+)/releases/download/(?<tag>[^/]+)/(?<asset>.+)$},
    )
    raise CurlDownloadStrategyError, "unrecognized release URL: #{browser_url}" unless m

    owner, repo, tag, asset = m[:owner], m[:repo], m[:tag], m[:asset]
    release_api = "https://api.github.com/repos/#{owner}/#{repo}/releases/tags/#{tag}"
    body = Utils::Curl.curl_output(
      "--header", "Authorization: token #{token}",
      "--header", "Accept: application/vnd.github+json",
      "--silent", "--fail", "--location",
      release_api
    ).stdout
    release = JSON.parse(body)
    asset_meta = release.fetch("assets").find { |a| a["name"] == asset }
    raise CurlDownloadStrategyError, "asset #{asset} not in release #{tag}" unless asset_meta

    asset_meta["url"]
  end

  def _curl_args
    super + [
      "--header", "Authorization: token #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN")}",
      "--header", "Accept: application/octet-stream",
    ]
  end
end

class Wtb < Formula
  desc "Workflow toolbox — single entry point of the workflow platform (CLI + MCP)"
  homepage "https://github.com/geraldothuler/workflow-toolkit"
  version "1.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/geraldothuler/workflow-toolkit/releases/download/v1.1.1/wtb-1.1.1-darwin-arm64",
        using: GitHubReleaseAuthDownloadStrategy
      sha256 "6d16f8f84f7c92cb5110fc0fc4ebf296f469388059a3e52d19b855c2a714729d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/geraldothuler/workflow-toolkit/releases/download/v1.1.1/wtb-1.1.1-linux-amd64",
        using: GitHubReleaseAuthDownloadStrategy
      sha256 "b83b2f95340cbf8ecd8f4765cfd1844b126eb91746a68ebe1f312137cdc29fa9"
    end
    on_arm do
      url "https://github.com/geraldothuler/workflow-toolkit/releases/download/v1.1.1/wtb-1.1.1-linux-arm64",
        using: GitHubReleaseAuthDownloadStrategy
      sha256 "f67419618e1dddd45e8b45f2f01d857cfde1af7572156f48209e1247a2d20107"
    end
  end

  def install
    bin.install Dir["*"].first => "wtb"
  end

  def caveats
    <<~EOS
      wtb is distributed from a private GitHub repository.
      Export HOMEBREW_GITHUB_API_TOKEN with a PAT (classic, `repo` scope)
      before installing or upgrading:

          export HOMEBREW_GITHUB_API_TOKEN=ghp_xxx

      Persist it in your shell rc to avoid setting it each time.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wtb --version")
  end
end
