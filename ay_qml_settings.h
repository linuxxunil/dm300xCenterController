#ifndef AY_QML_SETTINGS_H
#define AY_QML_SETTINGS_H

#include "ay_controller.h"
#include "ay_application.h"


class AtQmlSettings : public AtController
{
    Q_OBJECT

    Q_PROPERTY(QString profileConfigs READ getProfileConfigs WRITE setProfileConfigs NOTIFY changedProfileConfigs)


public :
    AtQmlSettings();
private :
    QString getProfileConfigs();
    void setProfileConfigs(QString val);

signals :
    void changedProfileConfigs();

};

#endif // AY_QML_SETTINGS_H
