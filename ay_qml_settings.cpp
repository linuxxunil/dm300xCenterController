#include "ay_qml_settings.h"
#include "ay_application.h"


AtQmlSettings::AtQmlSettings()
{

}

QString AtQmlSettings::getProfileConfigs()
{
    return setting.profile.configs;
}

void AtQmlSettings::setProfileConfigs(QString val)
{
    setting.profile.configs = val;
    setting.profile.sync();
}
