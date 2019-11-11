find_package(GTest CONFIG REQUIRED)

add_executable(_test 
    "test.cpp")

target_link_libraries(
    _test
    travis-test
    GTest::gtest
    GTest::gtest_main)

set_target_properties(
    _test PROPERTIES
    CXX_STANDARD          17
    CXX_EXTENSIONS        OFF
    CXX_STANDARD_REQUIRED YES)

add_test(
    NAME travis_test
    COMMAND _test)