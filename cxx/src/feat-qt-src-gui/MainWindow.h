#pragma once
#include <QMainWindow>
#include <QThread>

class QListWidget;
class QLineEdit;
class QPushButton;
class QProgressBar;
class DataWorker;

class MainWindow : public QMainWindow
{
    Q_OBJECT
public:
    explicit MainWindow(QWidget* parent = nullptr);
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