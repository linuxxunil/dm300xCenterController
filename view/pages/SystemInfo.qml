import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import '../styles'

AtSettingTemplate {
    $titleName : "系统资讯"
    $titleImagePath : "../images/systemInfo.ico"


    AtTimer {
        $repeat : true
        $interval: 2000
        $cbOnTriggered : function() {
            cpuTemperature.text = qmlSettings.systemCpuTemperature;
            gpuTemperature.text = qmlSettings.systemGpuTemperature;
            operatingVoltage.text = qmlSettings.systemOperatingVoltage;
        }
    }


    AtSettingContent {
        id: systemInfo

        ColumnLayout {
            RowLayout {
                Text {
                    text: 'CPU温度 : '
                    font.pixelSize: 16
                }

                Text {
                    id : cpuTemperature
                    text: qmlSettings.systemCpuTemperature
                    font.pixelSize: 16
                }
            }

            RowLayout {
                Text {
                    text: 'GPU温度 : '
                    font.pixelSize: 16
                }

                Text {
                    id : gpuTemperature
                    text: qmlSettings.systemGpuTemperature
                    font.pixelSize: 16
                }
            }

            RowLayout {
                Text {
                    text: '运作电压 : '
                    font.pixelSize: 16
                }

                Text {
                    id : operatingVoltage
                    text: qmlSettings.systemOperatingVoltage
                    font.pixelSize: 16
                }
            }

        }
    }
}
