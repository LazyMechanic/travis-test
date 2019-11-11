#pragma warning(push)
// Disable gtest warnings
#pragma warning(disable : 26495)
#pragma warning(disable : 26812)

#include <gtest/gtest.h>
#include "../src/travis-test/lib.h"

TEST(Test, Test)
{
    EXPECT_EQ(always_return_true(), true);
    ASSERT_EQ(always_return_true(), true);
}

#pragma warning(pop)