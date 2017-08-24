#ifndef AY_QML_SETTINGS_H
#define AY_QML_SETTINGS_H

#include "ay_controller.h"
#include "ay_application.h"


class AtQmlSettings : public AtController
{
    Q_OBJECT

    /* Profile */
    Q_PROPERTY(QString profileConfigs READ getProfileConfigs WRITE setProfileConfigs NOTIFY changedProfileConfigs)

    /* General */
    Q_PROPERTY(QString generalDeviceNoRead READ getGeneralDeviceNoRead WRITE setGeneralDeviceNoRead NOTIFY changedGeneralDeviceNoRead)
    Q_PROPERTY(QString generalDeviceEndingSymbol READ getGeneralDeviceEndingSymbol WRITE setGeneralDeviceEndingSymbol NOTIFY changedGeneralDeviceEndingSymbol)
    Q_PROPERTY(QString generalUserRequest READ getGeneralUserRequest WRITE setGeneralUserRequest NOTIFY changedGeneralUserRequest)
    Q_PROPERTY(QString generalUserRequestEndingSymbol READ getGeneralUserRequestEndingSymbol WRITE setGeneralUserRequestEndingSymbol NOTIFY changedGeneralUserRequestEndingSymbol)
    Q_PROPERTY(QString generalUserResponseEndingSymbol READ getGeneralUserResponseEndingSymbol WRITE setGeneralUserResponseEndingSymbol NOTIFY changedGeneralUserResponseEndingSymbol)

    /* Nic */
    Q_PROPERTY(QString nicType READ getNicType WRITE setNicType NOTIFY changedNicType)
    Q_PROPERTY(QString nicAddress READ getNicAddress WRITE setNicAddress NOTIFY changedNicAddress)
    Q_PROPERTY(QString nicNetmask READ getNicNetmask WRITE setNicNetmask NOTIFY changedNicNetmask)
    Q_PROPERTY(QString nicGateway READ getNicGateway WRITE setNicGateway NOTIFY changedNicGateway )
    Q_PROPERTY(QString nicDNS1 READ getNicDNS1 WRITE setNicDNS1 NOTIFY changedNicDNS1)

    /* System */
    Q_PROPERTY(QString systemHardwareVersion READ getSystemHardwareVersion NOTIFY changedSystemHardwareVersion)
    Q_PROPERTY(QString systemSoftwareVersion READ getSystemSoftwareVersion NOTIFY changedSystemSoftwareVersion)
    Q_PROPERTY(QString systemDescription READ getSystemDescription NOTIFY changedSystemDescription)
    Q_PROPERTY(bool systemReboot READ execSystemReboot )
    Q_PROPERTY(bool systemShutdown READ execSystemShutdown )
    Q_PROPERTY(bool systemAppRestart READ execSystemAppRestart )
    Q_PROPERTY(bool systemResetDefault READ execSystemResetDefault)
    Q_PROPERTY(QString systemSysUpgrade WRITE execSystemSysUpgrade NOTIFY changedSystemSysUpgrade)
    Q_PROPERTY(QStringList systemListUpgradeImages READ getSystemListUpgradeImages NOTIFY changedSystemListUpgradeImages)
    Q_PROPERTY(QString systemDate WRITE setSystemDate NOTIFY changedSystemDate)
    Q_PROPERTY(QString systemTime WRITE setSystemTime NOTIFY changedSystemTime)
    Q_PROPERTY(QString systemNtpServer READ getSystemNtpServer WRITE setSystemNtpServer NOTIFY changedSystemNtpServer)
    Q_PROPERTY(bool systemEnableNtp READ getSystemEnableNtp WRITE setSystemEnableNtp NOTIFY changedSystemEnableNtp)
    Q_PROPERTY(bool systemStartNtp READ execSystemStartNtp)
    Q_PROPERTY(bool systemStopNtp READ execSystemStopNtp)
    Q_PROPERTY(bool systemMountCifs READ execSystemMountCifs)

    /* Tcp Server */
    Q_PROPERTY(int tcpServerPort READ getTcpServerPort WRITE setTcpServerPort NOTIFY changedTcpServerPort)
    Q_PROPERTY(int tcpServerMaxClients READ getTcpServerMaxClients WRITE setTcpServerMaxClients  NOTIFY changedTcpServerMaxClients )

