import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


RowLayout {
    spacing: 8

    property string $text : ""
    property bool _init : false

    property int $width : 42
    property int $height : 19
    property var $cbOnTextChanged : null
    property var $cbOnDisplayTextChanged : null
    property int $horizontalAlignment : Text.AlignLeft
    property var $validator : RegExpValidator {}
    property var $visible: true


    id : atTextInput
    visible: $visible
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
            horizontalAlignment: $horizontalAlignment
            autoScroll: true
            text : $text
            validator: $validator

            onDisplayTextChanged: {
                if ( _init === false ) {
                    _init = true;
                } else if ( $cbOnDisplayTextChanged != null ) {
                    atTextInput.$cbOnDisplayTextChanged(text)
                }
            }

            onTextChanged: {
                if ( _init === false ) {
                    _init = true;
                } else if ( $cbOnTextChanged != null ) {
                    atTextInput.$cbOnTextChanged(text)
                }
            }

        }
    }
}
