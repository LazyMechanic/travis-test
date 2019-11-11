# Compile googletest
cd "$GTEST_DIR"
mkdir build 
cd build

$CMAKE .. \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
    -DCMAKE_INSTALL_PREFIX="$GTEST_DIR/install"

$CMAKE --build .
$CMAKE --install .

# Compile target
cd "$TRAVIS_BUILD_DIR"
mkdir build
cd build
$CMAKE .. \
    -Dtravis-test_BUILD_TESTS=ON \
    -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
    -DGTest_DIR="$GTEST_DIR/install/lib/cmake/GTest"

$CMAKE --build .

# Testing
$CTEST --verbose