#include "ay_system.h"
#include "ay_systime.h"
#include <QFile>
//# tar -zcvf - pma|openssl des3 -salt -k password | dd of=pma.des3
//# dd if=pma.des3 |openssl des3 -d -k password|tar zxf -

QString AtSystem::_key = "http://www.ateam.com.cn";
QProcess *AtSystem::_process = new QProcess();
QMutex AtSystem::_logMutex;

bool AtSystem::execReboot()
{
    return _process->startDetached("reboot");
}

bool AtSystem::execShutdown()
{
    return _process->startDetached("poweroff");
}


bool AtSystem::execAppRestart()
{
    return _process->startDetached("/opt/service restart&");
}

QStringList AtSystem::getUpgradeImages()
{
    QString cmd = "/opt/upgrade.sh";
    QStringList arg;
    arg << "list";
    _process->start(cmd, arg, QIODevice::ReadOnly );
    _process->waitForFinished();
    QString data = _process->readAllStandardOutput();
    QStringList list = data.split("\n");
    list.removeLast();
    return list;
}

bool AtSystem::execResetDefault()
{
    QString cmd ;
    cmd = "rm -rf " + setting.path ;
    return (QProcess::execute("/bin/bash", QStringList() << "-c" <<  cmd)==0)?true:false;
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
    _logMutex.lock();

    if ( setting.cifs.enable ) {

        QString fileName = "/" + SysTime::getDate() + ".txt";
        QFile f(setting.cifs.mountPath + fileName);
        if(!f.open(QIODevice::ReadWrite | QIODevice::Append)){
            qDebug()<<"Error opening the file";
            return false;
        }
        QTextStream outStream(&f);

        outStream << text + "\r\n";
        f.close();
    }
    _logMutex.unlock();
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
                  "ifconfig " + setting.nic.nicIface + " " + setting.nic.nicAddress + " netmask " + setting.nic.nicNetmask + ";"
                  "route add default gw " + setting.nic.nicGateway + " dev "+ setting.nic.nicIface + ";"
                  "echo nameserver " + setting.nic.nicDns1 + "> /etc/resolv.conf;";

    for (int i=0; i<setting.profile.configsArray.size(); i++ ) {
        QJsonObject configsObj = setting.profile.configsArray[i].toObject();
        cmd += "ip addr add " + configsObj["serviceIp"].toString() + "/24 dev " + setting.nic.nicIface + ";";
    }
    //qDebug() << cmd;
    return (QProcess::execute("/bin/bash", QStringList() << "-c" <<  cmd)==0)?true:false;
}

void AtSystem::execUpgrade(QString val)
{
    qDebug() << val;
    QString cmd = "/opt/upgrade.sh";
    QStringList arg;
    arg << "upgrade" << _key << val;
    _process->startDetached(cmd, arg );
}

bool AtSystem::execStartNtp()
{
    QString cmd = "systemctl enable ntp > /dev/null; /etc/init.d/ntp start > /dev/null";
    return (QProcess::execute("/bin/bash", QStringList() << "-c" <<  cmd)==0)?true:false;
}

bool AtSystem::execStopNtp()
{
    QString cmd = "systemctl disable ntp > /dev/null ; /etc/init.d/ntp stop > /dev/null";
    return (QProcess::execute("/bin/bash", QStringList() << "-c" <<  cmd)==0)?true:false;
}


bool AtSystem::setNtpServer(QString val) //
{
    QString cmd;
    cmd = "NTPSERVER=`grep \"^server\" /etc/ntp.conf -m 1` && "
          "sed -i \"s/^${NTPSERVER}/server " + val + "/g\" /etc/ntp.conf;"
          "systemctl restart ntp";

    return (QProcess::execute("/bin/bash", QStringList() << "-c" <<  cmd)==0)?true:false;
}

bool AtSystem::execMountCifs()
{
    QString cmd;

    cmd = "mkdir -p " + setting.cifs.mountPath + ";"
          "umount " + setting.cifs.mountPath + " 2> /dev/null;"
          "mount -t cifs -o username=\'"  + setting.cifs.username + "\',password=\'" + setting.cifs.password + "\' "
          "//" + setting.cifs.address + " " + setting.cifs.mountPath;
    return (QProcess::execute("/bin/bash", QStringList() << "-c" <<  cmd)==0)?true:false;
}

bool AtSystem::execMountRamDisk(QString path, int size)
{
    QString cmd = "mkdir -p " + path + ";"
                  "umount " + path + " 2> /dev/null;"
                  "mount -t tmpfs -o size="+ QString::number(size,10) + "M tmpfs " + path;
    return (QProcess::execute("/bin/bash", QStringList() << "-c" <<  cmd)==0)?true:false;
}

