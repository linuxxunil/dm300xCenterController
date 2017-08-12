#ifndef AY_GUI_THREAD_H
#define AY_GUI_THREAD_H

#include "ay_controller.h"

class AtGuiSignal : public AtController
{
    Q_OBJECT

public :

signals:
    void guiStatusChanged(int id,bool status);
    void guiSnChanged(int id, QString sn);
    void guiUserRequstTimeChanged(int id);
};



#endif // AY_GUI_THREAD_H
