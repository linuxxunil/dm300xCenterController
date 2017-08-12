import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4

CheckBox {
    id : atCheckBox
    indicator: Rectangle {
        implicitWidth: 22
        implicitHeight: 22
        x: atCheckBox.leftPadding
        y: parent.height / 2 - height / 2
        radius: 3
        border.color: atCheckBox.down ? "#D8D8D8" : "#6E6E6E"

        Rectangle {
            width: 14
            height: 14
            x: 4
            y: 4
            radius: 2
            color: atCheckBox.down ? "#D8D8D8" : "#6E6E6E"
            visible: atCheckBox.checked
        }
    }

    contentItem: Text {
        text: atCheckBox.text
        font: atCheckBox.font
        opacity: enabled ? 1.0 : 0.3
        color: atCheckBox.down ? "#C0C0C0" : "#000000"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        leftPadding: atCheckBox.indicator.width + atCheckBox.spacing
    }
}
