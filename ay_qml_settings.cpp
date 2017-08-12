#include "ay_qml_settings.h"
#include "ay_application.h"
#include "ay_congex_tcp_client.h"


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

    for (int i=0; i<setting.profile.configsArray.size(); i++ ) {
        QJsonObject configsObj = setting.profile.configsArray[i].toObject();


        AtCongexTcpClient *client = ((AtApplication*) root)->workThread->list[configsObj["serviceIp"].toString()];
        client->setEnable(configsObj["enable"].toBool());
    }
}
