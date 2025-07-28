class Wake < Formula
  desc "Command-line tool for tailing multiple pods and containers in Kubernetes clusters"
  homepage "https://github.com/samba-rgb/wake"
  url "https://github.com/samba-rgb/wake/archive/refs/tags/v0.7.5.tar.gz"
  sha256 "3c8f8ed0daa875c64ab88856c04211d348f5972163f4fc36c36c6344c98b4a6e"
  version "0.7.5"
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
      ohai "Installing Wake version 0.7.5 (latest)"
    end

    system "cargo", "install", "--root", prefix, "--path", "."
  end

  test do
    assert_match "wake", shell_output("#{bin}/wake --version")
  end
end