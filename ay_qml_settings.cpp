#include "ay_qml_settings.h"
#include "ay_application.h"
#include "ay_congex_tcp_client.h"
#include "ay_system.h"


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

/* General */
QString AtQmlSettings::getGeneralDeviceEndingSymbol()
{
    return setting.general.deviceEndingSymbol;
}

void AtQmlSettings::setGeneralDeviceEndingSymbol(QString val)
{
    val.replace("\\r", "\r" ).replace("\\n","\n");
    setting.general.deviceEndingSymbol = val;
    setting.general.sync();
}


QString AtQmlSettings::getGeneralDeviceNoRead()
{
    return setting.general.deviceNoRead;
}

void AtQmlSettings::setGeneralDeviceNoRead(QString val)
{
    setting.general.deviceNoRead = val;
    setting.general.sync();
}

QString AtQmlSettings::getGeneralUserEndingSymbol()
{
    return setting.general.userEndingSymbol;
}

void AtQmlSettings::setGeneralUserEndingSymbol(QString val)
{
    val.replace("\\r", "\r" ).replace("\\n","\n");
    setting.general.userEndingSymbol = val;
    setting.general.sync();
}

QString AtQmlSettings::getGeneralUserRequest()
{
    return setting.general.userRequest;
}

void AtQmlSettings::setGeneralUserRequest(QString val)
{
    setting.general.userRequest = val;
    setting.general.sync();
}


/* Network */
QString AtQmlSettings::getNicType()
{
    //logger.debug("getNicType");
    return setting.nic.nicType;
}

void AtQmlSettings::setNicType(QString val)
{
    //logger.debug("setNicType");
    setting.nic.nicType = val;
    setting.nic.sync();
}

QString AtQmlSettings::getNicAddress()
{
    //logger.debug("getNicAddress"+setting.nic.nicAddress);
    return setting.nic.nicAddress;
}

void AtQmlSettings::setNicAddress(QString val)
{
    //logger.debug("setNicAddress"+val);
    setting.nic.nicAddress = val;
    setting.nic.sync();
}

QString AtQmlSettings::getNicNetmask()
{
    //logger.debug("getNicNetmask");
    return setting.nic.nicNetmask;
}

void AtQmlSettings::setNicNetmask(QString val)
{
    //logger.debug("setNicNetmask");
    setting.nic.nicNetmask = val;
    setting.nic.sync();
}

QString AtQmlSettings::getNicGateway()
{
    return setting.nic.nicGateway;
}

void AtQmlSettings::setNicGateway(QString val)
{
    setting.nic.nicGateway = val;
    setting.nic.sync();
}

QString AtQmlSettings::getNicDNS1()
{
    return setting.nic.nicDns1;
}

void AtQmlSettings::setNicDNS1(QString val)
{
    setting.nic.nicDns1 = val;
    setting.nic.sync();
}

/* System */
QString AtQmlSettings::getSystemHardwareVersion()
{
    return setting.version.hardwareVersion;
}

QString AtQmlSettings::getSystemSoftwareVersion()
{
    return setting.version.softwareVersion;
}

QString AtQmlSettings::getSystemDescription()
{
   return setting.version.description;
}

bool AtQmlSettings::execSystemReboot()
{
    return AtSystem::execReboot();
}

bool AtQmlSettings::execSystemShutdown()
{
    return AtSystem::execShutdown();
}

bool AtQmlSettings::execSystemAppRestart()
{
    return AtSystem::execAppRestart();
}

bool AtQmlSettings::execSystemResetDefault()
{
    return AtSystem::execResetDefault();
}


void AtQmlSettings::execSystemSysUpgrade(QString val)
{
    AtSystem::execUpgrade(val);
    //AtSystem::execUpgrade(val);
}

QStringList AtQmlSettings::getSystemListUpgradeImages()
{
    return AtSystem::getUpgradeImages();
}

/* Tcp Server */
int AtQmlSettings::getTcpServerPort()
{
    return setting.tcpServer.port;
}
void AtQmlSettings::setTcpServerPort(int val)
{
    setting.tcpServer.port = val;
    setting.tcpServer.sync();
}

int AtQmlSettings::getTcpServerMaxClients()
{
    return setting.tcpServer.maxClients;
}

void AtQmlSettings::setTcpServerMaxClients(int val)
{
    setting.tcpServer.maxClients = val;
    setting.tcpServer.sync();
}
