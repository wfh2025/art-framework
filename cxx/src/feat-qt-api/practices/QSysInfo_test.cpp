#include <QString>
#include <QSysInfo>

#include "testcase_wrap.hpp"

TEST(QSysInfo, 001)
{
    SPDLOG_INFO("{}", QSysInfo::prettyProductName().toStdString());
}