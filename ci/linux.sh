# Get newest cmake
#!/usr/bin/env sh

CMAKE_DIR="/opt/cmake"
CMAKE="$CMAKE_DIR/bin/cmake"
CTEST="$CMAKE_DIR/bin/ctest"

wget "https://github.com/Kitware/CMake/releases/download/v3.16.0-rc3/cmake-3.16.0-rc3-Linux-x86_64.tar.gz"
tar -xzf cmake-3.16.0-rc3-Linux-x86_64.tar.gz
mv cmake-3.16.0-rc3-Linux-x86_64 "$CMAKE_DIR"

# Download googletest
wget https://github.com/google/googletest/archive/release-1.10.0.tar.gz
tar -xzf release-1.10.0.tar.gz

GTEST_DIR="$(pwd)/googletest-release-1.10.0"

cd "$TRAVIS_BUILD_DIR"

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