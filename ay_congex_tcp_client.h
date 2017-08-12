#ifndef AY_CONGEX_TCP_CLIENT_H
#define AY_CONGEX_TCP_CLIENT_H

#include "ay_controller.h"
#include <QTcpSocket>
#include <QThread>
#include <QObject>

class AtCongexTcpClient : public AtController
{
    Q_OBJECT

private :
    QTcpSocket *_socket;
    QString _buffer;
    QString _data;
    QThread _thread;
    QString _address;
    int _port;
    int _id;
    bool isConnected = false;
    //QMutex mutex;

public:
    AtCongexTcpClient(int id, QString address, int port) {
        init(id, address, port);
    }

    void init(int id, QString address, int port);
    void start();
    void stop();
    void write(QString message);
    QString getData();
    QString parseResult(bool *ok ,QString data);

signals:
    void _write(QString message);

private slots:
    void handleSocketConnect();
    void handleSocketReadyRead();
    void handleSocketDisconnect();

public slots:
    void handleWrite(QString message);
};
#endif // AY_CONGEX_TCP_CLIENT_H
