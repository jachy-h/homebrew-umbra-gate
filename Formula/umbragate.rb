class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.3.0/umbragate_Darwin_arm64.tar.gz"
      sha256 "db91c4225a1ef8fdf239058437ce3063dced847bc45ed7ac5565d18dfb4d4841"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.3.0/umbragate_Darwin_x86_64.tar.gz"
      sha256 "89c910e74029d0df5a4492cc5d241d9be54483dad68de6f1bae90805d85b0c32"
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
