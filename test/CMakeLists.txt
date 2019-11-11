find_package(GTest CONFIG REQUIRED)

add_executable(_test 
    "test.cpp")

target_link_libraries(
    _test
    travis-test
    GTest::gtest
    GTest::gtest_main)

add_test(
    NAME travis_test
    COMMAND _test)