    /* Cifs */
    Q_PROPERTY(bool cifsEnable READ getCifsEnable WRITE setCifsEnable NOTIFY changedCifsEnable)
    Q_PROPERTY(int cifsMode READ getCifsMode WRITE setCifsMode  NOTIFY changedCifsMode)
    Q_PROPERTY(QString cifsAddress READ getCifsAddress WRITE setCifsAddress  NOTIFY changedCifsAddress)
    Q_PROPERTY(QString cifsUsername READ getCifsUsername WRITE setCifsUsername  NOTIFY changedCifsUsername)
    Q_PROPERTY(QString cifsPassword READ getCifsPassword WRITE setCifsPassword  NOTIFY changedCifsPassword)
    Q_PROPERTY(QString cifsMountPath READ getCifsMountPath WRITE setCifsMountPath  NOTIFY changedCifsMountPath)
    Q_PROPERTY(QString cifsLogFormat READ getCifsLogFormat WRITE setCifsLogFormat NOTIFY changedCifsLogFormat)


public :
    AtQmlSettings();
private :
    /* Profile */
    QString getProfileConfigs();
    void setProfileConfigs(QString val);

    /* General */
    QString getGeneralDeviceNoRead();
    void setGeneralDeviceNoRead(QString val);
    QString getGeneralDeviceEndingSymbol();
    void setGeneralDeviceEndingSymbol(QString val);
    QString getGeneralUserRequest();
    void setGeneralUserRequest(QString val);
    QString getGeneralUserRequestEndingSymbol();
    void setGeneralUserRequestEndingSymbol(QString val);
    QString getGeneralUserResponseEndingSymbol();
    void setGeneralUserResponseEndingSymbol(QString val);


    /* Nic */
    QString getNicType();
    void setNicType(QString val);
    QString getNicAddress();
    void setNicAddress(QString val);
    QString getNicNetmask();
    void setNicNetmask(QString val);
    QString getNicGateway();
    void setNicGateway(QString val);
    QString getNicDNS1();
    void setNicDNS1(QString val);

    /* System */
    QString getSystemHardwareVersion();
    QString getSystemSoftwareVersion();
    QString getSystemDescription();
    bool execSystemReboot();
    bool execSystemShutdown();
    bool execSystemAppRestart();
    void execSystemSysUpgrade(QString val);
    bool execSystemResetDefault();
    QStringList getSystemListUpgradeImages();
    void setSystemDate(QString val);
    void setSystemTime(QString val);
    QString getSystemNtpServer();
    void setSystemNtpServer(QString val);
    bool getSystemEnableNtp();
    void setSystemEnableNtp(bool val);
    bool execSystemStartNtp();
    bool execSystemStopNtp();
    bool execSystemMountCifs();
    /* Tcp Server */
    int getTcpServerPort();
    void setTcpServerPort(int val);
    int getTcpServerMaxClients();
    void setTcpServerMaxClients(int val);

    /* Cifs */
    bool getCifsEnable();
    void setCifsEnable(bool val);
    int getCifsMode();
    void setCifsMode(int val);
    QString getCifsAddress();
    void setCifsAddress(QString val);
    QString getCifsUsername();
    void setCifsUsername(QString val);
    QString getCifsPassword();
    void setCifsPassword(QString val);
    QString getCifsMountPath();
    void setCifsMountPath(QString val);
    QString getCifsLogFormat();
    void setCifsLogFormat(QString val);


signals :
    /* Profile */
    void changedProfileConfigs();

    /* Genernal */
    void changedGeneralDeviceNoRead();
    void changedGeneralDeviceEndingSymbol();
    void changedGeneralUserRequest();
    void changedGeneralUserRequestEndingSymbol();
    void changedGeneralUserResponseEndingSymbol();

    /* Nic */
    void changedNicType();
    void changedNicAddress();
    void changedNicNetmask();
    void changedNicGateway();
    void changedNicDNS1();

    /* System */
    void changedSystemHardwareVersion();
    void changedSystemSoftwareVersion();
    void changedSystemDescription();
    void changedSystemSysUpgrade();
    void changedSystemListUpgradeImages();
    void changedSystemDate();
    void changedSystemTime();
    void changedSystemNtpServer();
    void changedSystemEnableNtp();

    /* Tcp Server */
    void changedTcpServerPort();
    void changedTcpServerMaxClients();

    /* Cifs */
    void changedCifsEnable();
    void changedCifsMode();
    void changedCifsAddress();
    void changedCifsUsername();
    void changedCifsPassword();
    void changedCifsMountPath();
    void changedCifsLogFormat();
};

#endif // AY_QML_SETTINGS_H
