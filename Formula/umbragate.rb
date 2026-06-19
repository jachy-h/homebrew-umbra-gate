class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.3.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.3.1/umbragate_Darwin_arm64.tar.gz"
      sha256 "1c31df146f52c5744ba2fb8901ccc5388291247f230ded51d9dff492ac52b467"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.3.1/umbragate_Darwin_x86_64.tar.gz"
      sha256 "7db28bf4dce15fcaaf58b55e250d07d6fca7ee4d4ef1c87fe3455534fb083e3c"
    end
  end

  def install
    bin.install "umbragate"
    pkgshare.install "config.yaml"
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
        ~/.umbragate/config.yaml (created on first launch)

      Homebrew install stores config and database in:
        ~/.umbragate/

      Quick start:
        umbragate
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
