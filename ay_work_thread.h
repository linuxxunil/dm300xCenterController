#ifndef AY_WORK_THREAD_H
#define AY_WORK_THREAD_H
#include <QThread>
#include <QHash>
#include "ay_controller.h"
#include "ay_gui_signal.h"
#include "ay_tcp_server.h"
#include "ay_congex_tcp_client.h"


class AtWorkThread : public AtController
 {
    Q_OBJECT

public:
    QHash<QString, AtCongexTcpClient*> list;


private :
    AtWorkThread(){}
    ~AtWorkThread(){}
    static AtWorkThread *_instance;
    static QThread *_thread;
    const AtWorkThread& operator=(const AtWorkThread&);
    AtGuiSignal *guiSignal = NULL;

    AtTcpServer *server = NULL;


public:
    static AtWorkThread *getInstance() {
       if ( !_instance ) {
           _instance = new AtWorkThread();
           _thread = new QThread();
           _instance->init();
       }
       return _instance;
    }

    void init();
    void start();
    void stop();
    void setGuiSignal(AtGuiSignal *val);



signals:

public slots:
};

#endif // AY_WORK_THREAD_H
