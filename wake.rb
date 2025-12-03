class Wake < Formula
  desc "Command-line tool for tailing multiple pods and containers in Kubernetes clusters"
  homepage "https://github.com/samba-rgb/wake"
  license "MIT"

  on_macos do
    # OpenSSL dependency required for Mac
    depends_on "openssl@3"
    
    if Hardware::CPU.arm?
      url "https://github.com/samba-rgb/wake/releases/download/v0.9.13/wake-aarch64-apple-darwin"
      sha256 "78829f389830d8cdd6b5db1b043f2dce8393e3b91b29a90a227cf54ef8f4e41a"
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
      url "https://github.com/samba-rgb/wake/releases/download/v0.9.13/wake-x86_64-unknown-linux-gnu"
      sha256 "119e1eaf9a1ce813d4f2647eec95e308a2829a1a73db2d49d5321d90a46d4409"
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