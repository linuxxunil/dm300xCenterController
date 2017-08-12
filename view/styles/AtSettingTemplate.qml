import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1


Rectangle {
    width: 800
    height: 186
    color: "#E5E4E2"
    border.color: "#728FCE"
    border.width: 6
    radius: 1

    property string $titleName
    property string $titleImagePath
    property var $cbSaveButton : null
    property int $headerWidth : 250
    property int $headerHeight : 40
    id : settingTemplate

    Rectangle {
        id : header
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 8
        z: 10
        width: $headerWidth
        height: $headerHeight
        color: "#728FCE"
        radius: 10
        anchors.topMargin: -22

        Row {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 4
            anchors.topMargin: 2
            spacing: 8

            Text {
                y : 4
                text: "<"
                color: "#FFFFFF"
                font.pixelSize: 22
                font.bold: true
                MouseArea {
                    anchors.left: parent.left
                    anchors.right:  parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    onClicked: {
                        if ( settingTemplate.$cbSaveButton !== null )
                            settingTemplate.$cbSaveButton();
                        else settingViews.pop();
                    }
                }
            }

            Image {
                source: $titleImagePath
            }

            Text {
                y : 4
                text: $titleName
                color: "#FFFFFF"
                font.pixelSize: 22
                font.bold: true
            }
        }
    }


//    Button {
//        id: saveButton
//        anchors.right: parent.right
//        anchors.bottom: parent.bottom
//        anchors.margins: 8

//        background: Rectangle {
//            implicitWidth: 32
//            implicitHeight: 32
//            color: "#E5E4E2"

//            Image {
//                fillMode: Image.PreserveAspectFit
//                //opacity: btn_General_Save.down ? .3 : 1
//                source: "../images/backward.ico"
//            }
//        }
//        onClicked: {
//            if ( settingTemplate.$cbSaveButton !== null )
//                settingTemplate.$cbSaveButton()
//            else settingViews.pop()
//        }
//    }


}


