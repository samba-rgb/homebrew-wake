class Wake < Formula
  desc "Command-line tool for tailing multiple pods and containers in Kubernetes clusters"
  homepage "https://github.com/samba-rgb/wake"
  url "https://github.com/samba-rgb/wake/archive/refs/tags/v0.9.11.tar.gz"
  sha256 "d884c059343ef7344aa57345e5a4166aa7fff8317cfd32c83e8f26d35c10f5ee"
  version "0.9.11"
  license "MIT"

  depends_on "rust" => :build

  option "with-version=", "Install a specific version (e.g., --with-version=v0.1.0)"

  def install
    if build.with?("version")
      requested_version = build.option("version")
      ohai "Installing Wake version #{requested_version}"

      # Download the specific version
      system "curl", "-L", "-o", "wake-#{requested_version}.tar.gz",
             "https://github.com/samba-rgb/wake/archive/refs/tags/#{requested_version}.tar.gz"
      system "tar", "-xzf", "wake-#{requested_version}.tar.gz", "--strip-components=1"
    else
      ohai "Installing Wake version 0.9.11 (latest)"
    end

    # Check if cargo binstall is available, otherwise use cargo install
    if system("cargo", "binstall", "--version", out: File::NULL, err: File::NULL)
      ohai "Using cargo binstall for faster installation"
      system "cargo", "binstall", "--root", prefix, "--path", ".", "--no-confirm"
    else
      ohai "cargo binstall not available, using cargo install"
      system "cargo", "install", "--root", prefix, "--path", "."
    end
  end

  test do
    assert_match "wake", shell_output("#{bin}/wake --version")
  end
end