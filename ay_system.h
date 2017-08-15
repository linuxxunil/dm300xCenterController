#ifndef AY_UPGRADE_H
#define AY_UPGRADE_H

#include "ay_controller.h"
#include <QProcess>
#include <QHash>

class AtSystem : public AtController
{
    Q_OBJECT

private :
    AtSystem(){}
    ~AtSystem(){}
    static QProcess *_process;
    static QString _key;//"http://www.ateam.com.cn";

public:
    static void execUpgrade(QString val);
    static bool execReboot();
    static bool execShutdown();
    static bool execAppRestart();
    static bool execResetDefault();
    static QStringList getUpgradeImages();
    static bool writeLog(QString text);
    static bool setSystemDate(QString val);
    static bool setSystemTime(QString val);
    static bool setSystemDateTime(QString val);
    static bool execSetTcpRecycle();
    static bool execSetTcpReuse();
    static bool setIpAddress();
};

#endif // AY_UPGRADE_H
