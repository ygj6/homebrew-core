class Avfs < Formula
  desc "Virtual file system that facilitates looking inside archives"
  homepage "https://avf.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/avf/avfs/1.1.0/avfs-1.1.0.tar.bz2"
  sha256 "a7f3734f5be1a76aab710fb49a004b60bb802ccbd32394a731b18ed6011333a7"

  bottle do
    sha256 "3aa296ad227248a43fcb7723c0f5c9779662ee3abc8b1e6477c0271a1e50c6fe" => :mojave
    sha256 "bcde7798b2fff699e68237479e4a106323becee2028d47080e82f0769b792120" => :high_sierra
    sha256 "bed10bc8e692380a485c14719e42dc6ba386cc756acb471f7b5e65a3428f0d68" => :sierra
  end

  depends_on "pkg-config" => :build
  depends_on :macos => :sierra # needs clock_gettime
  depends_on "openssl"
  depends_on :osxfuse
  depends_on "xz"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-fuse
      --enable-library
      --with-ssl=#{Formula["openssl"].opt_prefix}
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"avfsd", "--version"
  end
end
