import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4

Button {
    property string $itemName
    property string $itemImagePath
    property string $itemUrl

    id : mainTemplate
    background: Rectangle {
    width : 72
    height : 72
    implicitWidth: 64
    implicitHeight: 64
    color: "#E5E4E2"

        Image {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right:  parent.right
            //anchors.bottom: mainTemplate.height - 8
            fillMode: Image.PreserveAspectFit
            //opacity: btn_go_General.down ? .3 : 1
            source: $itemImagePath
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom : parent.bottom
            text: $itemName
            color: "#4169E1"
            font.pixelSize: 16
        }
    }

    onClicked: {
        settingViews.push(Qt.resolvedUrl("/view/pages/"+$itemUrl))
    }
}


