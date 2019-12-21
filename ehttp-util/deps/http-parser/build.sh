#/bin/sh

export PATH_DIST=$PWD/../../dist/
rm -rf build
mkdir -p build
cd build
cmake ../src

make 
make install

