#!/usr/bin/env bash
set -e

if [ ${TRAVIS_OS_NAME} = "linux" ]; then
    echo running on linux
    echo installing fftw
    sudo apt-get update
    sudo apt-get  --yes --force-yes install libfftw3-dev
else
    echo running on mac os x
    echo fftw in homebrew is not compiled with float support
    echo compiling fftw from source with --enable-float
    wget http://www.fftw.org/fftw-3.3.4.tar.gz
    tar -xzf fftw-3.3.4.tar.gz
    cd fftw-3.3.4
    ./configure --enable-float
    make
    sudo make install
    echo clean up to install double version as well
    make distclean
    ./configure
    make
    sudo make install
    cd ..
fi
