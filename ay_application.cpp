#include <QtQml>
#include "ay_application.h"
#include "ay_qml_settings.h"
#include "ay_system.h"

AtApplication::AtApplication(int argc, char *argv[])
{
     systemInit();
    _app = new QGuiApplication(argc, argv);
    _engine = new QQmlApplicationEngine();
    root = this;

    guiSignal = new AtGuiSignal();
    workThread = AtWorkThread::getInstance();
    workThread->setGuiSignal(guiSignal);
    workThread->start();

    qmlSettings = new AtQmlSettings();

    _engine->rootContext()->setContextProperty("Core", guiSignal);
    _engine->rootContext()->setContextProperty("qmlSettings", qmlSettings);

    _engine->load(QUrl(QStringLiteral("qrc:/view/index.qml")));


}

void AtApplication::systemInit()
{
    AtSystem::setIpAddress();
}

bool AtApplication::isGuiRunning()
{
    return (_app->applicationState() == Qt::ApplicationActive)?true:false;
}

int AtApplication::exec()
{   
    return _app->exec();
}
