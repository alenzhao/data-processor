#!/bin/sh

baseDir="/scratch/"

pushd baseDir

curl http://www.cmake.org/files/v3.3/cmake-3.3.1.tar.gz -o cmake
tar -zxf cmake-3.3.1.tar.gz && pushd cmake-3.3.1
./configure --prefix=baseDir
make
make install
popd

curl http://pkgconfig.freedesktop.org/releases/pkg-config-0.28.tar.gz -o pkgconfig.tgz
tar -zxf pkgconfig.tgz && pushd pkg-config-0.28
env CPPFLAGS="-I/scratch/include" CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" ./configure --with-internal-glib --prefix=baseDir
make
make install
popd

curl http://sourceforge.net/projects/libjpeg/files/libjpeg/6b/jpegsrc.v6b.tar.gz/download -o jpeg.tar.gz
tar -zxf jpeg.tar.gz && pushd jpeg-9a
env CPPFLAGS="-I/scratch/include" CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" ./configure --prefix=baseDir
make
make install
popd


curl https://github.com/uclouvain/openjpeg/archive/version.2.1.tar.gz -o openjpeg.tar.gz
tar -zxf openjpeg.tar.gz && pushd openjpeg-version.2.1
env CPPFLAGS="-I/scratch/include" CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" ./configure --prefix=baseDir
make
make install
popd

curl ftp://ftp.remotesensing.org/pub/libtiff/tiff-4.0.4.tar.gz -o tiff.tar.gz
tar -zxf tiff.tar.gz && pushd tiff-4.0.4
env CPPFLAGS="-I/scratch/include" CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" ./configure --prefix=baseDir
make
make install
popd

curl http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz -o iconv.tar.gz
env CPPFLAGS="-I/scratch/include" CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" tar -zxf iconv.tar.gz && pushd libiconv-1.14
./configure --prefix=baseDir
make
make install
popd

curl http://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.tar.gz -o gettext.tar.gz
env CPPFLAGS="-I/scratch/include" CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" tar -zxf gettext.tar.gz && pushd gettext-0.19.tar.gz
./configure --prefix=baseDir
make
make install
popd

curl ftp://ftp.gnome.org/pub/gnome/sources/glib/2.44/glib-2.44.1.tar.xz -o glibb.tar.xz
xz -d -c glib.tar.xz | tar xvf - && pushd glib-2.44.1
env CPPFLAGS="-I/scratch/include" CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" ./configure --prefix=baseDir
make
make install
popd

curl ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz ffi.tar.gz
tar -zxf ffi.tar.gz && pushd libffi-3.2.1
env CPPFLAGS="-I/scratch/include" CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" ./configure --prefix=baseDir
make
make install
popd


curl http://sourceforge.net/projects/libpng/files/libpng16/1.6.18/libpng-1.6.18.tar.gz/download libpng.tar.gz
tar -zxf libpng.tar.gz && pushd libpng16-1.6.18
env CPPFLAGS="-I/scratch/include" CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" ./configure --prefix=baseDir
make
make install
popd

curl http://cairographics.org/releases/cairo-1.14.2.tar.xz -o cairo.tar.xz
xz -d -c cairo.tar.xz | tar xvf - && pushd cairo-1.14.2
env CPPFLAGS="-I/scratch/include" CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" ./configure --prefix=baseDir
make
make install
popd

curl ftp://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/2.31/gdk-pixbuf-2.31.6.tar.xz -o pixbuf.tar.xz
xz -d -c pixbuf.tar.xz | tar xvf - && pushd gdk-pixbuf-2.31.6
env CPPFLAGS="-I/scratch/include" CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" ./configure --prefix=baseDir
make
make install
popd

curl ftp://xmlsoft.org/libxml2/libxml2-2.9.2.tar.gz libxml.tar.gz
tar -zxf libxml.tar.gz && pushd libxml2-2.9.2
env CPPFLAGS="-I/scratch/include" CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" ./configure --prefix=baseDir
make
make install
popd

curl https://www.sqlite.org/2015/sqlite-autoconf-3081101.tar.gz sqlite.zip
tar -zxf sqlite.zip && pushd sqlite-autoconf-3081101
env CPPFLAGS="-I/scratch/include" CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" ./configure --prefix=baseDir
make
make install
popd

git clone https://github.com/openslide/openslide.git
pushd openslide
env CFLAGS="-I/scratch/include" LDFLAGS="-L/scratch/lib" OPENJPEG2_CFLAGS="-I/scratch/usr/local/include/openjpeg-2.1" OPENJPEG2_LIBS="-L/scratch/usr/local/lib -lopenjp2" PKG_CONFIG="/scratch/pkg-config-0.28/pkg-config" ./configure --prefix=/scratch
make
make install
popd

popd

env HOME=baseDir pip install openslide-python
