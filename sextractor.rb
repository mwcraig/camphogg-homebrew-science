require 'formula'

class Sextractor < Formula
  homepage 'http://www.astromatic.net/software/sextractor'
  url 'http://www.astromatic.net/download/sextractor/sextractor-2.8.6.tar.gz'
  sha1 '103ac2d51d9bae9fcbc5dda3031d82cd127f8250'

  depends_on 'fftw'
  #depends_on 'openblas'
  depends_on 'atlas' # oh my

  def install
    # ENV.j1  # if your formula's build system can't parallelize

    lib = "#{HOMEBREW_PREFIX}/lib"
    atlas = "#{lib}/libatlas.a #{lib}/liblapack.a #{lib}/libcblas.a"
    # ENV['ATLAS_LIB'] = atlas  # Nope, doesn't work

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    
    # it's not so easy...
    #inreplace "src/Makefile",
    #  "ATLAS_LIB =  -llapack -lptcblas -lcblas -latlas",
    #  "ATLAS_LIB = #{atlas}"
    inreplace "src/Makefile",
      "-llapack -lptcblas -lcblas -latlas",
      "#{atlas}"


    system "make install" # if this fails, try separate make/make install steps
  end
end


# ./configure --with-atlas-incdir=/System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/Headers --with-atlas=/usr

# --with-atlas=/System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A
# checking for clapack_dpotrf in -llapack... no
# checking for cblas_dgemm in -lcblas... yes
# checking for clapack_dpotrf in -llapack... no
# checking for cblas_dgemm in -lcblas... yes
# checking for clapack_dpotrf in -llapack... no
# checking for cblas_dgemm in -lcblas... yes
# checking for clapack_dpotrf in -llapack... no
# checking for cblas_dgemm in -lcblas... yes
# checking for clapack_dpotrf in -llapack... no
# checking for cblas_dgemm in -lcblas... yes
