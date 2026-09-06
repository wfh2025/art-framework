#include "mainwindow.h"

#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget* parent) : QMainWindow(parent), ui(new Ui::MainWindow)
{
    ui->setupUi(this); // 这行代码会把你在 Designer 里拖的界面加载进来
}

MainWindow::~MainWindow()
{
    delete ui;
}