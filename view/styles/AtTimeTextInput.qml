import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


RowLayout {
    spacing: 8

    property string $name : ""
    property string $num : ""
    property bool $isChanged : false
    property int $width : 42
    property int $height : 19
    property var $cbOnTextChanged
    property int init : 0
    property int $numMin : 0
    property int $numMax : 2030

    id : timeTextInput
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
            horizontalAlignment: Text.AlignRight
            autoScroll: true
            text : $num
            validator: IntValidator{bottom: $numMin; top: $numMax;}


            onTextChanged: {

            }
        }
    }


    Label {
        width: 80
        height: 19
        horizontalAlignment: Text.AlignRight
        font.pixelSize: 16
        text : $name
    }
}
