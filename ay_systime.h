#ifndef AY_SYSTIME_H
#define AY_SYSTIME_H
#include <QString>

class SysTime
{
public:
    //static std::string getNowDateTime();
    //static char* getNowDateTime();
    //static long getNowTimestamp();
    static QString getDateTime();
    static QString getDateTimeMs();
    static QString getDate();
    static QString getDateAddMonths(int mon);
    static qint64 getDateTimestamp();

};

#endif // SYSTEMTIME_H

