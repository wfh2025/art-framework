#pragma once
#include <spdlog/spdlog.h>

#include <QLineEdit>
#include <QListWidget>
#include <QMainWindow>
#include <QProgressBar>
#include <QPushButton>
#include <QThread>

#include "DataWorker.h"

class MainWindow : public QMainWindow
{
    Q_OBJECT
public:
    explicit MainWindow(QWidget* parent);
    ~MainWindow();

private slots:
    void onAddTask();
    void onRemoveTask();
    void onStartProcessing();
    void onWorkerFinished(const QString& message);

private:
    void setupUi();

    // UI 组件
    QListWidget* taskList;
    QLineEdit* taskInput;
    QPushButton* addButton;
    QPushButton* removeButton;
    QPushButton* startButton;
    QProgressBar* progressBar;

    // 后台线程与工作对象
    QThread workerThread;
    DataWorker* worker;
};