#ifndef AY_CONTROLLER_H
#define AY_CONTROLLER_H

#include <QObject>
#include <QTimer>
#include <QMutex>
#include "ay_settings.h"

class AtController : public QObject {

private :

protected :
    static AtSettings setting;
    static bool init;
    static QObject *root;


public :

    AtController();
    ~AtController();
};



#endif // AY_CONTROLLER_H
