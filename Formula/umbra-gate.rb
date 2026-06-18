class UmbraGate < Formula
  desc "Local-first LLM gateway with dashboard and provider routing"
  homepage "https://github.com/jachy-h/umbra-gate"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.1.1/umbra-gate_Darwin_arm64.tar.gz"
      sha256 "23c4e522c6a5a3df94c2a308846a215dd306f96ba44fff700156dc80f47ec570"
    else
      url "https://github.com/jachy-h/umbra-gate/releases/download/v0.1.1/umbra-gate_Darwin_x86_64.tar.gz"
      sha256 "0666689acca62b40816fd4c206aca8f2331905e8e3491a8631edc1b27aca1e43"
    end
  end

  def install
    bin.install "personal-ai-router" => "umbra-gate"
    pkgshare.install "config.example.yaml"
  end

  def caveats
    <<~EOS
      Example config installed to:
        #{pkgshare}/config.example.yaml

      Quick start:
        cp #{pkgshare}/config.example.yaml ./config.yaml
        export OPENAI_API_KEY=sk-xxxxx
        umbra-gate
    EOS
  end

  test do
    output = shell_output("#{bin}/umbra-gate --help", 1)
    assert_match "flag provided but not defined", output
  end
end
