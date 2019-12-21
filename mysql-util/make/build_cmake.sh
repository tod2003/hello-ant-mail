#/bin/sh

export PATH_DIST=$PWD/../dist/
export PATH_BUILD=$PWD/../build

rm -rf $PATH_BUILD
mkdir -p $PATH_BUILD
cd $PATH_BUILD

cmake ../src

make -j8 install
