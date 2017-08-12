#ifndef AY_SETTINGS_H
#define AY_SETTINGS_H
#include <QSettings>
#include <QObject>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

class AtSettingsBase : public QObject{

protected:
     QSettings *_setting;

public:
     void setSetting(QSettings *setting) {
         _setting = setting;
     }
};

class AtSettingsGeneral : public AtSettingsBase {
private :
    QString _group = "General";

public :
    int size;
    QString request;
    QString response;
    QString noRead;
    QString deviceEndingSymbol;
    QString userEndingSymbol;

    ~AtSettingsGeneral() {
    }

    void init() {
        // Get Default Config
        _setting->beginGroup(_group);
        size = _setting->value("size","1").toInt();
        _setting->endGroup();

    }

    void reload() {
        _setting->beginGroup(_group);
        request = _setting->value("request", QVariant("LNO")).toString();
        noRead = _setting->value("noRead", QVariant("NR")).toString();
        deviceEndingSymbol = _setting->value("deviceEndingSymbol", QVariant("")).toString();
        userEndingSymbol = _setting->value("userEndingSymbol", QVariant("\r\n")).toString();

        _setting->endGroup();
    }

    void sync() {
        _setting->beginGroup(_group);
        _setting->setValue("request", QVariant(request));
        _setting->setValue("noRead", QVariant(noRead));
        _setting->setValue("deviceEndingSymbol", QVariant(deviceEndingSymbol));
        _setting->setValue("userEndingSymbol", QVariant(userEndingSymbol));

        _setting->endGroup();
    }
};

class AtSettingsTcpServer : public AtSettingsBase {
private :
    QString _group = "TcpServer";

public :
    int size;
    mutable QString bindAddress; // any or ipaddress
    mutable int port;
    mutable int maxClients;

    ~AtSettingsTcpServer() {
    }

    void init() {
        // Get Default Config
        _setting->beginGroup(_group);
        size = _setting->value("size","1").toInt();
        _setting->endGroup();

    }

    void reload() {
        _setting->beginGroup(_group);
        bindAddress = _setting->value("bindAddress", QVariant("any")).toString();
        port = _setting->value("port", QVariant("713")).toInt();
        maxClients = _setting->value("maxClients", QVariant("30")).toInt();
        _setting->endGroup();
    }

    void sync() {
        _setting->beginGroup(_group);
        _setting->setValue("bindAddress", QVariant(bindAddress));
        _setting->setValue("port", QVariant(port));
        _setting->setValue("maxClients", QVariant(maxClients));  //only one
        _setting->endGroup();
    }
};

class AtSettingsProfile: public AtSettingsBase {
private :
    QString _group = "Profile";

public :
    int size;
    QString configs;
    QJsonDocument configsDoc;
    QJsonArray configsArray;


    ~AtSettingsProfile() {
    }

    void init() {
        // Get Default Config
        _setting->beginGroup(_group);
        size = _setting->value("size","1").toInt();
        _setting->endGroup();
    }

    void reload() {
        _setting->beginGroup(_group);
        configs = configs = _setting->value("configs",
                                            "[{\"enable\":true,\"modelName\":\"DM300X-1\",\"serviceIp\" : \"192.168.33.211\",\"deviceIp\":\"192.168.33.51\",\"devicePort\":80,\"comment\":\"SMT-1\"}"
                                            "]").toString();
                                            //",{\"enable\":true,\"modelName\":\"DM300X-2\",\"serviceIp\" : \"192.168.33.212\",\"deviceIp\":\"192.168.33.52\",\"devicePort\":80,\"comment\":\"SMT-2\"}"
                                            //",{\"enable\":true,\"modelName\":\"DM300X-3\",\"serviceIp\" : \"192.168.33.213\",\"deviceIp\":\"192.168.33.53\",\"devicePort\":80,\"comment\":\"SMT-3\"}"
                                            //",{\"enable\":true,\"modelName\":\"DM300X-4\",\"serviceIp\" : \"192.168.33.214\",\"deviceIp\":\"192.168.33.54\",\"devicePort\":80,\"comment\":\"SMT-4\"}"
                                            //",{\"enable\":true,\"modelName\":\"DM300X-5\",\"serviceIp\" : \"192.168.33.215\",\"deviceIp\":\"192.168.33.55\",\"devicePort\":80,\"comment\":\"SMT-5\"}"

        _setting->endGroup();
    }

