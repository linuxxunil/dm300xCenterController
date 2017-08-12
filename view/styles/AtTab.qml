import QtQuick.Controls 1.4
import QtQuick 2.7
import QtQuick.Layouts 1.3

Tab {
    property string $title : ""
    property var $layout


    title : $title
    Rectangle {
        color : "#E5E4E2"
        children : $layout
    }

//    Rectangle {
//        color: "#E5E4E2"
//        RowLayout : $layout
//    }
}
