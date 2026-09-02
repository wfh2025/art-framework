#pragma once
#include <QObject>
#include <QStringList>

class DataWorker : public QObject
{
    Q_OBJECT
public:
    explicit DataWorker(QObject* parent = nullptr);

public slots:
    void processTasks(const QStringList& tasks);

signals:
    void progressChanged(int current, int total);
    void finished(const QString& message);
};