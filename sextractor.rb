require 'formula'

class Sextractor < Formula
  homepage 'http://www.astromatic.net/software/sextractor'
  url 'http://www.astromatic.net/download/sextractor/sextractor-2.8.6.tar.gz'
  sha1 '103ac2d51d9bae9fcbc5dda3031d82cd127f8250'

  depends_on 'fftw'
  #depends_on 'openblas'
  depends_on 'atlas' # oh my

  # Although MacOS ships with ATLAS, it doesn't include the LAPACK parts.

  def install
    # dstn couldn't get ATLAS to build shared libs, so forced SExtractor to link statically.
    # This requires string-replacing in the Makefile.

    lib = "#{HOMEBREW_PREFIX}/lib"
    atlas = "#{lib}/libatlas.a #{lib}/liblapack.a #{lib}/libcblas.a"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    inreplace "src/Makefile",
      "-llapack -lptcblas -lcblas -latlas",
      "#{atlas}"

    system "make install"
  end
end

