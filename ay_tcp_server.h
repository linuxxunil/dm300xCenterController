#ifndef AY_TCP_SERVER_H
#define AY_TCP_SERVER_H
#include "ay_controller.h"
#include <QTcpServer>
#include <QThread>
#include <QSignalMapper>

class AtTcpServer : public AtController
{
    Q_OBJECT

private :
    AtTcpServer() {}
    ~AtTcpServer(){}
    static AtTcpServer *_instance;
    static QThread *_thread;
    const AtTcpServer& operator=(const AtTcpServer&);
    QTcpServer *_server;
    QList<QTcpSocket*> _clients;
    QSignalMapper *_readyReadSignalMapper;
    QSignalMapper *_disconnectedSignalMapper;
    static int count;

public:
    static AtTcpServer *getInstance() {
       if ( !_instance ) {
           _instance = new AtTcpServer();
           _thread = new QThread();
           _instance->init();
       }
       return _instance;
    }

    void init();
    void start();
    void stop();
    void sendClients(QString message);

signals :
    void _sendClients(QString message);

private slots:
    void handleClientNewConnection();
    void handleClientReadyRead(QObject *socketObject);
    void handleClientDisconnect(QObject *socketObject);

public slots:
    void handleSendClients(QString msg);
};

#endif // AY_TCP_SERVER_H
