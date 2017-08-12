import QtQuick 2.7
import QtQuick.Controls 2.0

ComboBox {
    id : atComboBox

    property int $width : 50
    property int $height : 20
    property var $model
    property var $cbOnCurrentIndexChanged : null
    property int $currentIndex : 0

    width : $width
    height : $height
    model: $model
    currentIndex : $currentIndex
    onCurrentIndexChanged : {
        if ( atComboBox.$cbOnCurrentIndexChanged != null ) {
            atComboBox.$cbOnCurrentIndexChanged();
        }
    }
}
