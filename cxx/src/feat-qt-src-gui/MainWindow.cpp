#include "MainWindow.h"

#include <QHBoxLayout>
#include <QLineEdit>
#include <QListWidget>
#include <QMessageBox>
#include <QProgressBar>
#include <QPushButton>
#include <QVBoxLayout>

#include "DataWorker.h"

MainWindow::MainWindow(QWidget* parent) : QMainWindow(parent), worker(nullptr)
{
    setupUi();

    // 初始化后台工作对象
    worker = new DataWorker();
    worker->moveToThread(&workerThread);

    // 连接工作信号到界面槽
    connect(worker, &DataWorker::progressChanged, this, [this](int current, int total) {
        progressBar->setMaximum(total);
        progressBar->setValue(current);
    });
    connect(worker, &DataWorker::finished, this, &MainWindow::onWorkerFinished);

    // 后台处理完成时，自动退出线程
    connect(worker, &DataWorker::finished, &workerThread, &QThread::quit);
    connect(&workerThread, &QThread::finished, worker, &QObject::deleteLater);
}

MainWindow::~MainWindow()
{
    if (workerThread.isRunning())
    {
        workerThread.quit();
        workerThread.wait();
    }
}

void MainWindow::setupUi()
{
    auto* centralWidget = new QWidget(this);
    auto* mainLayout = new QVBoxLayout(centralWidget);

    // 输入区域
    auto* inputLayout = new QHBoxLayout();
    taskInput = new QLineEdit(this);
    taskInput->setPlaceholderText("请输入任务名称...");
    addButton = new QPushButton("添加", this);
    removeButton = new QPushButton("删除选中", this);
    inputLayout->addWidget(taskInput);
    inputLayout->addWidget(addButton);
    inputLayout->addWidget(removeButton);

    // 列表区域
    taskList = new QListWidget(this);

    // 进度与启动区域
    progressBar = new QProgressBar(this);
    progressBar->setValue(0);
    startButton = new QPushButton("开始处理", this);

    mainLayout->addLayout(inputLayout);
    mainLayout->addWidget(taskList);
    mainLayout->addWidget(progressBar);
    mainLayout->addWidget(startButton);

    setCentralWidget(centralWidget);
    resize(500, 400);
    setWindowTitle("独立复杂用例：任务处理器");

    // 按钮信号槽绑定
    connect(addButton, &QPushButton::clicked, this, &MainWindow::onAddTask);
    connect(removeButton, &QPushButton::clicked, this, &MainWindow::onRemoveTask);
    connect(startButton, &QPushButton::clicked, this, &MainWindow::onStartProcessing);
}

void MainWindow::onAddTask()
{
    QString text = taskInput->text().trimmed();
    if (!text.isEmpty())
    {
        taskList->addItem(text);
        taskInput->clear();
    }
}

void MainWindow::onRemoveTask()
{
    delete taskList->currentItem();
}

void MainWindow::onStartProcessing()
{
    QStringList tasks;
    for (int i = 0; i < taskList->count(); ++i)
    {
        tasks << taskList->item(i)->text();
    }

    if (tasks.isEmpty())
    {
        QMessageBox::information(this, "提示", "没有任务可以处理！");
        return;
    }

    // 禁用界面防止重复点击
    startButton->setEnabled(false);
    addButton->setEnabled(false);
    removeButton->setEnabled(false);
    progressBar->setValue(0);

    // 使用 invokeMethod 跨线程带参数调用槽函数（绕开 connect 的参数匹配限制）
    QMetaObject::invokeMethod(worker, "processTasks", Qt::QueuedConnection, Q_ARG(QStringList, tasks));
    workerThread.start();
}

void MainWindow::onWorkerFinished(const QString& message)
{
    // 恢复界面状态
    progressBar->setValue(progressBar->maximum());
    startButton->setEnabled(true);
    addButton->setEnabled(true);
    removeButton->setEnabled(true);

    QMessageBox::information(this, "完成", message);
}