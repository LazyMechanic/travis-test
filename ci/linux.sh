# Get newest cmake
CMAKE_DIR="/opt/cmake/bin"

sudo wget "https://github.com/Kitware/CMake/releases/download/v3.16.0-rc3/cmake-3.16.0-rc3-Linux-x86_64.tar.gz"
sudo tar -xzf cmake-3.16.0-rc3-Linux-x86_64.tar.gz
sudo mv cmake-3.16.0-rc3-Linux-x86_64 /opt/cmake

# Download googletest
sudo wget https://github.com/google/googletest/archive/release-1.10.0.tar.gz
sudo tar -xzf release-1.10.0.tar.gz

# Compile googletest
cd googletest-release-1.10.0
sudo mkdir install 
sudo mkdir build 
cd build
sudo ${CMAKE_DIR}/cmake .. -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DCMAKE_INSTALL_PREFIX="/usr/src/gtest"
sudo ${CMAKE_DIR}/cmake --build .
sudo ${CMAKE_DIR}/cmake --install .

# Compile target
cd "${TRAVIS_BUILD_DIR}"
sudo mkdir build
cd build
sudo ${CMAKE_DIR}/cmake .. -Dtravis-test_BUILD_TESTS=ON -DCMAKE_BUILD_TYPE=$BUILD_TYPE -DGTest_DIR="/usr/src/gtest/lib/cmake/GTest"
sudo ${CMAKE_DIR}/cmake --build .

# Testing
sudo ${CMAKE_DIR}/ctest --verbose