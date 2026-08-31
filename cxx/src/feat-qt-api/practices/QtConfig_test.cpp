#include <QtConfig>

#include "testcase_wrap.hpp"

TEST(QtConfig, 001)
{
    SPDLOG_INFO("{}", QT_VERSION_STR);
}