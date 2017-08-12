import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Qt.labs.folderlistmodel 2.1
import '../styles'

AtSettingTemplate {

    $titleName : "解码失败设定"
    $titleImagePath : "../images/decodingFail.ico"
    property var _maxSaveImageModel : ["3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
    property var _remoteTarget : ["LOCAL","FTP"]
    property bool _isChanged : false

    function toMaxSaveImageComboIndex(maxsave) {
       return maxsave - 3;
    }

    $cbSaveButton : function() {
        if ( _isChanged ) {
            decodingFailDialog.open()
        } else {
            settingViews.pop()
        }
    }

    AtImageViewDialog {
        id : viewImagesDialog
        $title : "检视"
        $cbOnYes : function() {
            qmlSettings.imageStorageDoSave = true;
        }
    }

    FolderListModel {
        id : folderModel
        folder : "file://" + qmlSettings.imageStorageMemoryPath
        nameFilters : ["*.jpg"]
    }

    AtMessageDialog2 {
        id : enableViewDialog
        $text : "检视图片时，将不储存失败图片，确认继续!?"

        $cbOnYes : function () {
            qmlSettings.imageStorageDoSave = false;

            var urllist = new Array();
            for (var i = 0 ; i < folderModel.count ; i++) {
                urllist[i] = folderModel.get(i,"fileURL");
            }
            viewImagesDialog.$currentIdx = 0;
            viewImagesDialog.$imgurls = urllist; 
            viewImagesDialog.open(); 
        }

        $cbOnNo : function () {
        }
    }

    AtMessageDialog2 {
        id : decodingFailDialog
        $text : "系统必须重新启动才会生效,是否立即重启!?"
        $cbOnYes : function () {
            var exec = qmlSettings.systemReboot
        }
        $cbOnNo : function () {
            settingViews.pop()
        }
    }

    AtSettingContent {

        id : atDecodingFailSetting

        ColumnLayout {
            RowLayout {
                AtCheckBox {   
                id : saveDecodingFailedImage
                text : "启用解码失败图片储存"
                checked : qmlSettings.imageStorageEnable

                onPressed: {
                    _isChanged = true
                }

                onCheckedChanged : {

                    qmlSettings.imageStorageEnable = checked;
                    //btnView.visible = checked;
                    //rowSaveSetting.visible = checked;
                    //rowSaveRemoteSetting.visible = checked;
                    //rowFtpSetting.visible = checked && (cbRemoteTarget.currentIndex == 1);
                    }
                }
                AtButton {
                id : btnView
                $contentName : "检视"
                visible :  saveDecodingFailedImage.checked
                $cbOnClicked : function() {
                    enableViewDialog.open();
                    }
                }
             }

             RowLayout {
                 id : rowSaveSetting
                 visible :  saveDecodingFailedImage.checked
                 Text {
                    text: "最大储存张数 : "
                 }
                 ComboBox {
                    width: 50
                    height: 20
                    currentIndex : toMaxSaveImageComboIndex(qmlSettings.imageStorageKeepSize);
                    model: _maxSaveImageModel;
                    onCurrentIndexChanged : {
                        qmlSettings.imageStorageKeepSize = currentIndex + 3;
                      }
                }
            }

            RowLayout {
                id : rowSaveRemoteSetting
                visible :  saveDecodingFailedImage.checked
                Text {
                    text : "储存至远程空间 : "
                }
 
                ComboBox {     
                    id : cbRemoteTarget
                    width : 150
                    height: 20
                    visible :  saveDecodingFailedImage.checked
                    currentIndex : _remoteTarget.indexOf(
                                    qmlSettings.imageStorageRemoteType.toString().toUpperCase())
                    model: _remoteTarget
                    onPressedChanged: {
                        _isChanged = true
                    }

                    onCurrentIndexChanged : {
                        qmlSettings.imageStorageRemoteType = _remoteTarget[currentIndex].toLowerCase();
                   }
                }


                AtNetTextInput {
                    id : txtFTPAddress
                    $name : 'FTP地址'
                    $visible:  (saveDecodingFailedImage.checked && (cbRemoteTarget.currentIndex == 1))
                    $address : qmlSettings.imageStorageFTPServer
                    $cbOnTextChanged : function(val) {
                        _isChanged = true
                        txtFTPAddress.$address = val
                        qmlSettings.imageStorageFTPServer = val
                    }
                }

                Text {
                    id : txtPort
                    text : "端口 : "
                    visible : (saveDecodingFailedImage.checked && (cbRemoteTarget.currentIndex == 1))
                }
                AtTextInput {
                    id : inputPort
                    visible :  (saveDecodingFailedImage.checked && (cbRemoteTarget.currentIndex == 1))
                    $text : qmlSettings.imageStorageFTPPort
                    $cbOnTextChanged : function(val) {
                        qmlSettings.imageStorageFTPPort = val;
                    }
                }
           }

           RowLayout {
                id : rowFtpSetting
                visible :  (saveDecodingFailedImage.checked && (cbRemoteTarget.currentIndex == 1))
                Text {
                   text : "账号 : "
                } 
                AtTextInput {
                   id : inputFTPUser
                   $width : 80
                   $text : qmlSettings.imageStorageFTPUsername
                   $cbOnTextChanged : function(val) {
                        qmlSettings.imageStorageFTPUsername = val;
                   }
               }
               Text {
                   text : "密码 : "
               }
               AtTextInput {
                   id : inputFTPPassword
                   $width : 80
                   $text : qmlSettings.imageStorageFTPPassword
                   $cbOnTextChanged : function(val) {
                       qmlSettings.imageStorageFTPPassword = val;
                   }
               }
               Text {
                   text : "传送超时 : "
               }
               AtTextInput {
                   id : inputFTPTimeout
                   $width : 80
                   $text : qmlSettings.imageStorageFTPTimeout
                   $cbOnTextChanged : function(val) {
                       qmlSettings.imageStorageFTPTimeout = val;
                   }
             }
         }
       }
    }
}
