#include "ay_congex_tcp_client.h"
#include "ay_application.h"
#include "ay_systime.h"
#include "ay_system.h"
#include <sys/types.h>          /* See NOTES */
#include <sys/socket.h>
#include <netinet/tcp.h>

void AtCongexTcpClient::init(bool enable ,QString modelName, int id, QString address, int port)
{
    _id = id;
    _address = address;
    _port = port;
    _socket = NULL;
    _enable = enable;
    _modelName = modelName;
    connect(this, &AtCongexTcpClient::_write, this, &AtCongexTcpClient::handleWrite);
    connect(this, &AtCongexTcpClient::_connect, this, &AtCongexTcpClient::handleSocketConnect);
    connect(this, &AtCongexTcpClient::_disconnect, this, &AtCongexTcpClient::handleSocketDisconnect);
//    _timer.setInterval(1000);
//    connect(&_timer, &QTimer::timeout, this, &AtCongexTcpClient::handleSocketState);
//    _timer.start();
}

void AtCongexTcpClient::handleSocketState()
{

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

            QString dateTime;
            for ( int i=0; i<count; i++ ) {
                _mutex.lock();
                _dataTmp = strList.at(i);
                dateTime = SysTime::getDateTime();
                AtSystem::writeLog(QString(setting.cifs.logFormat)
                                            .arg(_modelName)
                                            .arg(dateTime)
                                            .arg(_dataTmp));
                _mutex.unlock();
                ((AtApplication *)root)->guiSignal->guiSnChanged(_id, _dataTmp, dateTime);

            }
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
    qDebug() << "closeSocket";

    if ( _socket != NULL ) {
        _socket->abort();
        _socket->close();
        /* disconnect */
        if ( _socket != NULL ) {
            QObject::disconnect(_socket, SIGNAL(disconnected()), this, SLOT(handleSocketReconnect()));
            QObject::disconnect(_socket, SIGNAL(readyRead()), this ,SLOT(handleSocketReadyRead()));
            _socket = NULL;
        }
        ((AtApplication *)root)->guiSignal->guiStatusChanged(_id, false);
    }
}

void AtCongexTcpClient::handleSocketReconnect()
{
    closeSocket();
    _connect();
}

void AtCongexTcpClient::handleSocketDisconnect()
{
    closeSocket();
}

void AtCongexTcpClient::setEnable(bool val)
{
    if ( _enable != val ) {
        if ( val ) _connect();
        else _disconnect();
    }
    _enable = val;
}

void AtCongexTcpClient::_setSockKeepAlive(int fd)
{
    int enableKeepAlive = setting.tcpClient.keepAliveEnable;
    setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, &enableKeepAlive, sizeof(enableKeepAlive));
    int maxIdle = setting.tcpClient.keepAliveMaxIdle;/* seconds */
    setsockopt(fd, SOL_TCP, TCP_KEEPIDLE, &maxIdle, sizeof(maxIdle));
    int count = setting.tcpClient.keepAliveCount;//send up to 3 keepalive packets out, then disconnect if no response
    setsockopt(fd, SOL_TCP, TCP_KEEPCNT, &count, sizeof(count));
    int interval = setting.tcpClient.keepAliveInterval;//send a keepalive packet out every 2 seconds (after the 5 second idle period)
    setsockopt(fd, SOL_TCP, TCP_KEEPINTVL, &interval, sizeof(interval));
}

void AtCongexTcpClient::handleSocketConnect()
{
    qDebug() << "handleSocketConnect ";

    while (true) {
        qDebug() << "id=" << _id << "enable=" << _enable;
        if ( !_enable )  return ;

        if ( _socket == NULL ) {
            _isConnected = false;
            _socket = new QTcpSocket(this);

            if ( _socket ) {
                connect(_socket, SIGNAL(disconnected()), this, SLOT(handleSocketReconnect()));
                connect(_socket, SIGNAL(readyRead()), this ,SLOT(handleSocketReadyRead()));
            }
        }

        if ( _socket != NULL ) {
            _socket->connectToHost(_address, _port);

            if ( _socket->waitForConnected(1000)){
                _isConnected = true;
                while ( !((AtApplication *)root)->isGuiRunning() ) {
                    QThread::sleep(1);
                }
                _setSockKeepAlive(_socket->socketDescriptor());

                ((AtApplication *)root)->guiSignal->guiStatusChanged(_id, true);
                qDebug() << "Success .(" + _address + ":" + QString::number(_port,10) + ") ";
                break;
            }
            qDebug() << "Failure .(" + _address + ":" + QString::number(_port,10) + ") ";
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
    if ( _enable ) {
        QObject::connect(&_thread, &QThread::started, this, &AtCongexTcpClient::handleSocketConnect);
    }
    QObject::connect(&_thread, &QThread::finished, this, &QObject::deleteLater);
    _thread.start();
 }

void AtCongexTcpClient::stop()
{
    _thread.quit();
    _thread.wait();
}

