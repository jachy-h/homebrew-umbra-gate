class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.1.2/umbragate_Darwin_arm64.tar.gz"
      sha256 "1bf6885fa63840acca24e67af5e0715dfce712379678a65855a94f2fbd3968bb"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.1.2/umbragate_Darwin_x86_64.tar.gz"
      sha256 "3562f0eed6d37046bedbc6ee49ad25ff98dcbcfe4fcdb198a57e4d2ef1a1aca5"
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
