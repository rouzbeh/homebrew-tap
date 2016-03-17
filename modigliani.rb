class Modigliani < Formula
  desc "Modigliani is a stochastic simulator for neuroscientists."
  homepage "http://www.modigliani.co.uk"
  url "https://github.com/rouzbeh/Modigliani/archive/2.0.11.tar.gz"
  version "2.0.11"
  sha256 "7b40e6ffc1f788331bb6ffb0e2569cc483775ddb55440cc4eded48f513e5425d"

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
