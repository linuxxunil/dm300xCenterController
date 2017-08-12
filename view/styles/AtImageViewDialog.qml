import QtQuick 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4


Dialog {
    property string $title : "title"
    property var $imgurls : []
    property var $cbOnYes : null
    property var $cbOnNo : null

    id: imageViewDialog
    title: $title

    property var $currentIdx: 0
    width : 640
    height : 400

    function basename(path) {
        return path.replace(/\\/g,'/').replace( /.*\//, '' );
    }

    function dirname(path) {
        return path.replace(/\\/g,'/').replace(/\/[^\/]*$/, '');;
    }


    ColumnLayout {
       Rectangle {

          Layout.alignment : Qt.AlignHCenter
          Layout.preferredWidth : 615
          Layout.preferredHeight : 400 * 0.8
          Image {
            id : imgView
            width : parent.width
            height : parent.height
            source :  String($imgurls[0]);
            fillMode : Image.Stretch
         }
       }

       RowLayout {
           Text {
               text : "档案名称 : "
           }

           Text {
               id : fileName
               text : basename(String($imgurls[0]));
           }
       }

       RowLayout {
           Button {
               text : "上一张"
               onClicked : {
                 if ($imgurls.length <= 0)
                     return;

                 if ($currentIdx > 0)
                    $currentIdx--;

                 imgView.source = $imgurls[$currentIdx];
                 fileName.text = basename(String($imgurls[$currentIdx]));
               }
           }
           Button {
               text : "下一张"
                 onClicked : {
                     if ($imgurls.length <= 0)
                         return;

                     if ($currentIdx < $imgurls.length - 1)
                         $currentIdx++;

                    imgView.source = $imgurls[$currentIdx];
                    fileName.text = basename(String($imgurls[$currentIdx]));
                }
           }

           Button {
               text : "离开"
                 onClicked : {
                    if ( imageViewDialog.$cbOnYes != null ) {
                        imageViewDialog.$cbOnYes();
                    }
                    imageViewDialog.close();
               }
            }
        }
    }

    standardButtons : StandardButton.NoButton
    Component.onCompleted: visible = false

    //onYes : {
    //    if ( imageViewDialog.$cbOnYes != null ) {
    //        imageViewDialog.$cbOnYes();
    //    }
    //}
}


