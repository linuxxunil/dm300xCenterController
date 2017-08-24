TEMPLATE = app

QT += qml quick core$$
CONFIG += c++11

SOURCES += main.cpp \
    ay_settings.cpp \
    ay_controller.cpp \
    ay_application.cpp \
    ay_work_thread.cpp \
    ay_qml_settings.cpp \
    ay_gui_signal.cpp \
    ay_tcp_server.cpp \
    ay_congex_tcp_client.cpp \
    ay_system.cpp \
    ay_systime.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    ay_settings.h \
    ay_controller.h \
    ay_application.h \
    ay_work_thread.h \
    ay_qml_settings.h \
    ay_gui_signal.h \
    ay_tcp_server.h \
    ay_congex_tcp_client.h \
    ay_system.h \
    ay_systime.h

DISTFILES +=
