#include "ay_tcp_server.h"
#include <QTcpSocket>
#include <QSignalMapper>
#include "ay_application.h"
#include "ay_systime.h"
AtTcpServer *AtTcpServer::_instance = 0;
QThread *AtTcpServer::_thread = 0;

void AtTcpServer::init()
{
    //logger.info("AtTcpServer init");
    _server = new QTcpServer(this);
    _server->setMaxPendingConnections(setting.tcpServer.maxClients);

    _readyReadSignalMapper = new QSignalMapper(this);
    _disconnectedSignalMapper = new QSignalMapper(this);

    connect( _server, &QTcpServer::newConnection, this, &AtTcpServer::handleClientNewConnection);
    connect(_readyReadSignalMapper, SIGNAL(mapped(QObject*)), this, SLOT(handleClientReadyRead(QObject*)));
    connect(_disconnectedSignalMapper, SIGNAL(mapped(QObject*)), this, SLOT(handleClientDisconnect(QObject*)));
    connect(this, &AtTcpServer::_sendClients, this, &AtTcpServer::handleSendClients);
    bool status ;
    if ( setting.tcpServer.bindAddress == "any" ) {
        status = _server->listen(QHostAddress::Any, setting.tcpServer.port);
    } else {
        QHostAddress host(setting.tcpServer.bindAddress);
        status = _server->listen(host, setting.tcpServer.port);
    }
}

void AtTcpServer::sendClients(QString message)
{
    _sendClients(message);
}


void AtTcpServer::handleClientNewConnection()
{

    qDebug() << "handleClientNewConnection";
    QTcpSocket *client = _server->nextPendingConnection();
    if (!client) {
        return;
    } else if ( _clients.size() >= setting.tcpServer.maxClients ) {
        client->close();
    } else {
        _clients.append(client);

        connect(client, SIGNAL(readyRead()), _readyReadSignalMapper, SLOT(map()));
        _readyReadSignalMapper->setMapping(client, client);

        connect(client, SIGNAL(disconnected()), _disconnectedSignalMapper, SLOT(map()));
        _disconnectedSignalMapper->setMapping(client, client);
    }
}


void AtTcpServer::handleClientReadyRead(QObject *socketObject)
{
    qDebug() << "handleSocketReadyRead";
    QTcpSocket *socket = qobject_cast<QTcpSocket *>(socketObject);
    int index;
    if (!socket || !socket->bytesAvailable() ) {
        return;
    } else {
        index = _clients.indexOf(socket);

        if ( index >= 0 ) {
            bool ok;
            QString command = socket->readAll();
            if ( command == setting.general.userRequest + setting.general.userRequestEndingSymbol) {
                QHostAddress ipv4Address(socket->localAddress().toIPv4Address());
                QString address = ipv4Address.toString();

                AtCongexTcpClient *congexClient =
                        ((AtApplication *)root)->workThread->list[address];

                if ( congexClient != NULL ) {
                    QString data = congexClient->getData();
//                    qDebug() << "Id : " << congexClient->getId();
//                    qDebug() << "   Data = " <<  data;
                    if ( data != "" && data != setting.general.deviceNoRead ) {
                        data += setting.general.userResponseEndingSymbol;
                        socket->write(data.toUtf8());
                    }
                    ((AtApplication *)root)->guiSignal->guiUserRequstTimeChanged(congexClient->getId(),SysTime::getDateTime());
                }
                } else {
                    qDebug() << "This address don't support.";
                }

        } else {
            qDebug() << "The client don't exists";
        }
    }
}

void AtTcpServer::handleSendClients(QString message)
{
    if ( _clients.size() > 0 ) {
        foreach(QTcpSocket *client, _clients) {
            client->write(message.toUtf8());
        }
    }
}

void AtTcpServer::handleClientDisconnect(QObject *socketObject)
{
    QTcpSocket *client = qobject_cast<QTcpSocket *>(socketObject);

    if (!client) {
        return;
    }
    _clients.removeOne(client);

    qDebug() << QString("Client %1:%2 has disconnected.")
                .arg(qPrintable(client->peerAddress().toString()))
                .arg(client->peerPort());
    client->deleteLater();
}


void AtTcpServer::start()
{
    _instance->moveToThread(_thread);
    QObject::connect(_thread, &QThread::finished, _instance, &QObject::deleteLater);
    _thread->start();
 }

void AtTcpServer::stop()
{
    _thread->quit();
    _thread->wait();
}
