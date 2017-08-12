#ifndef AY_APPLICATION_H
#define AY_APPLICATION_H


#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "ay_controller.h"
#include "ay_work_thread.h"
#include "ay_qml_settings.h"
#include "ay_gui_signal.h"

class AtQmlSettings;

class AtApplication : public AtController
{
private :
    QGuiApplication *_app;
    QQmlApplicationEngine *_engine;
    bool initGuiFinished = false;
    void systemInit();

public :
    AtApplication(int argc, char *argv[]);
    AtWorkThread *workThread;
    AtQmlSettings *qmlSettings;
    AtGuiSignal *guiSignal;

    bool isGuiRunning();
    int exec() ;
};
#endif // AY_APPLICATION_H
