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
    QString userRequest;
    QString response;
    QString deviceNoRead;
    QString deviceEndingSymbol;
    QString userRequestEndingSymbol;
    QString userResponseEndingSymbol;

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
        deviceNoRead = _setting->value("deviceNoRead", QVariant("NR")).toString();
        deviceEndingSymbol = _setting->value("deviceEndingSymbol", QVariant("\r\n")).toString();
        userRequest = _setting->value("userRequest", QVariant("LNO")).toString();
        //userEndingSymbol = _setting->value("userEndingSymbol", QVariant("\r\n")).toString();
        userRequestEndingSymbol = _setting->value("userRequestEndingSymbol", QVariant("\r\n")).toString();
        userResponseEndingSymbol = _setting->value("userResponseEndingSymbol", QVariant("\r\n")).toString();
        _setting->endGroup();
    }

    void sync() {
        _setting->beginGroup(_group);

        _setting->setValue("deviceNoRead", QVariant(deviceNoRead));
        _setting->setValue("deviceEndingSymbol", QVariant(deviceEndingSymbol));
        _setting->setValue("userRequest", QVariant(userRequest));
        _setting->setValue("userRequestEndingSymbol", QVariant(userRequestEndingSymbol));
        _setting->setValue("userResponseEndingSymbol", QVariant(userResponseEndingSymbol));
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
    //mutable QString suffix;

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
        port = _setting->value("port", QVariant("9004")).toInt();
        //suffix = _setting->value("suffix", QVariant("\r\n")).toString();
        maxClients = _setting->value("maxClients", QVariant("30")).toInt();
        _setting->endGroup();
    }

    void sync() {
        _setting->beginGroup(_group);
        _setting->setValue("bindAddress", QVariant(bindAddress));
        _setting->setValue("port", QVariant(port));
        //_setting->setValue("suffix", QVariant(suffix));
        _setting->setValue("maxClients", QVariant(maxClients));  //only one
        _setting->endGroup();
    }
};

class AtSettingsCifs : public AtSettingsBase {
private :
    QString _group = "Cifs";

public :
    int size;
    mutable bool enable;
    mutable QString address; // any or ipaddress
    mutable int mode;
    mutable QString username;
    mutable QString password;
    mutable QString mountPath;
    mutable QString logFormat;
    //mutable QString suffix;

    ~AtSettingsCifs() {
    }

    void init() {
        // Get Default Config
        _setting->beginGroup(_group);
        size = _setting->value("size","1").toInt();
        _setting->endGroup();

    }

    void reload() {
        _setting->beginGroup(_group);
        enable = _setting->value("enable", QVariant("false")).toBool();
        mode = _setting->value("mode", QVariant("1")).toInt();
        address = _setting->value("address", QVariant("192.168.20.2/share")).toString();
        username = _setting->value("username", QVariant("admin")).toString();
        password = _setting->value("password", QVariant("admin")).toString();
        mountPath = _setting->value("mountPath", QVariant("/mnt/windows")).toString();
        logFormat = _setting->value("logFormat", QVariant("%1 %2 %3")).toString();
        _setting->endGroup();
    }

    void sync() {
        _setting->beginGroup(_group);
        _setting->setValue("enable", QVariant(enable));
        _setting->setValue("mode", QVariant(mode));
        _setting->setValue("address", QVariant(address));
        _setting->setValue("username", QVariant(username));
        _setting->setValue("password", QVariant(password));
        _setting->setValue("mountPath", QVariant(mountPath));
        _setting->setValue("logFormat", QVariant(logFormat));

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
                                            "[{\"enable\":true,\"visible\":true,\"modelName\":\"DM300X-01\",\"serviceIp\" : \"192.168.20.101\",\"deviceIp\":\"192.168.20.201\",\"devicePort\":23,\"comment\":\"SMT-01\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-02\",\"serviceIp\" : \"192.168.20.102\",\"deviceIp\":\"192.168.20.202\",\"devicePort\":23,\"comment\":\"SMT-02\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-03\",\"serviceIp\" : \"192.168.20.103\",\"deviceIp\":\"192.168.20.203\",\"devicePort\":23,\"comment\":\"SMT-03\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-04\",\"serviceIp\" : \"192.168.20.104\",\"deviceIp\":\"192.168.20.204\",\"devicePort\":23,\"comment\":\"SMT-04\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-05\",\"serviceIp\" : \"192.168.20.105\",\"deviceIp\":\"192.168.20.205\",\"devicePort\":23,\"comment\":\"SMT-05\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-06\",\"serviceIp\" : \"192.168.20.106\",\"deviceIp\":\"192.168.20.206\",\"devicePort\":23,\"comment\":\"SMT-06\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-07\",\"serviceIp\" : \"192.168.20.107\",\"deviceIp\":\"192.168.20.207\",\"devicePort\":23,\"comment\":\"SMT-07\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-08\",\"serviceIp\" : \"192.168.20.108\",\"deviceIp\":\"192.168.20.208\",\"devicePort\":23,\"comment\":\"SMT-08\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-09\",\"serviceIp\" : \"192.168.20.109\",\"deviceIp\":\"192.168.20.209\",\"devicePort\":23,\"comment\":\"SMT-09\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-10\",\"serviceIp\" : \"192.168.20.110\",\"deviceIp\":\"192.168.20.210\",\"devicePort\":23,\"comment\":\"SMT-10\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-11\",\"serviceIp\" : \"192.168.20.111\",\"deviceIp\":\"192.168.20.211\",\"devicePort\":23,\"comment\":\"SMT-11\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-12\",\"serviceIp\" : \"192.168.20.112\",\"deviceIp\":\"192.168.20.212\",\"devicePort\":23,\"comment\":\"SMT-12\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-13\",\"serviceIp\" : \"192.168.20.113\",\"deviceIp\":\"192.168.20.213\",\"devicePort\":23,\"comment\":\"SMT-13\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-14\",\"serviceIp\" : \"192.168.20.114\",\"deviceIp\":\"192.168.20.214\",\"devicePort\":23,\"comment\":\"SMT-14\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-15\",\"serviceIp\" : \"192.168.20.115\",\"deviceIp\":\"192.168.20.215\",\"devicePort\":23,\"comment\":\"SMT-15\"}"
                                            ",{\"enable\":false,\"visible\":true,\"modelName\":\"DM300X-15\",\"serviceIp\" : \"192.168.20.116\",\"deviceIp\":\"192.168.20.216\",\"devicePort\":23,\"comment\":\"SMT-16\"}"
                                            "]").toString();

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

class AtSettingsSystem : public AtSettingsBase {
    QString _group = "System";
public :
    int size ;
    mutable bool initFinished;
    mutable bool ntpEnable;
    mutable QString ntpServer;

