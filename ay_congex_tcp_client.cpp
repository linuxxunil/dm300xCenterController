#include "ay_congex_tcp_client.h"
#include "ay_application.h"

void AtCongexTcpClient::init(int id, QString address, int port)
{
    _id = id;
    _address = address;
    _port = port;
    _socket = NULL;
    connect(this, &AtCongexTcpClient::_write, this, &AtCongexTcpClient::handleWrite);
    connect(this, &AtCongexTcpClient::_connect, this, &AtCongexTcpClient::handleSocketConnect);
    connect(this, &AtCongexTcpClient::_disconnect, this, &AtCongexTcpClient::handleSocketDisconnect);

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
            _mutex.lock();
            _dataTmp = result;
            _mutex.unlock();
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
        _buffer = parseResult(&ok,_buffer);
    }
}

QString AtCongexTcpClient::getData()
{
    _mutex.lock();
    _data = _dataTmp;
    _mutex.unlock();
    return _data;
}

void AtCongexTcpClient::closeSocket()
{
    if ( _socket != NULL ) {
        _socket->abort();
        //_socket->close();
        /* disconnect */
        if ( _socket != NULL ) {
            QObject::disconnect(_socket, SIGNAL(disconnected()), this, SLOT(handleSocketReconnect()));
            QObject::disconnect(_socket, SIGNAL(readyRead()), this ,SLOT(handleSocketReadyRead()));
            _socket = NULL;
        }
    }
}

void AtCongexTcpClient::handleSocketReconnect()
{
    closeSocket();
    _connect();
    //handleSocketConnect();
}

void AtCongexTcpClient::handleSocketDisconnect()
{
    closeSocket();
}

void AtCongexTcpClient::setEnable(bool val)
{
    _enable = val;
    if ( !_enable ) {
        _disconnect();
    } else {
        _connect();
    }
}

void AtCongexTcpClient::handleSocketConnect()
{
    qDebug() << "handleSocketConnect ";

    while (true) {
        if ( !_enable ) return ;

        if ( _socket == NULL ) {
            _isConnected = false;
            _socket = new QTcpSocket(this);
            if ( _socket ) {
                connect(_socket, SIGNAL(disconnected()), this, SLOT(handleSocketReconnect()));
                connect(_socket, SIGNAL(readyRead()), this ,SLOT(handleSocketReadyRead()));
            }
        }

        if ( _socket != NULL && !_socket->isOpen()) {
            _socket->connectToHost(_address, _port);
            if ( _socket->waitForConnected(1000)){
                _isConnected = true;
                while ( !((AtApplication *)root)->isGuiRunning() ) {
                    QThread::sleep(1);
                }

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

int AtCongexTcpClient::getId()
{
    return _id;
}

void AtCongexTcpClient::start()
{
    this->moveToThread(&_thread);
    QObject::connect(&_thread, &QThread::finished, this, &QObject::deleteLater);
    _thread.start();
 }

void AtCongexTcpClient::stop()
{
    _thread.quit();
    _thread.wait();
}

