#include "ay_congex_tcp_client.h"
#include "ay_application.h"

void AtCongexTcpClient::init(int id, QString address, int port)
{
    _id = id;
    _address = address;
    _port = port;
    _socket = NULL;
    connect(this, &AtCongexTcpClient::_write, this, &AtCongexTcpClient::handleWrite);
}

void AtCongexTcpClient::write(QString message)
{
    _write(message);
}

QString AtCongexTcpClient::parseResult(bool *ok, QString data)
{
    QStringList strList;
    int len;
    *ok = false;

    int count = data.count(setting.general.deviceEndingSymbol);
    if ( count > 0 ) {
        *ok = true;
        strList = data.split(setting.general.deviceEndingSymbol,QString::SkipEmptyParts);
        len = strList.length();


        if ( len > 0 ) {
            QString result;
            for ( int i=0; i<count; i++ ) {
                 result = strList.at(i);
                ((AtApplication *)root)->guiSignal->guiSnChanged(_id, result);
            }
            _data = result;
        }

        if ( data.endsWith(setting.general.deviceEndingSymbol) ) {
            data = "";
        } else {
            if ( len > 0 ) {
                data = strList[len-1];
            } else {
                data = "";
            }
        }
    }

    return data;
}

void AtCongexTcpClient::handleSocketReadyRead()
{
    if (!_socket || !_socket->bytesAvailable()) {
        return;
    } else {
        bool ok;
        _buffer += _socket->readAll();
        qDebug() << "GetData=" << _buffer;
        ((AtApplication *)root)->guiSignal->guiSnChanged(_id, _buffer);
        //_buffer = parseResult(&ok, _buffer);
    }
}

QString AtCongexTcpClient::getData()
{

    return _buffer;
}

void AtCongexTcpClient::handleSocketDisconnect()
{
    _socket->abort();
    _socket->close();

    /* disconnect */
    if ( _socket != NULL ) {
        QObject::disconnect(_socket, SIGNAL(disconnected()), this, SLOT(handleSocketDisconnect()));
        QObject::disconnect(_socket, SIGNAL(readyRead()), this ,SLOT(handleSocketReadyRead()));
        _socket = NULL;
    }

    handleSocketConnect();
}

void AtCongexTcpClient::handleSocketConnect()
{
    qDebug() << "handleSocketConnect ";
    while (true) {
        if ( _socket == NULL ) {
            isConnected = false;
            _socket = new QTcpSocket(this);
            if ( _socket ) {
                connect(_socket, SIGNAL(disconnected()), this, SLOT(handleSocketDisconnect()));
                connect(_socket, SIGNAL(readyRead()), this ,SLOT(handleSocketReadyRead()));
            }
        }

        if ( _socket != NULL ) {
            _socket->connectToHost(_address, _port);

            if ( _socket->waitForConnected(1000)){
                ((AtApplication *)root)->guiSignal->guiStatusChanged(_id, true);
                qDebug() << "Success .(" + _address + ":" + QString::number(_port,10) + ") ";
                break;
            }
            qDebug() << "Failure .(" + _address + ":" + _port + ") ";
            ((AtApplication *)root)->guiSignal->guiStatusChanged(_id, false);
        }
        QThread::msleep(1000);
    }
}

void AtCongexTcpClient::handleWrite(QString message)
{
    qDebug() << "handleSendToMaster : " << message;

    _socket->write(message.toUtf8());
    _socket->flush();
}

void AtCongexTcpClient::start()
{
    this->moveToThread(&_thread);
    QObject::connect(&_thread, &QThread::started, this, &AtCongexTcpClient::handleSocketConnect);
    QObject::connect(&_thread, &QThread::finished, this, &QObject::deleteLater);
    _thread.start();
 }

void AtCongexTcpClient::stop()
{
    _thread.quit();
    _thread.wait();
}

