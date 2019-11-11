#!/usr/bin/env sh

# Download googletest
wget https://github.com/google/googletest/archive/release-1.10.0.tar.gz
tar -xzf release-1.10.0.tar.gz

GTEST_DIR="$(pwd)/googletest-release-1.10.0"

CONFIG=""
if [[ $GENERATOR = "MinGW Makefiles" ]]
then
    CONFIG="-DCMAKE_BUILD_TYPE=$BUILD_TYPE"
else
    CONFIG="-DCMAKE_CONFIGURATION_TYPES=Debug;Release"
fi

# Compile googletest
cd "$GTEST_DIR"
mkdir build 
cd build

cmake .. -G "$GENERATOR" $CONFIG -DCMAKE_CONFIGURATION_TYPES=Debug;Release -DCMAKE_INSTALL_PREFIX="$GTEST_DIR/install"
ls -a

cmake --build . --config $BUILD_TYPE
cmake --install .

# Compile target
cd "$TRAVIS_BUILD_DIR"
mkdir build
cd build
cmake .. -G "$GENERATOR" $CONFIG -Dtravis-test_BUILD_TESTS=ON -DGTest_DIR="$GTEST_DIR/install/lib/cmake/GTest"

cmake --build . --config $BUILD_TYPE
#-DCMAKE_CXX_COMPILER="C:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/VC/Tools/MSVC/14.16.27023/bin/Hostx86/x86/cl.exe" \
#-DCMAKE_C_COMPILER="C:/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/VC/Tools/MSVC/14.16.27023/bin/Hostx86/x86/cl.exe" \
    
# Testing
ctest --verbose