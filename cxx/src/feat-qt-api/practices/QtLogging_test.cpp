#include <QDebug>
#include <QtLogging>

#include "testcase_wrap.hpp"

TEST(QtLogging, 001)
{
    qInfo() << "Hello World";
}