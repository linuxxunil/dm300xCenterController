import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import '../styles'

AtMainTemplate {
    id : main

    $titleName : "设定选单"
    $titleImagePath : "../images/settings.ico"

    RowLayout {
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        anchors.topMargin: 8
        anchors.bottomMargin: 8
        anchors.left: parent.left
        anchors.top: parent.top
        //anchors.right: parent.right
        anchors.bottom: parent.bottom
        spacing : 16
        AtMainItem {
            $itemName : "一般设定"
            $itemImagePath : "../images/general48.ico"
            $itemUrl : "GeneralSetting.qml"
        }

        AtMainItem {
            $itemName : "网卡设定"
            $itemImagePath : "../images/nic48.ico"
            $itemUrl : "NicSetting.qml"
        }

        AtMainItem {
            $itemName : "Profile设定"
            $itemImagePath : "../images/profile48.ico"
            $itemUrl : "ProfileSetting.qml"
        }

        AtMainItem {
            $itemName : "网络邻居"
            $itemImagePath : "../images/cifs48.ico"
            $itemUrl : "CifsSetting.qml"
        }

        AtMainItem {
            $itemName : "时间设定"
            $itemImagePath : "../images/time48.ico"
            $itemUrl : "TimeSetting.qml"
        }

        AtMainItem {
            $itemName : "系统设定"
            $itemImagePath : "../images/system48.ico"
            $itemUrl : "SystemSetting.qml"
        }

        AtMainItem {
            $itemName : "关於我们"
            $itemImagePath : "../images/about48.ico"
            $itemUrl : "About.qml"
        }
    }
}
