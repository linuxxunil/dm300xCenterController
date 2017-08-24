#include<QString>
#include<QDateTime>
#include "ay_systime.h"


// 2016-07-12 00:00:00
/*
char* SysTime::getNowDateTime()
{
    time_t now = time(0);
    struct tm  tstruct;
    static char buf[20];
    tstruct = *localtime(&now);
    strftime(buf, 20, "%Y-%m-%d %H:%M:%S", &tstruct);
    buf[19] = '\0';
    //std::string t(buf);
    return buf;
}


long SysTime::getNowTimestamp()
{
    time_t now = time(0);
    return (long)now;
}
*/

/**
 * @brief SysTime::getDateTimestamp
 * @return
 */
qint64 SysTime::getDateTimestamp()
{
    return QDateTime::currentMSecsSinceEpoch();
}


/**
 *
 * @brief SysTime::getDate
 * @return Example : 2016-08-23
 *
 */
QString SysTime::getDate()
{
    return QDateTime::currentDateTime().toString("yyyy-MM-dd");
}

/**
 *
 * @brief SysTime::getDateTime
 * @return Example : 2016-01-23 13:01:12
 */
QString SysTime::getDateTime()
{
    return QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
}

QString SysTime::getDateTimeMs()
{
    return QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss.zzz");
}

/**
 * @brief SysTime::getDateAddMonths
 * @param mon
 * @return
 */
QString SysTime::getDateAddMonths(int mon)
{
    return QDateTime::currentDateTime().addMonths(mon).toString("yyyy-MM-dd");
}
