import QtQuick 2.2
import QtQuick.Dialogs 1.1

MessageDialog {
    property string $text : "text"
    property string $title : "title"
    property var $cbOnYes : null
    property var $cbOnNo : null
    id: messageDialog
    title: $title
    text: $text

    standardButtons: StandardButton.Yes
    Component.onCompleted: visible = false

    onYes : {
        if ( messageDialog2.$cbOnYes != null ) {
            messageDialog2.$cbOnYes();
        }
    }
}


