import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import '../styles'

AtSettingTemplate {

    $titleName : "DO设定"
    $titleImagePath : "../images/do.ico"

    property var _conditionModel : ["未设定","DI-1","DI-2","DbClient"]
    property var _recoveryModel : ["未设定","DI-1", "DI-2","DbClient"]

    function toComboIndex($val) {
        switch ( $val ) { // mapping ay_setting.h -> DO
        case 0x00:
        case 0x01:
        case 0x02:
            return $val;
        case 0x10:
            return 3;
        default :
            return 0;
        }
    }

    function toComboIndexReverse($val) {
        switch( $val ) {
        case 0:
        case 1:
        case 2:
            return $val;
        case 3 :
            return 0x10;
        default :
            return 0;
        }
    }

    // Content :
    AtSettingContent {
        ColumnLayout {
            AtCheckBox {
                id : enable

                text : "启动DO"
                checked : qmlSettings.doEnable
                onCheckedChanged: {
                    qmlSettings.doEnable = checked
                }
            }

            RowLayout {
                visible : enable.checked

                Text {
                    text: '触发条件 : '
                    font.pixelSize: 16
                }

                ComboBox {
                    width: 200
                    height: 20
                    currentIndex : toComboIndex(qmlSettings.doCondition0)
                    model: _conditionModel
                    font.pixelSize: 16
                    onCurrentIndexChanged : {
                        if( !pressed ) {
                            qmlSettings.doCondition0 = toComboIndexReverse(currentIndex);
                        }
                    }
                }

                ComboBox {
                    width: 200
                    height: 20
                    currentIndex : toComboIndex(qmlSettings.doCondition1)
                    model: _conditionModel
                    font.pixelSize: 16
                    onCurrentIndexChanged : {
                        if( !pressed ) {
                            qmlSettings.doCondition1 = toComboIndexReverse(currentIndex);
                        }
                    }
                }
            }

            RowLayout {
                visible : enable.checked

                Text {
                    text: '恢复条件 : '
                    font.pixelSize: 16
                }

                ComboBox {
                    width: 200
                    height: 20
                    currentIndex : toComboIndex(qmlSettings.doRecovery0)
                    model: _recoveryModel
                    font.pixelSize: 16
                    onCurrentIndexChanged : {
                        if( !pressed ) {
                            qmlSettings.doRecovery0 = toComboIndexReverse(currentIndex);
                        }
                    }
                }

                ComboBox {
                    width: 200
                    height: 20
                    currentIndex : toComboIndex(qmlSettings.doRecovery1)
                    model: _recoveryModel
                    font.pixelSize: 16
                    onCurrentIndexChanged : {
                        if( !pressed ) {
                            qmlSettings.doRecovery1 = toComboIndexReverse(currentIndex);
                        }
                    }
                }
            }
        }
    }
}
