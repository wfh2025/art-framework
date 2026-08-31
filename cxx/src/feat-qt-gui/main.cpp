#include <QDebug>
#include <QGuiApplication>
#include <QWindow>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);

    QWindow window;
    window.setTitle("Qt GUI Test");
    window.resize(400, 300);
    window.show();

    return app.exec();
}