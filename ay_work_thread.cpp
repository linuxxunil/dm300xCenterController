#include "ay_work_thread.h"


AtWorkThread *AtWorkThread::_instance = 0;
QThread *AtWorkThread::_thread = 0;


void AtWorkThread::init()
{
    server = AtTcpServer::getInstance();
    server->start();

    for (int i=0; i<setting.profile.configsArray.size(); i++ ) {
        QJsonObject configsObj = setting.profile.configsArray[i].toObject();

        AtCongexTcpClient *client = new AtCongexTcpClient(configsObj["enable"].toBool(),i,
                    configsObj["deviceIp"].toString(),configsObj["devicePort"].toInt());
        qDebug() << "ServiceIp[" + QString::number(i,10) + "]=" +  configsObj["deviceIp"].toString() + ":" + configsObj["devicePort"].toString();
        client->start();
        list[configsObj["serviceIp"].toString()] = client;
    }
}

void AtWorkThread::setGuiSignal(AtGuiSignal *val)
{
    guiSignal = val;
}

void AtWorkThread::start()
{
    _instance->moveToThread(_thread);
    QObject::connect(_thread, &QThread::finished, _instance, &QObject::deleteLater);
    _thread->start();
 }

void AtWorkThread::stop()
{
    _thread->quit();
    _thread->wait();
}

