import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

Dialog {
    property string $title : ""
    property var $cbLastChosen : null

    id: dateDialog
    modality: Qt.WindowModal
    title: $title

    onAccepted: {
        if ( $cbLastChosen != null ) {
            dateDialog.$cbLastChosen(calendar.selectedDate);
        }
    }
    //onRejected: lastChosen.text = "Rejected"

    Calendar {
        id: calendar
        width: parent ? parent.width : implicitWidth
        onDoubleClicked: dateDialog.click(StandardButton.Ok)
    }
}

