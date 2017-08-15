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
    Q_PROPERTY(QString generalUserEndingSymbol READ getGeneralUserEndingSymbol WRITE setGeneralUserEndingSymbol NOTIFY changedGeneralUserEndingSymbol)

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

    /* Tcp Server */
    Q_PROPERTY(int tcpServerPort READ getTcpServerPort WRITE setTcpServerPort NOTIFY changedTcpServerPort)
    Q_PROPERTY(int tcpServerMaxClients READ getTcpServerMaxClients WRITE setTcpServerMaxClients  NOTIFY changedTcpServerMaxClients )


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
    QString getGeneralUserEndingSymbol();
    void setGeneralUserEndingSymbol(QString val);

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

    /* Tcp Server */
    int getTcpServerPort();
    void setTcpServerPort(int val);
    int getTcpServerMaxClients();
    void setTcpServerMaxClients(int val);

signals :
    /* Profile */
    void changedProfileConfigs();

    /* Genernal */
    void changedGeneralDeviceNoRead();
    void changedGeneralDeviceEndingSymbol();
    void changedGeneralUserRequest();
    void changedGeneralUserEndingSymbol();

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

    /* Tcp Server */
    void changedTcpServerPort();
    void changedTcpServerMaxClients();

};

#endif // AY_QML_SETTINGS_H
