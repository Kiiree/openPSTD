#!/usr/bin/env bash
set -e

echo installing HDF5 with source
wget https://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.16.tar.bz2
tar -xjf hdf5-1.8.16.tar.bz2
cd hdf5-1.8.16
CFLAGS="-m64"
./configure
make CFLAGS="-w -fPIC" CXXFLAGS="-w -fPIC"
sudo make install
cd ../