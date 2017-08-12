import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.1
import 'pages'
import 'styles'

Window {
    id : window
    title: qsTr('DM300X Controller')
    width: 800
    height: 480
    visible: true
    property var defStatus : ["断线","连线"];
    property var defControl : ["关闭","启用"];
    property var _configs : JSON.parse(qmlSettings.profileConfigs);

    ListModel {
        id : listModel
    }

    TableView {
        id: listView
        anchors.fill:  parent
        model: listModel
        clip: true


        TableViewColumn {
            role: "modelName"
            title: "机型"
        }
        TableViewColumn {
            role: "ipAddress"
            title: "IP位置"
        }
        TableViewColumn {
            role: "comment"
            title: "说明"
        }
        TableViewColumn {
            role: "status"
            title: "状态"
        }
        TableViewColumn {
            role: "sn"
            title: "SN"
        }
        TableViewColumn {
            role: "control"
            title: "控制"
            delegate: Button {
                text : styleData.value
                onClicked: {
                    var index = defControl.indexOf(text);
                    index ^= 1;
                    text = defControl[index];
                }
            }
        }
    }


    Component.onCompleted: {
        //{\"modelName\":\"DM300X-1\",\"serviceIp\" : \"192.168.33.211\",\"deviceIp\":\"192.168.33.51\",\"devicePort\":\"80\",\"comment\":\"SMT-1\"}
        for ( var i=0; i<_configs.length; i++ ) {
            listModel.append({
                "modelName": _configs[i].modelName,
                "ipAddress": _configs[i].serviceIp,
                "comment" : _configs[i].comment,
                "status" : defStatus[0],
                "sn" : "Initial",
                "control" : defControl[0]
            });
        }
    }

    Connections {
        target: Core
        onGuiStatusChanged : { // id , status
            console.log("id="+id+",status="+status)
            listModel.get(id)["status"] = defStatus[(status)?1:0];
        }
        onGuiSnChanged : { // id , sn
            listModel.get(id)["sn"] = "sn";
        }
    }
}
