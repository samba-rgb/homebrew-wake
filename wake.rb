class Wake < Formula
  desc "Command-line tool for tailing multiple pods and containers in Kubernetes clusters"
  homepage "https://github.com/samba-rgb/wake"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samba-rgb/wake/releases/download/v0.9.11/wake-aarch64-apple-darwin.tar.gz"
      sha256 "UPDATE_WITH_ARM_MAC_SHA"
    else
      # Intel Mac not supported yet
      odie "Wake is not available for Intel Mac chips yet. Please use an ARM-based Mac (Apple Silicon)."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/samba-rgb/wake/releases/download/v0.9.11/wake-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "UPDATE_WITH_ARM_LINUX_SHA"
    else
      # Intel Linux not supported yet
      odie "Wake is not available for Intel Linux chips yet. Please use an ARM-based Linux system."
    end
  end

  def install
    bin.install "wake"
  end

  test do
    assert_match "wake", shell_output("#{bin}/wake --version")
  end
end