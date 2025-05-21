class Wake < Formula
  desc "Wake project"
  homepage "https://github.com/samba-rgb/wake"
  url "https://github.com/samba-rgb/wake/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f0d36a20650bf27c0f44be84a691e86d8cce3c1da2b77684a2da413a3afc0726"
  license "MIT"

  def install
    bin.install "wake"
  end

  test do
    system "#{bin}/wake", "--version"
  end
end