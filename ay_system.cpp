#include "ay_system.h"
#include <QFile>
//# tar -zcvf - pma|openssl des3 -salt -k password | dd of=pma.des3
//# dd if=pma.des3 |openssl des3 -d -k password|tar zxf -

QString AtSystem::_key = "http://www.ateam.com.cn";
QProcess *AtSystem::_process = new QProcess();

bool AtSystem::execReboot()
{
    return _process->startDetached("reboot");
}

bool AtSystem::execShutdown()
{
    return _process->startDetached("poweroff");
}

bool AtSystem::execSetTcpRecycle()
{ 
    return QProcess::execute("/bin/bash", QStringList() << "-c" <<  "echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle");
}

bool AtSystem::execSetTcpReuse()
{
    return QProcess::execute("/bin/bash", QStringList() << "-c" <<  "echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse");
}

bool AtSystem::writeLog(QString text)
{
    QFile f("/var/log/ateam.log");
    if(!f.open(QIODevice::ReadWrite | QIODevice::Append)){
        qDebug()<<"Error opening the file";
        return false;
    }
    QTextStream outStream(&f);

    outStream << text + "\n";
    f.close();
    return true;
}


bool AtSystem::setSystemDate(QString date) // 20171201
{
    QString cmd; //date -s "20170204 `date +'%T'`"
    cmd += "date -s \"" + date + " `date +'%T'`\"";
    return (QProcess::execute("/bin/bash", QStringList() << "-c" <<  cmd)==0)?true:false;
}

bool AtSystem::setSystemTime(QString time) // 12:00:00
{
    QString cmd;
    cmd += "date -s " + time;
    return (QProcess::execute("/bin/bash", QStringList() << "-c" <<  cmd)==0)?true:false;
}

bool AtSystem::setSystemDateTime(QString val)
{
    QStringList dateTime = val.split(" ");
    if ( dateTime.size() == 2 ) {
        QString cmd; //date -s "20170204 `date +'%T'`"
        cmd += "date -s \"" + dateTime[0] + " `date +'%T'`\" > /dev/null;";
        cmd += "date -s " + dateTime[1] + " > /dev/null";
        return (QProcess::execute("/bin/bash", QStringList() << "-c" <<  cmd)==0)?true:false;
    }
    return false;
}


bool AtSystem::setIpAddress()
{
    QString cmd = "ip addr flush dev " + setting.nic.nicIface + ";"
                  "ifconfig " + setting.nic.nicIface + " " + setting.nic.nicAddress + " netmask " + setting.nic.nicNetmask + ";";
                  "route default gw " + setting.nic.nicGateway + ";"
                  "echo nameserver " + setting.nic.nicDns1 + "> /etc/resolv.conf;";

    for (int i=0; i<setting.profile.configsArray.size(); i++ ) {
        QJsonObject configsObj = setting.profile.configsArray[i].toObject();
        cmd += "ip addr add " + configsObj["serviceIp"].toString() + "/24 dev " + setting.nic.nicIface + ";";
    }
    return (QProcess::execute("/bin/bash", QStringList() << "-c" <<  cmd)==0)?true:false;
}
