import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4


RadioButton {

    property string $name


    ButtonGroup.group: mode_group
    text: $name
    font.pixelSize: 16

    indicator: Rectangle {
        implicitWidth: 22
        implicitHeight: 22
        x: parent.leftPadding
        y: parent.height / 2 - height / 2
        radius: 13
        border.color: id.down ? "#17a81a" : "#21be2b"

        Rectangle {
            width: 14
            height: 14
            x: 4
            y: 4
            radius: 7
            color: id.down ? "#17a81a" : "#21be2b"
            visible: id.checked
        }
    }

    contentItem: Text {
        text: this.text
        font: this.font
        opacity: enabled ? 1.0 : 0.3
        color: this.down ? "#17a81a" : "#21be2b"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        leftPadding: this.indicator.width + this.spacing
    }
}
