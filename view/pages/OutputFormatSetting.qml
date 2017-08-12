import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import '../styles'

AtSettingTemplate {

    $titleName : "输出格式设定"
    $titleImagePath : "../images/outputFormat48.ico"
    property var _cameraModel : ["1", "2"]
    property bool _correctValue : false

    AtMessageDialog2 {
        id : outFormatDialog
        $text : "资料合并输出,会启用所有相机。是否确定启动!?"

        $cbOnYes : function () {
            qmlSettings.outFormatEnableDataIntegration = true
        }
        $cbOnNo : function () {
            dataIntegration.checked = false
        }
    }

    AtMessageDialog2 {
        id : outFormatPreview
        $text : ""
        $cbOnYes : function () {
        }
    }

    // Content :
    AtSettingContent {
        id : atOutputFormat

        ColumnLayout {
            spacing: 6

            RowLayout {
                Text {
                    text : "前置码 : "
                }

                AtTextInput {
                    $width: 80
                    $text : qmlSettings.outFormatTagPrefix
                    $cbOnTextChanged : function(val) {
                        qmlSettings.outFormatTagPrefix = val
                    }
                }

                Text {
                    text : " | 分割码 : "
                }

                AtTextInput {
                    $width: 80
                    $text : qmlSettings.outFormatTagSeparator
                    $cbOnTextChanged : function(val) {
                        qmlSettings.outFormatTagSeparator = val
                    }
                }

                Text {
                    text : " | 后置码 : "
                }

                AtTextInput {
                    $width: 80
                    $text : qmlSettings.outFormatTagSuffix
                    $cbOnTextChanged : function(val) {
                        qmlSettings.outFormatTagSuffix = val
                    }
                }

                Text {
                    text : " | 失败码 : "
                }

                AtTextInput {
                    $width: 80
                    $text : qmlSettings.outFormatTagNoRead
                    $cbOnTextChanged : function(val) {
                        qmlSettings.outFormatTagNoRead = val
                    }
                }
            }

            RowLayout {
                AtCheckBox {
                    id: outputNoRead
                    text: "输出未解码讯息"
                    checked : qmlSettings.outFormatOutputTagNoRead
                    onCheckedChanged: {
                        qmlSettings.outFormatOutputTagNoRead = checked
                    }
                }
                AtCheckBox {
                    id: dataIntegration
                    text: "输出双相机资料合并"
                    checked : qmlSettings.outFormatEnableDataIntegration
                    onPressed: {
                        if ( !checked ) {
                            outFormatDialog.open()
                        }
                    }

                    onCheckedChanged: {

                        if ( checked ) {
                        } else {
                            qmlSettings.outFormatEnableDataIntegration = checked
                        }
                    }
                }
                AtCheckBox {
                   id: outputSuccessCount
                   text: "输出总解码成功次数"
                   checked: qmlSettings.outFormatEnableSuccessCount
                   onCheckedChanged: {
                       qmlSettings.outFormatEnableSuccessCount = checked
                   }
                }
                AtCheckBox {
                   id: outputFailureCount
                   text: "输出总解码失败次数"
                   checked: qmlSettings.outFormatEnableFailureCount
                   onCheckedChanged: {
                       qmlSettings.outFormatEnableFailureCount = checked
                   }
                }
            }

            RowLayout {
                AtCheckBox {
                   id: outputDecoderDate
                   text: "输出解码系统日期"
                   checked: qmlSettings.outFormatEnableDecoderDate
                   onCheckedChanged: {
                       qmlSettings.outFormatEnableDecoderDate = checked
                   }
                }
                AtCheckBox {
                   id: outputDecoderTime
                   text: "输出解码系统时间"
                   checked: qmlSettings.outFormatEnableDecoderTime
                   onCheckedChanged: {
                       qmlSettings.outFormatEnableDecoderTime = checked
                   }
                }
                AtCheckBox {
                   id: outputDICount
                   text: "输出DI触发次数"
                   checked: qmlSettings.outFormatEnableDICount
                   onCheckedChanged: {
                       qmlSettings.outFormatEnableDICount = checked
                   }
                }
                AtCheckBox {
                   id: outputDecodedCount
                   text: "输出解码数量"
                   checked: qmlSettings.outFormatEnableDecodedCount
                   onCheckedChanged: {
                       qmlSettings.outFormatEnableDecodedCount = checked
                   }
                }
            }

            RowLayout {
                AtCheckBox {
                   id: outputContent
                   text: "输出解码内容"
                   checked: qmlSettings.outFormatEnableContent
                   onCheckedChanged: {
                       qmlSettings.outFormatEnableContent = checked
                   }
                }
                AtCheckBox {
                   id: outputCameraNo
                   text: "输出相机编号"
                   checked: qmlSettings.outFormatEnableCameraNo
                   onCheckedChanged: {
                       qmlSettings.outFormatEnableCameraNo = checked
                   }
                }
                AtCheckBox {
                   id: outputFormatCode
                   text: "输出解码码制"
                   checked: qmlSettings.outFormatEnableFormatCode
                   onCheckedChanged: {
                       qmlSettings.outFormatEnableFormatCode = checked
                   }
                }
                AtCheckBox {
                   id: outputCoordinate
                   text: "输出解码坐标"
                   checked: qmlSettings.outFormatEnableCoordinate
                   onCheckedChanged: {
                       qmlSettings.outFormatEnableCoordinate = checked
                   }
                }
                AtButton {
                    $contentName : "测试输出格式"
                    $cbOnClicked : function() {
                        var field = "<前置码>";
                        var value = "(Prefix=\"" + qmlSettings.outFormatTagPrefix  +
                                    "\";Separator=\"" + qmlSettings.outFormatTagSeparator  +
                                    "\";Suffix=\"" + qmlSettings.outFormatTagSuffix  + "\") ";

                        value = value + qmlSettings.outFormatTagPrefix;
                        var sep = qmlSettings.outFormatTagSeparator;
                        if (qmlSettings.outFormatEnableSuccessCount == true) {
                           field =  field + "<总解码成功次数>";
                           value = value + "10" + sep;
                        }
                        if (qmlSettings.outFormatEnableFailureCount == true) {
                           field =  field + "<总解码失败次数>";
                           value = value + "3" + sep;
                        }
                        if (qmlSettings.outFormatEnableDecoderDate == true) {
                           field = field + "<解码系统日期>";
                           value = value + "20170504" + sep;
                        }
                        if (qmlSettings.outFormatEnableDecoderTime == true) {
                           field = field + "<解码系统时间>";
                           value = value + "131502" + sep;
                        }
                        if (qmlSettings.outFormatEnableDICount == true) {
                           field = field + "<DI触发次数>";
                           value = value + "1" + sep + "1" + sep;
                        }
                        if (qmlSettings.outFormatEnableDecodedCount == true) {
                           field = field + "<解码数量>";
                           value = value + "2,0" + sep;
                        }

                        field = field + "[";

                        if (qmlSettings.outFormatEnableCameraNo == true) {
                           field = field + "<相机编号>";
                           value = value + "1" + sep;
                        }
                        if (qmlSettings.outFormatEnableFormatCode == true) {
                           field = field + "<解码码制>";
                           value = value + "QR" + sep;
                        }
                        if (qmlSettings.outFormatEnableCoordinate == true) {
                           field = field + "<解码坐标>";
                           value = value + "20" + sep + "20" + sep
                                         + "30" + sep + "20" + sep
                                         + "20" + sep + "30" + sep
                                         + "30" + sep + "30" + sep;
                        }
                        if (qmlSettings.outFormatEnableContent == true) {
                           field = field + "<解码内容>";
                           value = value + "http://test1" + sep;
                        }

                        if (qmlSettings.outFormatEnableDataIntegration) {
                           if (qmlSettings.outFormatEnableDecoderTime == true) {
                            value = value + "http://test2" + sep;
                           }
                           if (qmlSettings.outFormatEnableCameraNo == true) {
                                value = value + "2" + sep;
                           }
                           if (qmlSettings.outFormatEnableFormatCode == true) {
                                value = value + "QR" + sep;
                           }
                           if (qmlSettings.outFormatEnableDecoderTime == true) {
                                value = value + "50" + sep + "50" + sep + "30" +sep +"30" + sep;
                           }
                        }

                        field = field + "]<后置码>";

                        var res = value.substring(0,value.length -1) + qmlSettings.outFormatTagSuffix;;
                        outFormatPreview.width = 640;
                        outFormatPreview.height = 240;
                        outFormatPreview.text = field + "\r\n" + res;
                        outFormatPreview.open();
                        }
                    }
                }
        }
    }
}
