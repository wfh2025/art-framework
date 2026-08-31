#include <QCoreApplication>
#include <QDebug>
#include <QtGlobal>

int main(int argc, char* argv[])
{
    QCoreApplication app(argc, argv);

    qInfo() << "Qt Version:" << QT_VERSION_STR;
    qInfo() << "Running on:" << QSysInfo::prettyProductName();

    // 验证核心库功能：使用 QString
    QString message = "Qt Core works!";
    qInfo() << message;

    return 0;
}