import QtQuick 2.2
import QtQuick.Dialogs 1.1

MessageDialog {
    property string $text : "text"
    property string $title : "title"
    property var $width : 320 
    property var $height : 240
    property var $cbOnYes : null
    property var $cbOnNo : null
    property var $icon: "NoIcon"
    property var $onOk : false
    id: messageDialog2
    title: $title
    text: $text
    width: $width
    height: $height
    icon: ($icon=="NoIcon")?StandardIcon.NoIcon:
          (($icon=="Question")?StandardIcon.Question:
          (($icon=="Information")?StandardIcon.Information:
          (($icon=="Warning")?StandardIcon.Warning:
          (($icon=="Critical")?StandardIcon.Critical:
            StandardIcon.NoIcon))))


    function initStandardButtons() {
        var ret = 0;
        if ( $cbOnYes != null ) {
            ret |= StandardButton.Yes;
        }
        if ( $cbOnNo != null ) {
            ret |= StandardButton.No;
        }
        if ( $onOk ) {
            ret |= StandardButton.Ok;
        }

        return ret;
    }

    standardButtons: initStandardButtons()


    Component.onCompleted: visible = false

    onYes : {
        if ( messageDialog2.$cbOnYes != null ) {
            messageDialog2.$cbOnYes();
        }
    }

    onNo : {
        if ( messageDialog2.$cbOnNo != null ) {
            messageDialog2.$cbOnNo();
        }
    }
}
