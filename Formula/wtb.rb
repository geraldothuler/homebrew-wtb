class Wtb < Formula
  desc "Workflow toolbox — single entry point of the workflow platform (CLI + MCP)"
  homepage "https://github.com/geraldothuler/workflow-toolkit"
  version "1.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/geraldothuler/workflow-toolkit/releases/download/v#{version}/wtb-#{version}-darwin-arm64"
      sha256 "6d16f8f84f7c92cb5110fc0fc4ebf296f469388059a3e52d19b855c2a714729d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/geraldothuler/workflow-toolkit/releases/download/v#{version}/wtb-#{version}-linux-amd64"
      sha256 "b83b2f95340cbf8ecd8f4765cfd1844b126eb91746a68ebe1f312137cdc29fa9"
    end
    on_arm do
      url "https://github.com/geraldothuler/workflow-toolkit/releases/download/v#{version}/wtb-#{version}-linux-arm64"
      sha256 "f67419618e1dddd45e8b45f2f01d857cfde1af7572156f48209e1247a2d20107"
    end
  end

  def install
    bin.install Dir["*"].first => "wtb"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wtb --version")
  end
end
