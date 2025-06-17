class Wake < Formula
  desc "Command-line tool for tailing multiple pods and containers in Kubernetes clusters"
  homepage "https://github.com/samba-rgb/wake"
  url "https://github.com/samba-rgb/wake/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "413941ab44eb866eda9b3422fab48f7e7816e1cab15a21b5613f334ca9b2ec62"
  version "0.3.0"
  license "MIT"
  head "https://github.com/samba-rgb/wake.git", branch: "main"

  depends_on "rust" => :build

  # Support for installing specific versions
  option "with-version=", "Install a specific version (e.g., --with-version=v0.1.0)"

  def install
    # Check if a specific version was requested
    if build.with?("version")
      version = build.option("version")
      ohai "Installing Wake version #{version}"
      
      # Download the specific version
      system "curl", "-L", "-o", "wake-#{version}.tar.gz", 
             "https://github.com/samba-rgb/wake/archive/refs/tags/#{version}.tar.gz"
      system "tar", "-xzf", "wake-#{version}.tar.gz", "--strip-components=1"
      
      system "cargo", "install", "--root", prefix, "--path", "."
    else
      # Default: install from the downloaded tarball (v0.3.0)
      ohai "Installing Wake version 0.3.0 (latest)"
      system "cargo", "install", "--root", prefix, "--path", "."
    end
  end

  def caveats
    <<~EOS
      By default, version 0.3.0 (latest) is installed.
      
      To install a specific version, use:
        brew install samba-rgb/wake/wake --with-version=v0.1.0
      
      Available versions can be found at:
        https://github.com/samba-rgb/wake/releases
    EOS
  end

  test do
    assert_match "wake", shell_output("#{bin}/wake --version")
  end
end