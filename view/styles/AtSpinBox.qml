import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4

SpinBox {
    property int $from : 0
    property int $to : 10000
    property int $stepSize : 1
    property var $cbOnValueChanged : null
    property string $value : ""

    id: atSpinBox
    height: 24
    padding: 0
    from: $from
    to: $to
    stepSize: $stepSize
    editable: true
    value : $value


    contentItem: TextInput {
        z: 2
        text: atSpinBox.value
        font: atSpinBox.font
        color: "#6E6E6E"
        selectionColor: "#6E6E6E"
        selectedTextColor: "#FFFFFF"
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        readOnly: !atSpinBox.editable
        validator: atSpinBox.validator
        inputMethodHints: Qt.ImhFormattedNumbersOnly
    }

    up.indicator: Rectangle {
        x: atSpinBox.mirrored ? 0 : parent.width - width
        height: parent.height
        implicitWidth: 18
        implicitHeight: 18
        color: atSpinBox.up.pressed ? "#D8D8D8" : "#E6E6E6"
        border.color: enabled ? "#6E6E6E" : "#bdbebf"

        Text {
            text: "+"
            //font.pixelSize: ctl_exposureTime.font.pixelSize * 2
            color: "#6E6E6E"
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    down.indicator: Rectangle {
        x: atSpinBox.mirrored ? parent.width - width : 0
        height: parent.height
        implicitWidth: 18
        implicitHeight: 18
        color: atSpinBox.down.pressed ? "#D8D8D8" : "#E6E6E6"
        border.color: enabled ? "#6E6E6E" : "#bdbebf"

        Text {
            text: "-"
            font.pixelSize: atSpinBox.font.pixelSize * 2
            color: "#6E6E6E"
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

    }

    background: Rectangle {
        implicitWidth: 140
        border.color: "#6E6E6E"
    }

    onValueChanged: {
        if ( atSpinBox.$cbOnValueChanged != null ) {
            atSpinBox.$cbOnValueChanged();
        }
    }
}
