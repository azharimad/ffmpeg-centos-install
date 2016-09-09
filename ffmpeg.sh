yum install autoconf automake cmake freetype-devel gcc gcc-c++ git libtool make mercurial nasm pkgconfig zlib-devel

mkdir -p /usr/local/src/ffmpeg_build

cd /usr/local/src/ffmpeg_build
git clone --depth 1 git://github.com/yasm/yasm.git
cd yasm
autoreconf -fiv
./configure --prefix="/usr/local/ffmpeg_build" --bindir="/usr/local/bin"
make
make install
make distclean

cd /usr/local/ffmpeg_build
git clone --depth 1 git://git.videolan.org/x264
cd x264
./configure --prefix="/usr/local/ffmpeg_build" --bindir="/usr/local/bin" --enable-static
make
make install
make distclean

cd /usr/local/ffmpeg_build
hg clone https://bitbucket.org/multicoreware/x265
cd /usr/local/ffmpeg_build/x265/build/linux
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/usr/local/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
make
make install

cd /usr/local/ffmpeg_build
git clone --depth 1 git://git.code.sf.net/p/opencore-amr/fdk-aac
cd fdk-aac
autoreconf -fiv
./configure --prefix="/usr/local/ffmpeg_build" --disable-shared
make
make install
make distclean


cd /usr/local/ffmpeg_build
curl -L -O http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar xzvf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure --prefix="/usr/local/ffmpeg_build" --bindir="/usr/local/bin" --disable-shared --enable-nasm
make
make install
make distclean

cd ~/ffmpeg_sources
git clone git://git.opus-codec.org/opus.git
cd opus
autoreconf -fiv
./configure --prefix="/usr/local/ffmpeg_build" --disable-shared
make
make install
make distclean

cd /usr/local/ffmpeg_build
curl -O http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz
tar xzvf libogg-1.3.2.tar.gz
cd libogg-1.3.2
./configure --prefix="/usr/local/ffmpeg_build" --disable-shared
make
make install
make distclean

cd /usr/local/ffmpeg_build
curl -O http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.4.tar.gz
tar xzvf libvorbis-1.3.4.tar.gz
cd libvorbis-1.3.4
LDFLAGS="-L$HOME/ffmeg_build/lib" CPPFLAGS="-I/usr/local/ffmpeg_build/include" ./configure --prefix="/usr/local/ffmpeg_build" --with-ogg="/usr/local/ffmpeg_build" --disable-shared
make
make install
make distclean

cd /usr/local/ffmpeg_build
git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git
cd libvpx
./configure --prefix="/usr/local/ffmpeg_build" --disable-examples
make
make install
make clean

cd /usr/local/ffmpeg_build
git clone --depth 1 git://source.ffmpeg.org/ffmpeg
cd ffmpeg
PKG_CONFIG_PATH="/usr/local/ffmpeg_build/lib/pkgconfig" ./configure --prefix="/usr/local/ffmpeg_build" --extra-cflags="-I/usr/local/ffmpeg_build/include" --extra-ldflags="-L/usr/local/ffmpeg_build/lib" --bindir="/usr/local/bin" --pkg-config-flags="--static" --enable-gpl --enable-nonfree --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265
make
make install
make distclean
hash -r
