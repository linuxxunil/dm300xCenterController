import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


RowLayout {
    spacing: 8

    property string $name : ""
    property string $text : ""
    property bool $isChanged : false
    property int $width : 40
    property int $height : 19
    property var $cbOnTextChanged
    property int init : 0

    id : genernalTextInput
    Label {
        width: 80
        height: 19
        horizontalAlignment: Text.AlignRight
        font.pixelSize: 16
        text : $name
    }

    Label {
        height: 19
        text: " : "
        font.pixelSize: 16
    }

    Rectangle {
        width: $width
        height: $height
        border.color: enabled ? "#6E6E6E" : "#bdbebf"
        clip : true

        TextInput {
            id : data
            width : parent.width
            height : parent.height
            font.pixelSize: 16
            horizontalAlignment: Text.AlignLeft
            autoScroll: true
            text : $text

            onTextChanged: {
                if ( ++init > 1 ) {
                    genernalTextInput.$cbOnTextChanged(data.text)
                }
            }
        }
    }


}
