#/bin/sh

export PATH_DIST=$PWD/../dist/

rm -rf ../build_test
mkdir -p ../build_test
cd ../build_test

cmake ../test

make -j8 install
