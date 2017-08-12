import QtQuick 2.7

Timer {
    id : atTimer
    property bool $repeat: false
    property int $interval: 0
    property var $cbOnTriggered : null
    property bool $running: true

    repeat : $repeat
    interval: $interval
    running : $running
    onTriggered : {
        if ( atTimer.$cbOnTriggered != null ) {
            atTimer.$cbOnTriggered();
        }
    }
}