    ~AtSettingsSystem() {
    }

    void init() {
        // Get Default Config

        _setting->beginGroup(_group);
        size = _setting->value("size","1").toInt();
        _setting->endGroup();

        initFinished = false;
    }

    void reload() {
        // Reload Config
        _setting->beginGroup(_group);
        ntpEnable = _setting->value("ntpEnable", "true").toBool();
        ntpServer = _setting->value("ntpServer", "cn.pool.ntp.org").toString();
        _setting->endGroup();

    }

    void sync() {
        QString index;
        _setting->beginGroup(_group);
        _setting->setValue("size", QVariant(size));
        _setting->setValue("ntpEnable", QVariant(ntpEnable));
        _setting->setValue("ntpServer", QVariant(ntpServer));

        _setting->endGroup();
    }
};



class AtSettingsTcpClient: public AtSettingsBase {
    private :
    QString _group = "TcpClient";

    public :
    int size;
    int keepAliveEnable;
    int keepAliveMaxIdle;
    int keepAliveCount;
    int keepAliveInterval;


    ~AtSettingsTcpClient() {
    }

    void init() {
        // Get Default Config
        _setting->beginGroup(_group);
        size = _setting->value("size","1").toInt();
        _setting->endGroup();
    }

    void reload() {
        _setting->beginGroup(_group);
        keepAliveEnable = _setting->value("keepAliveEnable", QVariant("1")).toInt();
        keepAliveMaxIdle = _setting->value("keepAliveMaxIdle", QVariant("2")).toInt();/* seconds */
        keepAliveCount = _setting->value("keepAliveCount", QVariant("2")).toInt();int count = 3;//send up to 3 keepalive packets out, then disconnect if no response
        keepAliveInterval = _setting->value("keepAliveInterval", QVariant("1")).toInt();int interval = 2;//send a keepalive packet out every 2 seconds (after the 5 second idle period)
        _setting->endGroup();
    }

    void sync() {
        _setting->beginGroup(_group);
        _setting->setValue("keepAliveEnable", QVariant(keepAliveEnable));
        _setting->setValue("keepAliveMaxIdle", QVariant(keepAliveMaxIdle));
        _setting->setValue("keepAliveCount", QVariant(keepAliveCount));
        _setting->setValue("keepAliveInterval", QVariant(keepAliveInterval));
        _setting->endGroup();
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
        nicAddress = _setting->value("nicAddress","192.168.31.216").toString();
        nicNetmask = _setting->value("nicNetmask","255.255.255.0").toString();
        nicGateway = _setting->value("nicGateway","192.168.31.1").toString();
        nicDns1 = _setting->value("nicDns1","192.168.31.1").toString();
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
    QString path = "/etc/dm300xCenterController.conf";


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

        system.setSetting(_setting);
        system.init();
        system.reload();
        system.sync();

        cifs.setSetting(_setting);
        cifs.init();
        cifs.reload();
        cifs.sync();

        tcpClient.setSetting(_setting);
        tcpClient.init();
        tcpClient.reload();
        tcpClient.sync();

        version.setSetting( _setting);
        version.init();
        version.reload();

        //version.sync(); // do in controller.cpp
        _setting->sync();
    }

    AtSettingsNic nic;
    AtSettingsTcpClient tcpClient;
    AtSettingsGeneral general;
    AtSettingsProfile profile;
    AtSettingsTcpServer tcpServer;
    AtSettingsSystem system;
    AtSettingsCifs cifs;
    AtSettingsVersion version;
};


#endif // AY_SETTING_H
