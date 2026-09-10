#include <QApplication>

#include "MainWindow.h"

static void initLog()
{
    spdlog::set_pattern("[%Y-%m-%d %H:%M:%S.%e] [%P] [%t] [%s:%#] [%^%l%$] %v");
    spdlog::set_level(spdlog::level::debug);
}

int main(int argc, char* argv[])
{
    initLog();
    QApplication app(argc, argv);
    MainWindow w(nullptr);
    w.show();
    return app.exec();
}