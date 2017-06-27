class Modigliani < Formula
  desc "Modigliani is a stochastic simulator for neuroscientists."
  homepage "http://www.modigliani.co.uk"
  url "https://github.com/rouzbeh/Modigliani/archive/v2.1.0.tar.gz"
  version "2.1.0"
  sha256 "43eaf89bedeb1bd9682862e01f379aaca6216a986902171a5bc758ccc4781092"

  depends_on "boost" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "lua" => :build
  depends_on "pkg-config" => :build
  depends_on "libtool" => :build


  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    ENV.append "CXXFLAGS", ENV.cppflags
    ENV.append "CXXFLAGS", "-I#{Formula["boost"].include}"
    ENV.append "CXXFLAGS", "-I#{Formula["lua"].include}"
    # Remove unrecognized options if warned by configure
    system "autoreconf", "-fvi"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    system "#{bin}/modigliani", "-h"
  end
end
