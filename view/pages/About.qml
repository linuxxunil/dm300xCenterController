import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import '../styles'

AtSettingTemplate {

    $titleName : "关於我们"
    $titleImagePath : "../images/about.ico"

    // Content :
    AtSettingContent {
        id : about

        ColumnLayout {
            spacing: 6

            RowLayout {
                Text {
                    text: '硬件版本 : '
                    font.pixelSize: 16
                }

                Text {
                    text: qmlSettings.systemHardwareVersion
                    font.pixelSize: 16
                }
            }

            RowLayout {
                Text {
                    text: '软件版本 : '
                    font.pixelSize: 16
                }

                Text {
                    text: qmlSettings.systemSoftwareVersion
                    font.pixelSize: 16
                }
            }

            RowLayout {
                Text {
                    text: '软体描述 : '
                    font.pixelSize: 16
                }

                Text {
                    text: qmlSettings.systemDescription
                    font.pixelSize: 16
                }
            }
        }
    }

}
