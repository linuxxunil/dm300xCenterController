import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

RowLayout {

    id : button
    property string $name : ""
    property string $contentName : ""
    property var $cbOnClicked

    Text {
        text : $name

    }

    Button {
        text : $contentName
        onClicked: {
            button.$cbOnClicked()
        }
    }
}
