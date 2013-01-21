require 'formula'

class Sextractor < Formula
  homepage 'http://www.astromatic.net/software/sextractor'
  url 'http://www.astromatic.net/download/sextractor/sextractor-2.8.6.tar.gz'
  sha1 '103ac2d51d9bae9fcbc5dda3031d82cd127f8250'

  depends_on 'fftw'
  depends_on 'atlas' 
  # Although MacOS ships with ATLAS, it doesn't include the LAPACK parts.

  def install

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--with-atlas=/usr/local/lib"

    system "make install"
  end
end
