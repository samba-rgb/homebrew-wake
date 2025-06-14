class Wake < Formula
  desc "Command-line tool for tailing multiple pods and containers in Kubernetes clusters"
  homepage "https://github.com/samba-rgb/wake"
  url "https://github.com/samba-rgb/wake/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "b1de16a6e39cd3ba1bde7e501d3c2a8ccce9eecfadc6b96ad94834d8a8d7db68"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--root", prefix, "--path", "."
  end

  test do
    assert_match "wake", shell_output("#{bin}/wake --version")
  end
end