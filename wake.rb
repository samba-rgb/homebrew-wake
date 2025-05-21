class Wake < Formula
  desc "Wake project"
  homepage "https://github.com/samba-rgb/wake"
  url "https://github.com/samba-rgb/wake/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "9a4e3d2d6a3c8fd3af12339842b284f3e0bb7d7421d4e88797f734a4e26e3950"
  license "MIT"

  def install
    bin.install "wake"
  end

  test do
    system "#{bin}/wake", "--version"
  end
end