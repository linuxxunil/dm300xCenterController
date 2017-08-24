#ifndef AY_CONGEX_TCP_CLIENT_H
#define AY_CONGEX_TCP_CLIENT_H

#include "ay_controller.h"
#include <QTcpSocket>
#include <QThread>
#include <QObject>
#include <QTimer>
class AtCongexTcpClient : public AtController
{
    Q_OBJECT

private :
    QTcpSocket *_socket;
    QString _buffer;
    QString _data, _dataTmp;
    QThread _thread;
    QString _address;
    QString _modelName;
    QTimer _timer;
    int _port;
    int _id;
    bool _isConnected = false;
    QMutex _mutex;
    bool _enable = true;

    void _setSockKeepAlive(int fds);

public:
    AtCongexTcpClient(bool enable, QString modelName, int id, QString address, int port) {
        init(enable, modelName, id, address, port);
    }

    void init(bool enable ,QString modelName, int id, QString address, int port);
    void start();
    void stop();
    void write(QString message);
    QString getData();
    QString parseResult(bool *ok ,QString data);
    int getId();
    void setEnable(bool val);
    void closeSocket();

signals:
    void _write(QString message);
    void _connect();
    void _disconnect();

private slots:
    void handleSocketConnect();
    void handleSocketReadyRead();
    void handleSocketReconnect();
    void handleSocketDisconnect();
    void handleSocketState();

public slots:
    void handleWrite(QString message);
};
#endif // AY_CONGEX_TCP_CLIENT_H
