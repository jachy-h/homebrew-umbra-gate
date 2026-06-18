class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.2.0/umbragate_Darwin_arm64.tar.gz"
      sha256 "ee303814bd371922479efc3da9bc14538a579e5f9fa578b6d86690efc3e8ac88"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.2.0/umbragate_Darwin_x86_64.tar.gz"
      sha256 "065fe53cf7b7c0e15b9b79cfa97fffac0a0cd606943e4e3986d1bdf3a04d17be"
    end
  end

  def install
    bin.install "umbragate"
    pkgshare.install "config.example.yaml"
  end

  service do
    run [opt_bin/"umbragate"]
    keep_alive true
    log_path var/"log/umbragate.log"
    error_log_path var/"log/umbragate.log"
  end

  def caveats
    <<~EOS
      Example config installed to:
        ~/.umbragate/config.example.yaml (created on first launch)

      Homebrew install stores config and database in:
        ~/.umbragate/

      Quick start:
        umbragate
        cp ~/.umbragate/config.example.yaml ~/.umbragate/config.yaml
        export OPENAI_API_KEY=sk-xxxxx
        umbragate

      Background mode:
        brew services start umbragate
        # or
        umbragate -d
    EOS
  end

  test do
    output = shell_output("#{bin}/umbragate --help")
    assert_match "Usage: umbragate", output
  end
end
