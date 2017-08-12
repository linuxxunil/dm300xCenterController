import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Qt.labs.folderlistmodel 2.1
import '../styles'

AtSettingTemplate {
   $titleName : "内容过滤设定"
   $titleImagePath : "../images/dataFilter.ico"
   property var _cameraNo : ["1","2"]
   property var _contentRules : ["1","2","3","4","5"]
   property var _keepType : ["指定验证條件的資料","非指定验证條件的資料"]
   property var _matchContentMode : ["None","Prefix","Suffix","All","Regular Expression"]
   property var _contentSymbology : ["None","QR","DM","UPC","C11","C39","C93","C128","I25","NEC25","PHARMA","M25","S25","AZ"]
   property var _dvFilter : JSON.parse(qmlSettings.dataFilter);

   AtSettingContent {
        id : atDataFilterSetting
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
                    text: "保留"
               }
               AtComboBox {
                    id : keepTypeIndex
                    $model: _keepType
                    $currentIndex : _dvFilter[cameraIndex.currentIndex].keepTypeIndex;
                    $cbOnCurrentIndexChanged : function() {
                        _dvFilter[cameraIndex.currentIndex].keepTypeIndex = parseInt(currentIndex);
                        qmlSettings.dataFilter = JSON.stringify(_dvFilter);
                    } 
               }
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
                    id : enableRule
                    text: "启用"
                    checked: _dvFilter[cameraIndex.currentIndex].rules[contentRules.currentIndex].enable;
                    onCheckedChanged: {
                        _dvFilter[cameraIndex.currentIndex].rules[contentRules.currentIndex].enable = checked;
                        qmlSettings.dataFilter = JSON.stringify(_dvFilter);

                    }
               }
           }
           RowLayout {
               id : rowContentLength
               visible: enableRule.checked
               Text {
                   text : "内容长度 : "
               }
               AtSpinBox {
                   id : sContentLength 
               	   $from : 0
                   $to : 64
                   $value : _dvFilter[cameraIndex.currentIndex].rules[contentRules.currentIndex].ContentLength;
                   $cbOnValueChanged : function() { 
                        _dvFilter[cameraIndex.currentIndex].rules[contentRules.currentIndex].ContentLength = sContentLength.value;
                        qmlSettings.dataFilter = JSON.stringify(_dvFilter);

                   }
               } 
           }
           RowLayout {
               visible :  enableRule.checked
               Text {
                    text : "条码类型 : "
               }
               AtComboBox {
                    id : contentSymbology
                    visible : enableRule.checked
                    $width: 50
                    $height: 20
                    $model: _contentSymbology
                    $currentIndex : _dvFilter[cameraIndex.currentIndex].rules[contentRules.currentIndex].SymbologyIdx;
                    $cbOnCurrentIndexChanged : function() {
                         _dvFilter[cameraIndex.currentIndex].rules[contentRules.currentIndex].SymbologyIdx = parseInt(currentIndex);
                         qmlSettings.dataFilter = JSON.stringify(_dvFilter); 
                    }
               }

               Text {
                   text : "内容比对 : "
               }
               AtComboBox {
                   id : matchContentMode
                   visible : enableRule.checked
                   $width : 200
                   $model : _matchContentMode
                   $currentIndex : _dvFilter[cameraIndex.currentIndex].rules[contentRules.currentIndex].MatchModeIdx;
                   $cbOnCurrentIndexChanged : function() {
                        _dvFilter[cameraIndex.currentIndex].rules[contentRules.currentIndex].MatchModeIdx = parseInt(currentIndex);
                        qmlSettings.dataFilter = JSON.stringify(_dvFilter);
                   }
               }
               AtTextInput {
                    id : inputPattern
                    visible : enableRule.checked && matchContentMode.currentIndex != 0
                    $text : _dvFilter[cameraIndex.currentIndex].rules[contentRules.currentIndex].Pattern;
                    $width : 150
                    $cbOnTextChanged : function(val) {
                        _dvFilter[cameraIndex.currentIndex].rules[contentRules.currentIndex].Pattern = val;
                        qmlSettings.dataFilter = JSON.stringify(_dvFilter);
                    }

               }
           }
       }
   }
}
