class Wake < Formula
  desc "Command-line tool for tailing multiple pods and containers in Kubernetes clusters"
  homepage "https://github.com/samba-rgb/wake"
  url "https://github.com/samba-rgb/wake/archive/refs/tags/latest.tar.gz"
  version "latest"
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
    else
      # Default: get the latest release
      ohai "Installing latest version of Wake"
      system "curl", "-L", "-o", "wake-latest.tar.gz",
             "https://github.com/samba-rgb/wake/archive/refs/heads/main.tar.gz"
      system "tar", "-xzf", "wake-latest.tar.gz", "--strip-components=1"
    end

    system "cargo", "install", "--root", prefix, "--path", "."
  end

  def caveats
    <<~EOS
      By default, the latest version is installed.
      
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