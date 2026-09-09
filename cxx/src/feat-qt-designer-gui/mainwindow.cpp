#include "mainwindow.h"

MainWindow::MainWindow(QWidget* parent) : QMainWindow(parent), ui(new Ui::MainWindowA)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}