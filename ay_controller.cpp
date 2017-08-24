#include "ay_controller.h"
#include "ay_settings.h"

AtSettings AtController::setting(0); // Initial need to force paramter
bool AtController::init = false;

QObject *AtController::root = NULL;

// V.C.S.s
// V : 系統版本
// C : 客戶版本 (0 = 標準版)
// c : 客戶版本
// S : 軟體大版本 ( 新功能 )
// s : 軟體小版本 ( Bug )


AtController::AtController()     {
    if ( !init ) {
        // for old hardware
        setting.version.hardwareVersion = (setting.version.hardwareVersion=="0.1")?"0.1":"1.0";
        setting.version.softwareVersion = "1.0.0.0.2";
        setting.version.description = "Standard";
        setting.version.contact = "www.ateam.com.cn";

        qDebug() << "HardwareVersion : " + setting.version.hardwareVersion ;
        qDebug() << "SoftwareVersion : " + setting.version.softwareVersion;
        qDebug() << "Description : " + setting.version.description;

        setting.version.sync();
        init = true;
    }
}

AtController::~AtController() {

}

/*
v1.0.0.0.2
v1.0.0.0.1
* add Cifs
* add Time Setting
v1.0.0.0.0
* add Settings Page
*   - General
*   - Nic
*   - System
*   - About
*/