    void sync() {
        _setting->beginGroup(_group);
        _setting->setValue("configs", QVariant(configs));
        _setting->endGroup();

        configsDoc = QJsonDocument::fromJson(configs.toUtf8());
        configsArray = configsDoc.array();
    }
};


class AtSettingsVersion: public AtSettingsBase {
private :
    QString _group = "Version";

public :
    int size;
    bool enable;
    QString hardwareVersion;
    QString softwareVersion;
    QString description;
    QString contact;

    ~AtSettingsVersion() {
    }

    void init() {
        // Get Default Config
        _setting->beginGroup(_group);
        size = _setting->value("size","1").toInt();
        _setting->endGroup();
    }

    void reload() {
        _setting->beginGroup(_group);
        hardwareVersion = _setting->value("hardwareVersion", QVariant("1.0")).toString();
        _setting->endGroup();
    }

    void sync() {
        _setting->beginGroup(_group);
        _setting->setValue("hardwareVersion", QVariant(hardwareVersion));
        _setting->setValue("softwareVersion", QVariant(softwareVersion));
        _setting->setValue("description", QVariant(description));
        _setting->setValue("contact", QVariant(contact));
        _setting->endGroup();
    }
};

class AtSettingsNic : public AtSettingsBase {
// 因給network.sh使用，命名必須唯一
private :
    QString _group = "Nic";

public :
    int size ;
    QString nicIface;
    mutable QString nicType; //dhcp/static
    mutable QString nicAddress;
    mutable QString nicNetmask;
    mutable QString nicGateway;
    mutable QString nicDns1;


    ~AtSettingsNic() {
    }

    void init() {
        // Get Default Config

        _setting->beginGroup(_group);
        size = _setting->value("size","1").toInt();
        _setting->endGroup();
    }

    void reload() {
        // Reload Config
        QString index;
        _setting->beginGroup(_group);
        nicIface = _setting->value("nicIface","eth0").toString();
        nicType = _setting->value("nicType","static").toString();
        nicAddress = _setting->value("nicAddress","192.168.33.216").toString();
        nicNetmask = _setting->value("nicNetmask","255.255.255.0").toString();
        nicGateway = _setting->value("nicGateway","192.168.33.254").toString();
        nicDns1 = _setting->value("nicDns1","192.168.33.254").toString();
        _setting->endGroup();
    }

    void sync() {
        QString index;
        _setting->beginGroup(_group);
        _setting->setValue("size", QVariant(size));

        _setting->setValue("nicIface", QVariant(nicIface));
        _setting->setValue("nicType", QVariant(nicType));
        _setting->setValue("nicAddress", QVariant(nicAddress));
        _setting->setValue("nicNetmask", QVariant(nicNetmask));
        _setting->setValue("nicGateway", QVariant(nicGateway));
        _setting->setValue("nicDns1", QString(nicDns1));

        _setting->endGroup();
    }
};


// AtSetting
class AtSettings : public QObject{
private:
    QSettings *_setting;

public :
    QString path = "/etc/ateam.conf";


    AtSettings(QObject *parent) {
        _setting = new QSettings( path, QSettings::IniFormat);

        general.setSetting( _setting);
        general.init();
        general.reload();
        general.sync();

        tcpServer.setSetting( _setting);
        tcpServer.init();
        tcpServer.reload();
        tcpServer.sync();

        profile.setSetting( _setting);
        profile.init();
        profile.reload();
        profile.sync();

        nic.setSetting(_setting);
        nic.init();
        nic.reload();
        nic.sync();

        version.setSetting( _setting);
        version.init();
        version.reload();

        //version.sync(); // do in controller.cpp
        _setting->sync();
    }

    AtSettingsNic nic;
    AtSettingsGeneral general;
    AtSettingsProfile profile;
    AtSettingsTcpServer tcpServer;
    AtSettingsVersion version;
};


#endif // AY_SETTING_H
