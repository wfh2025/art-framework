#include "DataWorker.h"

#include <QObject>
#include <QStringList>
#include <QThread>

DataWorker::DataWorker(QObject* parent) : QObject(parent) {}

void DataWorker::processTasks(const QStringList& tasks)
{
    int total = tasks.size();
    for (int i = 0; i < total; ++i)
    {
        QThread::msleep(200); // 模拟耗时
        emit progressChanged(i + 1, total);
    }
    emit finished("后台处理完成！共处理了 " + QString::number(total) + " 个任务。");
}