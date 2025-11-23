class Wake < Formula
  desc "Command-line tool for tailing multiple pods and containers in Kubernetes clusters"
  homepage "https://github.com/samba-rgb/wake"
  license "MIT"

  on_macos do
    # OpenSSL dependency required for Mac
    depends_on "openssl@3"
    
    if Hardware::CPU.arm?
      url "https://github.com/samba-rgb/wake/releases/download/v0.9.12/wake-aarch64-apple-darwin"
      sha256 "711a35c0dd7883244e9400af2d2cb15d68f3a37fd713bb86b6a3a9e8aa72b349"
    else
      # Intel Mac not supported yet
      odie "Wake is not available for Intel Mac chips yet. Please use an ARM-based Mac (Apple Silicon)."
    end
  end

  on_linux do
    # Linux systems typically have OpenSSL available in system paths
    if Hardware::CPU.arm?
      # ARM Linux not available in this release
      odie "Wake is not available for ARM Linux chips yet. Please use an Intel-based Linux system."
    else
      url "https://github.com/samba-rgb/wake/releases/download/v0.9.12/wake-x86_64-unknown-linux-gnu"
      sha256 "4b018033e045b4822021fc07379478182d22bc7b1637839fe044a11b2469f2ae"
    end
  end

  def install
    if OS.mac?
      bin.install "wake-aarch64-apple-darwin" => "wake"
    elsif OS.linux?
      bin.install "wake-x86_64-unknown-linux-gnu" => "wake"
    end
  end

  test do
    assert_match "wake", shell_output("#{bin}/wake --version")
  end
end