class Wake < Formula
  desc "Command-line tool for tailing multiple pods and containers in Kubernetes clusters"
  homepage "https://github.com/samba-rgb/wake"
  license "MIT"

  on_macos do
    # OpenSSL dependency required for Mac
    depends_on "openssl@3"
    
    if Hardware::CPU.arm?
      url "https://github.com/samba-rgb/wake/releases/download/v0.9.11/wake-aarch64-apple-darwin"
      sha256 "114b1227285b29de0f0b43c20a9ea8ece2d7039e3c11bb0ef1dad52fae36c061"
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
      url "https://github.com/samba-rgb/wake/releases/download/v0.9.11/wake-x86_64-unknown-linux-gnu"
      sha256 "6d3e340e3d66b94b93610186bbc9ff27aa9f6549ff466a70b8b94c310deb465c"
    end
  end

  def install
    if OS.mac?
      bin.install "wake-aarch64-apple-darwin" => "wake"
    elsif OS.linux?
      bin.install "wake-x86_64-unknown-linux-gnu" => "wake"
    end
  end

  # Add a post-install step to set up library linking on Linux
  def post_install
    return unless OS.linux?

    # Create a wrapper script that sets up the library path
    (bin/"wake-wrapper").write <<~EOS
      #!/bin/bash
      export LD_LIBRARY_PATH="#{Formula["openssl@3"].opt_lib}:$LD_LIBRARY_PATH"
      exec "#{bin}/wake" "$@"
    EOS
    
    (bin/"wake-wrapper").chmod 0755
    
    # Replace the original binary with our wrapper
    (bin/"wake").unlink
    (bin/"wake-wrapper").rename(bin/"wake")
  end

  test do
    assert_match "wake", shell_output("#{bin}/wake --version")
  end
end