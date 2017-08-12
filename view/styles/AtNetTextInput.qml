import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


RowLayout {
    spacing: 8
    id : netTextInput
    property string $name : ""
    property string $address : "0.0.0.0"
    property bool $isChanged : false
    property int init : 0
    property var $cbOnTextChanged
    property bool $readOnly : false
    property bool $visible: true

    visible: $visible
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
        width: 40
        height: 19
        border.color: enabled ? "#6E6E6E" : "#bdbebf"
        clip : true
        TextInput {
            id : one
            width : parent.width
            height : parent.height
            font.pixelSize: 16
            font.pointSize: 3
            //cursorVisible : true
            horizontalAlignment: Text.AlignHCenter
            //acceptableInput : true
            text : $address.split(".")[0]
            readOnly: $readOnly
            onTextChanged: {
                if ( ++init > 4 ) {
                    var val = one.text + "."
                             + $address.split(".")[1] + "."
                             + $address.split(".")[2] + "."
                             + $address.split(".")[3];
                    netTextInput.$cbOnTextChanged(val)
                    //console.log(val)
                }

            }
        }

    }

    Label {
        text: '.'
        font.pixelSize: 16
    }

    Rectangle {
        width: 40
        height: 19
        border.color: enabled ? "#6E6E6E" : "#bdbebf"
        clip : true
        TextInput {
            id : two
            width : parent.width
            height : parent.height
            font.pixelSize: 16
            font.pointSize: 3
            //cursorVisible : true
            horizontalAlignment: Text.AlignHCenter
            //acceptableInput : false
            readOnly: $readOnly
            text : $address.split(".")[1]

            onTextChanged: {

                if ( ++init > 4 ) {
                    var val = $address.split(".")[0] + "."
                             + two.text + "."
                             + $address.split(".")[2] + "."
                             + $address.split(".")[3];
                    netTextInput.$cbOnTextChanged(val)
                    //console.log(val)
                }
            }
        }
    }

    Label {
        text: '.'
        font.pixelSize: 16
    }

    Rectangle {
        width: 40
        height: 19
        border.color: enabled ? "#6E6E6E" : "#bdbebf"
        clip : true
        TextInput {
            id : three
            width : parent.width
            height : parent.height
            font.pixelSize: 16
            font.pointSize: 3
            //cursorVisible : true
            horizontalAlignment: Text.AlignHCenter
            //acceptableInput : true
            readOnly: $readOnly
            text : $address.split(".")[2]

            onTextChanged: {

                if ( ++init > 4 ) {
                    var val = $address.split(".")[0] + "."
                             + $address.split(".")[1] + "."
                             + three.text + "."
                             + $address.split(".")[3];
                    netTextInput.$cbOnTextChanged(val)
                    //console.log(val)
                }
            }
        }
    }

    Label {
        text: '.'
        font.pixelSize: 16
    }

    Rectangle {
        width: 40
        height: 19
        border.color: enabled ? "#6E6E6E" : "#bdbebf"
        clip : true

        TextInput {
            id : four
            width : parent.width
            height : parent.height
            font.pixelSize: 16
            font.pointSize: 3
            //cursorVisible : true
            horizontalAlignment: Text.AlignHCenter
            //acceptableInput : true
            text : $address.split(".")[3]
            readOnly: $readOnly

            onTextChanged: {

                if ( ++init > 4 ) {
                    var val = $address.split(".")[0] + "."
                             + $address.split(".")[1] + "."
                             + $address.split(".")[2] + "."
                             + four.text;
                    netTextInput.$cbOnTextChanged(val)
                    //console.log(val)
                }
            }
        }
    }
}
