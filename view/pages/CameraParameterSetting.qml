import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import '../styles'

AtSettingTemplate {
    $titleName : "相机参数"
    $titleImagePath : "../images/cameraparameter.ico"

    property var _cameraModel : ["1", "2"]
    property int _index : 0
    property bool _visible : true // true : 1 , false 2
    property var _userResolution : initUserResolution()

    function initUserResolution() {
        var resolution = qmlSettings.cameraUserResolution;
        return resolution.split(";");
    }

    function toComboIndex($width, $height) {
        var resolution = $width + "x" + $height;
        return _userResolution.indexOf(resolution);
    }

    AtMessageDialog2 {
        id : cameraParameterDialog
        $text: "系统必须重新启动才会生效,是否立即重启!?"

        $cbOnYes: function() {
            qmlSettings.systemReboot
        }

        $cbOnNo: function() {
            settingViews.pop()
        }
    }

    AtSettingContent {
        id: cameraParameterSetting

        ColumnLayout {

            RowLayout {
                Text {
                    text: '选择相机 : '
                    font.pixelSize: 16
                }

                ComboBox {
                    id : cameraIndex
                    width: 200
                    height: 20
                    currentIndex : 0
                    model: _cameraModel
                    font.pixelSize: 16
                    onCurrentIndexChanged : {

                    }
                }
            }

            ColumnLayout {
                visible: (cameraIndex.currentIndex == 0)?true:false
                RowLayout {
                    spacing: 8

                    Text {
                        text: '分辨率 : '
                        font.pixelSize: 16
                    }

                    ComboBox {
                        width: 300
                        height: 20
                        currentIndex : toComboIndex(qmlSettings.cameraImageWidthMax0,
                                                    qmlSettings.cameraImageHeightMax0)
                        model: _userResolution
                        font.pixelSize: 16
                        onCurrentIndexChanged: {
                            if ( !pressed ) {
                                var resolution = _userResolution[currentIndex].split("x")
                                qmlSettings.cameraImageWidthMax0 = resolution[0];
                                qmlSettings.cameraImageHeightMax0 = resolution[1];
                                cameraParameterDialog.open();
                            }
                        }
                    }

                    Text {
                        text: " (该相机最大分辨率 : "+qmlSettings.cameraDeviceImageWidthMax0+"x"+qmlSettings.cameraDeviceImageHeightMax0+")";
                        font.pixelSize: 16
                    }
                }

                RowLayout {
                    RowLayout {
                        spacing: 8

                        Text {
                            text: '曝光时间 : '
                            font.pixelSize: 16
                        }

                        AtSpinBox {
                            id : exposureTime0
                            $from : qmlSettings.cameraExposureTimeRangeMin0
                            $to : qmlSettings.cameraExposureTimeRangeMax0
                            $stepSize : qmlSettings.cameraExposureTimeStep0
                            value: qmlSettings.cameraExposureTime0
                            onValueChanged: {
                                qmlSettings.cameraExposureTime0 = exposureTime0.value
                            }
                        }


                        Text {
                            text: " ("+qmlSettings.cameraExposureTimeRangeMin0+" - "+qmlSettings.cameraExposureTimeRangeMax0+")";
                            font.pixelSize: 16
                        }
                    }


                    RowLayout {
                        spacing: 8
                        visible: true
                        Text {
                            text: '亮度范围 : '
                            font.pixelSize: 16
                        }

                        AtSpinBox {
                            id : brightness0
                            $from : qmlSettings.cameraBrightnessRangeMin0
                            $to : qmlSettings.cameraBrightnessRangeMax0
                            value: qmlSettings.cameraBrightness0
                            onValueChanged: {
                                qmlSettings.cameraBrightness0 = brightness0.value
                            }
                        }

                        Text {
                            text: " ("+qmlSettings.cameraBrightnessRangeMin0+" - "+qmlSettings.cameraBrightnessRangeMax0+")";
                            font.pixelSize: 16
                        }
                    }

                }

                RowLayout {
                    RowLayout {
                        spacing: 8

                        Text {
                            text: '增益范围 : '
                            font.pixelSize: 16
                        }

                        AtSpinBox {
                            id : cameraGain0
                            $from : qmlSettings.cameraGainRangeMin0
                            $to : qmlSettings.cameraGainRangeMax0
                            value: qmlSettings.cameraGain0
                            onValueChanged: {
                                qmlSettings.cameraGain0 = cameraGain0.value
                            }
                        }


                        Text {
                            text: " ("+qmlSettings.cameraGainRangeMin0+" - "+qmlSettings.cameraGainRangeMax0+")";
                            font.pixelSize: 16
                        }
                    }

                    RowLayout {
                        spacing: 8
                        visible: false
                        Text {
                            text: '伽马范围 : '
                            font.pixelSize: 16
                        }

                        AtSpinBox {
                            id : cameraGamma0
                            $from : qmlSettings.cameraGammaRangeMin0
                            $to : qmlSettings.cameraGammaRangeMax0
                            value: qmlSettings.cameraGamma0
                            onValueChanged: {
                                qmlSettings.cameraGamma0 = cameraGamma0.value
                            }
                        }

                        Text {
                            text: " ("+qmlSettings.cameraGammaRangeMin0+" - "+qmlSettings.cameraGammaRangeMax0+")";
                            font.pixelSize: 16
                        }
                    }
                    RowLayout {
                        spacing: 8
                        visible: true
                        Text {
                            text: '对比范围 : '
                            font.pixelSize: 16
                        }

                        AtSpinBox {
                            id : contrast0
                            $from : qmlSettings.cameraContrastRangeMin0
                            $to : qmlSettings.cameraContrastRangeMax0
                            value: qmlSettings.cameraContrast0
                            onValueChanged: {
                                qmlSettings.cameraContrast0 = contrast0.value
                            }
                        }

                        Text {
                            text: " ("+qmlSettings.cameraContrastRangeMin0+" - "+qmlSettings.cameraContrastRangeMax0+")";
                            font.pixelSize: 16
                        }
                    }

                }

                RowLayout {
                    spacing: 8
                    visible: false
                    Text {
                        text: '锐化范围 : '
                        font.pixelSize: 16
                    }

                    AtSpinBox {
                        id : sharpness0
                        $from : qmlSettings.cameraSharpnessRangeMin0
                        $to : qmlSettings.cameraSharpnessRangeMax0
                        value: qmlSettings.cameraSharpness0
                        onValueChanged: {
                            qmlSettings.cameraSharpness0 = sharpness0.value
                        }
                    }

                    Text {
                        text: " ("+qmlSettings.cameraSharpnessRangeMin0+" - "+qmlSettings.cameraSharpnessRangeMax0+")";
                        font.pixelSize: 16
                    }
                }



                RowLayout {
                    spacing: 8
                    visible: false
                    Text {
                        text: '饱和范围 : '
                        font.pixelSize: 16
                    }

                    AtSpinBox {
                        id : saturation0
                        $from : qmlSettings.cameraSaturationRangeMin0
                        $to : qmlSettings.cameraSaturationRangeMax0
                        value: qmlSettings.cameraSaturation0
                        onValueChanged: {
                            qmlSettings.cameraSaturation0 = saturation0.value
                        }
                    }

                    Text {
                        text: " ("+qmlSettings.cameraSaturationRangeMin0+" - "+qmlSettings.cameraSaturationRangeMax0+")";
                        font.pixelSize: 16
                    }
                }
            }
            ColumnLayout {
                spacing: 6
                visible: (cameraIndex.currentIndex == 1)?true:false

                RowLayout {
                    spacing: 8

                    Text {
                        text: '分辨率 : '
                        font.pixelSize: 16
                    }

                    ComboBox {
                        width: 300
                        height: 20
                        currentIndex : toComboIndex(qmlSettings.cameraImageWidthMax1,
                                                    qmlSettings.cameraImageHeightMax1)
                        model: _userResolution
                        font.pixelSize: 16
                        onCurrentIndexChanged : {
                            if ( !pressed ) {
                                var resolution = _userResolution[currentIndex].split("x")
                                qmlSettings.cameraImageWidthMax1 = resolution[0];
                                qmlSettings.cameraImageHeightMax1 = resolution[1];
                                cameraParameterDialog.open();
                            }
                        }
                    }

                    Text {
                        text: " (该相机最大分辨率 : "+qmlSettings.cameraDeviceImageWidthMax1+"x"+qmlSettings.cameraDeviceImageHeightMax1+")";
                        font.pixelSize: 16
                    }
                }

                RowLayout {
                    RowLayout {
                        spacing: 8

                        Text {
                            text: '曝光时间 : '
                            font.pixelSize: 16
                        }

                        AtSpinBox {
                            id : exposureTime1
                            $from : qmlSettings.cameraExposureTimeRangeMin1
                            $to : qmlSettings.cameraExposureTimeRangeMax1
                            $stepSize : qmlSettings.cameraExposureTimeStep1
                            value: qmlSettings.cameraExposureTime1
                            onValueChanged: {
                                qmlSettings.cameraExposureTime1 = exposureTime1.value
                            }
                        }

                        Text {
                            text: " ("+qmlSettings.cameraExposureTimeRangeMin1+" - "+qmlSettings.cameraExposureTimeRangeMax1+")";
                            font.pixelSize: 16
                        }
                    }

                    RowLayout {
                        spacing: 8
                        visible: true
                        Text {
                            text: '亮度范围 : '
                            font.pixelSize: 16
                        }

                        AtSpinBox {
                            id : brightness1
                            $from : qmlSettings.cameraBrightnessRangeMin1
                            $to : qmlSettings.cameraBrightnessRangeMax1
                            value: qmlSettings.cameraBrightness1
                            onValueChanged: {
                                qmlSettings.cameraBrightness1 = brightness1.value
                            }
                        }

                        Text {
                            text: " ("+qmlSettings.cameraBrightnessRangeMin1+" - "+qmlSettings.cameraBrightnessRangeMax1+")";
                            font.pixelSize: 16
                        }
                    }

                }

                RowLayout {
                    RowLayout {
                        spacing: 8

                        Text {
                            text: '增益范围 : '
                            font.pixelSize: 16
                        }

                        AtSpinBox {
                            id : cameraGain1
                            $from : qmlSettings.cameraGainRangeMin1
                            $to : qmlSettings.cameraGainRangeMax1
                            value: qmlSettings.cameraGain1
                            onValueChanged: {
                                qmlSettings.cameraGain1 = cameraGain1.value
                            }
                        }


                        Text {
                            text: " ("+qmlSettings.cameraGainRangeMin1+" - "+qmlSettings.cameraGainRangeMax1+")";
                            font.pixelSize: 16
                        }
                    }

                    RowLayout {
                        spacing: 8
                        visible: false
                        Text {
                            text: '伽马范围 : '
                            font.pixelSize: 16
                        }

                        AtSpinBox {
                            id : cameraGamma1
                            $from : qmlSettings.cameraGammaRangeMin1
                            $to : qmlSettings.cameraGammaRangeMax1
                            value: qmlSettings.cameraGamma1
                            onValueChanged: {
                                qmlSettings.cameraGamma1 = cameraGamma1.value
                            }
                        }

                        Text {
                            text: " ("+qmlSettings.cameraGammaRangeMin1+" - "+qmlSettings.cameraGammaRangeMax1+")";
                            font.pixelSize: 16
                        }
                    }

                    RowLayout {
                        spacing: 8
                        visible: true
                        Text {
                            text: '对比范围 : '
                            font.pixelSize: 16
                        }

                        AtSpinBox {
                            id : contrast1
                            $from : qmlSettings.cameraContrastRangeMin1
                            $to : qmlSettings.cameraContrastRangeMax1
                            value: qmlSettings.cameraContrast1
                            onValueChanged: {
                                qmlSettings.cameraContrast1 = contrast1.value
                            }
                        }

                        Text {
                            text: " ("+qmlSettings.cameraContrastRangeMin1+" - "+qmlSettings.cameraContrastRangeMax1+")";
                            font.pixelSize: 16
                        }
                    }
                }

                RowLayout {
                    spacing: 8
                    visible: false
                    Text {
                        text: '锐化范围 : '
                        font.pixelSize: 16
                    }

                    AtSpinBox {
                        id : sharpness1
                        $from : qmlSettings.cameraSharpnessRangeMin1
                        $to : qmlSettings.cameraSharpnessRangeMax1
                        value: qmlSettings.cameraSharpness1
                        onValueChanged: {
                            qmlSettings.cameraSharpness1 = sharpness1.value
                        }
                    }

                    Text {
                        text: " ("+qmlSettings.cameraSharpnessRangeMin0+" - "+qmlSettings.cameraSharpnessRangeMax0+")";
                        font.pixelSize: 16
                    }
                }

                RowLayout {
                    spacing: 8
                    visible: false
                    Text {
                        text: '饱和范围 : '
                        font.pixelSize: 16
                    }

                    AtSpinBox {
                        id : saturation1
                        $from : qmlSettings.cameraSaturationRangeMin1
                        $to : qmlSettings.cameraSaturationRangeMax1
                        value: qmlSettings.cameraSaturation1
                        onValueChanged: {
                            qmlSettings.cameraSaturation1 = saturation1.value
                        }
                    }

                    Text {
                        text: " ("+qmlSettings.cameraSaturationRangeMin1+" - "+qmlSettings.cameraSaturationRangeMax1+")";
                        font.pixelSize: 16
                    }
                }
            }
        }
    }
}


