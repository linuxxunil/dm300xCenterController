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
        if ( client != NULL ) {
            client->setEnable(configsObj["enable"].toBool());
        }
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

QString AtQmlSettings::getGeneralUserRequestEndingSymbol()
{
    return setting.general.userRequestEndingSymbol;
}

void AtQmlSettings::setGeneralUserRequestEndingSymbol(QString val)
{
    setting.general.userRequestEndingSymbol = val;
    setting.general.sync();
}

QString AtQmlSettings::getGeneralUserResponseEndingSymbol()
{
    return setting.general.userResponseEndingSymbol;
}

void AtQmlSettings::setGeneralUserResponseEndingSymbol(QString val)
{
    setting.general.userResponseEndingSymbol = val;
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

void AtQmlSettings::setSystemDate(QString val)
{
    AtSystem::setSystemDate(val);
//    QStringList date = val.split("/");
//    AtRtc::setDate(QString::number(((QString)date[0]).right(2),10),
//                   QString::number(date[1],10),
//                   QString::number(date[2],10));
}

void AtQmlSettings::setSystemTime(QString val)
{
    AtSystem::setSystemTime(val);
//    QStringList time = val.split(":");
//    AtRtc::setDate(QString::number(time[0],10),
//                   QString::number(time[1],10),
//                   QString::number(time[2],10));
}

QString AtQmlSettings::getSystemNtpServer()
{
    return setting.system.ntpServer;
}

void AtQmlSettings::setSystemNtpServer(QString val)
{
    setting.system.ntpServer = val;
    setting.system.sync();
    AtSystem::setNtpServer(val);
}

bool AtQmlSettings::getSystemEnableNtp()
{
    return setting.system.ntpEnable;
}

void AtQmlSettings::setSystemEnableNtp(bool val)
{
    if ( val ) AtSystem::execStartNtp();
    else AtSystem::execStopNtp();
    setting.system.ntpEnable = val;
    setting.system.sync();
}


bool AtQmlSettings::execSystemStartNtp()
{
    return AtSystem::execStartNtp();
}

bool AtQmlSettings::execSystemStopNtp()
{
    return AtSystem::execStopNtp();
}

bool AtQmlSettings::execSystemMountCifs()
{
    return AtSystem::execMountCifs();
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

/* Cifs */
bool AtQmlSettings::getCifsEnable()
{
    return setting.cifs.enable;
}

void AtQmlSettings::setCifsEnable(bool val)
{
    setting.cifs.enable = val;
    setting.cifs.sync();
}

int AtQmlSettings::getCifsMode()
{
    return setting.cifs.mode;
}

void AtQmlSettings::setCifsMode(int val)
{
    setting.cifs.mode = val;
    setting.cifs.sync();
}

QString AtQmlSettings::getCifsAddress()
{
    return setting.cifs.address;
}

void AtQmlSettings::setCifsAddress(QString val)
{
    setting.cifs.address = val;
    setting.cifs.sync();
}

QString AtQmlSettings::getCifsUsername()
{
    return setting.cifs.username;
}

void AtQmlSettings::setCifsUsername(QString val)
{
    setting.cifs.username = val;
    setting.cifs.sync();
}

QString AtQmlSettings::getCifsPassword()
{
    return setting.cifs.password;
}

void AtQmlSettings::setCifsPassword(QString val)
{
    setting.cifs.password = val;
    setting.cifs.sync();
}


QString AtQmlSettings::getCifsMountPath()
{
    return setting.cifs.mountPath;
}

void AtQmlSettings::setCifsMountPath(QString val)
{
    setting.cifs.mountPath = val;
    setting.cifs.sync();
}

QString AtQmlSettings::getCifsLogFormat()
{
    return setting.cifs.logFormat;
}

void AtQmlSettings::setCifsLogFormat(QString val)
{
    setting.cifs.logFormat = val;
    setting.cifs.sync();
}
