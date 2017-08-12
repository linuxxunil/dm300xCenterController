import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Qt.labs.folderlistmodel 2.1
import '../styles'

AtSettingTemplate {

    $titleName : "内容验证设定"
    $titleImagePath : "../images/dataValidation.ico"
    property var _cameraNo : ["1","2"]
    property var _filterType : ["数量比对","内容比对"]
    property var _amountSymbology : ["QR","DM","UPC","C11","C39","C93","C128","I25","NEC25","PHARMA","M25","S25","AZ"]
    property var _contentSymbology : ["None","QR","DM","UPC","C11","C39","C93","C128","I25","NEC25","PHARMA","M25","S25","AZ"]

    property var _contentRules : ["1","2","3","4","5"]
    property var _matchContentMode : ["None","Prefix","Suffix","All","Regular Expression"]
    property var _dvContent : JSON.parse(qmlSettings.dataValidationContent);
    property var _dvAmount : JSON.parse(qmlSettings.dataValidationAmount);


    AtSettingContent {
        id : atDataValidationSetting

        ColumnLayout {
             RowLayout {
                 id : rowCameraAndType
                 visible : true
                 Text {
                    text: "选择相机 : "
                 }
                 AtComboBox {
                    id : cameraIndex
                    $width: 50
                    $height: 20
                    $model: _cameraNo
                    $currentIndex : 0
                 }
                 Text {
                     text: "验证类型 : "
                 }

                 AtComboBox {
                    id : filterType
                    $width: 50
                    $height: 20
                    $model: _filterType;
                 }

                 RowLayout {
                     visible : filterType.currentIndex == 1
                     Text {
                       text : "验证条件"
                     }
                     AtComboBox {
                         id : contentRules
                         $width: 50
                         $height: 20
                         $model: _contentRules
                     }

                     AtCheckBox {
                         id: enableContent
                         text: "启用"
                         checked : _dvContent[cameraIndex.currentIndex].rules[contentRules.currentIndex].enable;
                         onCheckedChanged: {

                            _dvContent[cameraIndex.currentIndex].rules[contentRules.currentIndex].enable = checked;
                            qmlSettings.dataValidationContent = JSON.stringify(_dvContent);
                         }
                     }
                 }
            }

            // Amount
            ColumnLayout {
                visible : filterType.currentIndex==0
                RowLayout {
                    Text {
                        text : "总条码数量 : 最小 "
                    }
                    AtTextInput {
                        id : inputTotalNumberMin
                        $text : _dvAmount[cameraIndex.currentIndex].totalMin
                        $cbOnTextChanged : function(val) {
                           _dvAmount[cameraIndex.currentIndex].totalMin = parseInt(val);
                           qmlSettings.dataValidationAmount = JSON.stringify(_dvAmount);
                        }
                    }
                    Text {
                        text : " 最大 "
                    }
                    AtTextInput {
                        id : inputTotalNumberMax
                        $text : _dvAmount[cameraIndex.currentIndex].totalMax;
                        $cbOnTextChanged : function(val) {
                           _dvAmount[cameraIndex.currentIndex].totalMax = parseInt(val);
                           qmlSettings.dataValidationAmount = JSON.stringify(_dvAmount);
                        }
                    }
                }

                RowLayout {
                  Text {
                      text : "条码类型 : "
                  }
                  AtComboBox {
                        id : amountSymbology
                        $width: 50
                        $height: 20
                        $model: _amountSymbology
                        $currentIndex: 0
                  }

                  Text {
                      text : "最小 "
                  }
                  AtTextInput {

                      $text :  _dvAmount[cameraIndex.currentIndex][_amountSymbology[amountSymbology.currentIndex]].Min;
                      $cbOnTextChanged : function(val) {
                          console.log(val);
                          _dvAmount[cameraIndex.currentIndex][_amountSymbology[amountSymbology.currentIndex]].Min = parseInt(val);
                          qmlSettings.dataValidationAmount = JSON.stringify(_dvAmount);
                      }
                  }
                  Text {
                      text : "最大 "
                  }
                  AtTextInput {
                      id : inputSymbologyNumberMax
                      $text :  _dvAmount[cameraIndex.currentIndex][_amountSymbology[amountSymbology.currentIndex]].Max;
                      $cbOnTextChanged : function(val) {
                          console.log(val);
                          _dvAmount[cameraIndex.currentIndex][_amountSymbology[amountSymbology.currentIndex]].Max = parseInt(val);
                          qmlSettings.dataValidationAmount = JSON.stringify(_dvAmount);
                      }
                  }
                }

            }

            // Content
            ColumnLayout {
                visible : (filterType.currentIndex==1)

                RowLayout {
                    visible : enableContent.checked
                    Text {
                      text : "内容长度 : "
                    }
                    AtSpinBox {
                        id : sContentLength
                        visible : enableContent.checked
                        $from : 0
                        $to : 64
                        $value:  _dvContent[cameraIndex.currentIndex].rules[contentRules.currentIndex].ContentLength
                        $cbOnValueChanged: function() {
                            _dvContent[cameraIndex.currentIndex].rules[contentRules.currentIndex].ContentLength = sContentLength.value;
                            qmlSettings.dataValidationContent = JSON.stringify(_dvContent);
                        }
                    }
                }

                RowLayout {
                    visible : enableContent.checked
                    Text {
                      text : "条码类型 : "
                    }
                    AtComboBox {
                        id : contentSymbology
                        visible : enableContent.checked
                        $width: 50
                        $height: 20
                        $model: _contentSymbology
                        $currentIndex : _dvContent[cameraIndex.currentIndex].rules[contentRules.currentIndex].SymbologyIdx

                        $cbOnCurrentIndexChanged : function() {
                            _dvContent[cameraIndex.currentIndex].rules[contentRules.currentIndex].SymbologyIdx = parseInt(currentIndex);
                            qmlSettings.dataValidationContent = JSON.stringify(_dvContent);
                        }
                    }

                    Text {
                        text : "内容比对 : "
                    }
                    AtComboBox {
                        id : matchContentMode
                        visible : enableContent.checked
                        $width : 200
                        $model : _matchContentMode
                        $currentIndex : _dvContent[cameraIndex.currentIndex].rules[contentRules.currentIndex].MatchModeIdx;
                        $cbOnCurrentIndexChanged : function() {

                            _dvContent[cameraIndex.currentIndex].rules[contentRules.currentIndex].MatchModeIdx = parseInt(currentIndex);
                            qmlSettings.dataValidationContent = JSON.stringify(_dvContent);
                        }
                    }
                    AtTextInput {
                        id : inputPattern
                        visible : enableContent.checked && matchContentMode.currentIndex != 0
                        $text : _dvContent[cameraIndex.currentIndex].rules[contentRules.currentIndex].Pattern;
                        $width : 150
                        $cbOnTextChanged : function(val) {
                           _dvContent[cameraIndex.currentIndex].rules[contentRules.currentIndex].Pattern = val;
                           qmlSettings.dataValidationContent = JSON.stringify(_dvContent);
                        }
                    }
                }
            }
        }
    }
}
