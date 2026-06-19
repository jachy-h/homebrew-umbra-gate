class Umbragate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.3.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.3.2/umbragate_Darwin_arm64.tar.gz"
      sha256 "24c03307ac709591e823bf24cf976d44408048e06f4943e17397855b87df52f8"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.3.2/umbragate_Darwin_x86_64.tar.gz"
      sha256 "859bd15e2ac0ba0b0e8e125b85c31cad3c25184ed31fe8d1ffbc0937b6030d22"
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
