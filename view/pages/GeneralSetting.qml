import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import '../styles'


AtSettingTemplate {
    $titleName : "一般参数设定"
    $titleImagePath : "../images/general.ico"

    property bool _init : false
    property int _heartbeatTimeMin : 0
    property int _heartbeatTimeMax : 86400


    AtSettingContent {
        id: generalSetting

        ColumnLayout {

//            RowLayout {
//                ButtonGroup { id: mode_group }
//                Text {
//                    text: "工作模式"
//                    font.pixelSize: 18
//                }

//                RadioButton {
//                    id: ctl_mode_2
//                    ButtonGroup.group: mode_group
//                    text: qsTr("调试模式")
//                    font.pixelSize: 16
//                    checked: qmlSettings.generalOperationMode == 2

//                    indicator: Rectangle {
//                        implicitWidth: 22
//                        implicitHeight: 22
//                        x: ctl_mode_2.leftPadding
//                        y: parent.height / 2 - height / 2
//                        radius: 13
//                        border.color: ctl_mode_2.down ? "#17a81a" : "#21be2b"

//                        Rectangle {
//                            width: 14
//                            height: 14
//                            x: 4
//                            y: 4
//                            radius: 7
//                            color: ctl_mode_2.down ? "#17a81a" : "#21be2b"
//                            visible: ctl_mode_2.checked
//                        }
//                    }

//                    contentItem: Text {
//                        text: ctl_mode_2.text
//                        font: ctl_mode_2.font
//                        opacity: enabled ? 1.0 : 0.3
//                        color: ctl_mode_2.down ? "#17a81a" : "#21be2b"
//                        horizontalAlignment: Text.AlignHCenter
//                        verticalAlignment: Text.AlignVCenter
//                        leftPadding: ctl_mode_2.indicator.width + ctl_mode_2.spacing
//                    }

//                    onCheckedChanged: {
//                        if (checked) {
//                            qmlSettings.generalOperationMode = 2
//                        }
//                    }
//                }
//            }




            RowLayout {
                AtCheckBox {
                    id: enableHeartbeat
                    text: "启动心跳"
                    checked : qmlSettings.generalEnableHeartbeat
                    onCheckedChanged: {
                        qmlSettings.generalEnableHeartbeat = checked
                    }
                }

                Text {
                    visible: enableHeartbeat.checked
                    text: ', 间隔毫秒 : '
                    font.pixelSize: 16
                }

                AtSpinBox {
                    visible: enableHeartbeat.checked
                    id : heartbeatTime
                    $from : _heartbeatTimeMin
                    $to : _heartbeatTimeMax
                    value: qmlSettings.generalHeartbeatTime
                    onValueChanged: {
                        qmlSettings.generalHeartbeatTime = heartbeatTime.value
                    }
                }
            }



//            RowLayout {
//                AtCheckBox {
//                    id: dataForward
//                    text: "启动资料转传"
//                    checked : qmlSettings.generalEnableDataForward
//                    onCheckedChanged: {
//                        if ( checked ) {
//                            qmlSettings.generalEnableDataForward = 0x01
//                        } else {
//                            qmlSettings.generalEnableDataForward = 0x00
//                        }
//                    }
//                }
//            }
        }
    }
}
