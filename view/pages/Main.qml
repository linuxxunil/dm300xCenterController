import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import '../styles'

AtMainTemplate {
    id : main
    property alias atTabView1: atTabView1
    $titleName : "ProScan 设定选单"
    $titleImagePath : "../images/settings.ico"

    AtTabView {
        id: atTabView1
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        anchors.topMargin: 42
        anchors.bottomMargin: 8
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        AtTab {
            $title: "        一般        "
            $layout : RowLayout {
                spacing : 16
                AtMainItem {
                    $itemName : "一般设定"
                    $itemImagePath : "../images/general48.ico"
                    $itemUrl : "GeneralSetting.qml"
                }

                AtMainItem {
                    $itemName : "设定档设定"
                    $itemImagePath : "../images/configs48.ico"
                    $itemUrl : "ConfigsSetting.qml"
                }

                AtMainItem {
                    $itemName : "音效设定"
                    $itemImagePath : "../images/audio48.ico"
                    $itemUrl : "AudioSetting.qml"
                }
            }
        }

        AtTab {
            $title: "        影像        "
            $layout : RowLayout {
                spacing : 16
                AtMainItem {
                    $itemName : "影像设定"
                    $itemImagePath : "../images/display48.ico"
                    $itemUrl : "DisplaySetting.qml"
                }

                AtMainItem {
                    $itemName : "相机设定"
                    $itemImagePath : "../images/camera48.ico"
                    $itemUrl : "CameraSetting.qml"
                }

                AtMainItem {
                    $itemName : "相机参数"
                    $itemImagePath : "../images/cameraparameter48.ico"
                    $itemUrl : "CameraParameterSetting.qml"
                }
            }
        }

        AtTab {
            $title: "        条码        "
            $layout : RowLayout {
                spacing : 16

                AtMainItem {
                    $itemName : "条码设定"
                    $itemImagePath : "../images/barcode48.ico"
                    $itemUrl : "DecoderSetting.qml"
                }

                AtMainItem {
                    $itemName : "输出格式"
                    $itemImagePath : "../images/outputFormat48.ico"
                    $itemUrl : "OutputFormatSetting.qml"
                }

                AtMainItem {
                    $itemName : "内容验证"
                    $itemImagePath : "../images/dataValidation48.ico"
                    $itemUrl : "DataValidationSetting.qml"
                }

                AtMainItem {
                    $itemName : "内容过滤"
                    $itemImagePath : "../images/dataFilter48.ico"
                    $itemUrl : "DataFilterSetting.qml"
                }

                AtMainItem {
                    $itemName : "缓存输出"
                    $itemImagePath : "../images/bufferOutput48.ico"
                    $itemUrl : "BufferOutputSetting.qml"
                }

                AtMainItem {
                    $itemName : "解码失败"
                    $itemImagePath : "../images/decodingFail48.ico"
                    $itemUrl : "DecodingFailSetting.qml"
                }
            }
        }

        AtTab {
            $title: "        通讯        "
            $layout : RowLayout {
                spacing : 16
                AtMainItem {
                    $itemName : "网卡设定"
                    $itemImagePath : "../images/nic48.ico"
                    $itemUrl : "NicSetting.qml"
                }

                AtMainItem {
                    $itemName : "串口设定"
                    $itemImagePath : "../images/uart48.ico"
                    $itemUrl : "UartSetting.qml"
                }

                AtMainItem {
                    $itemName : "DbClient"
                    $itemImagePath : "../images/dbclient48.ico"
                    $itemUrl : "DatabaseClientSetting.qml"
                }
//                AtMainItem {
//                    $itemName : "HttpClient"
//                    $itemImagePath : "../images/httpclient48.ico"
//                    $itemUrl : "HttpClientSetting.qml"
//                }

                AtMainItem {
                    $itemName : "多主机设定"
                    $itemImagePath : "../images/multidev48.ico"
                    $itemUrl : "MultiDeviceSetting.qml"
                }
            }
        }

        AtTab {
            $title: " 外部输入/输出 "
            $layout : RowLayout {
                spacing : 16
                AtMainItem {
                    $itemName : "DI设定"
                    $itemImagePath : "../images/di48.ico"
                    $itemUrl : "DiSetting.qml"
                }

                AtMainItem {
                    $itemName : "DO设定"
                    $itemImagePath : "../images/do48.ico"
                    $itemUrl : "DoSetting.qml"
                }
            }
        }





        AtTab {
            $title: "        系统        "
            $layout : RowLayout {
                spacing : 16
                AtMainItem {
                    $itemName : "自我检测"
                    $itemImagePath : "../images/inspect48.ico"
                    $itemUrl : "InspectInfo.qml"
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
                    $itemName : "系统资讯"
                    $itemImagePath : "../images/systemInfo48.ico"
                    $itemUrl : "SystemInfo.qml"
                }


                AtMainItem {
                    $itemName : "关於我们"
                    $itemImagePath : "../images/about48.ico"
                    $itemUrl : "About.qml"
                }
            }
        }

    }

//    AtMainContent {
//        ColumnLayout {
//            x: 11
//            y: 0
//            width: 724
//            height: 134
//            spacing: 12
//            RowLayout {
//                spacing: 28
//                AtMainItem {
//                    $itemName : "一般设定"
//                    $itemImagePath : "../images/general48.ico"
//                    $itemUrl : "GeneralSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "影像设定"
//                    $itemImagePath : "../images/display48.ico"
//                    $itemUrl : "DisplaySetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "相机设定"
//                    $itemImagePath : "../images/camera48.ico"
//                    $itemUrl : "CameraSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "相机参数"
//                    $itemImagePath : "../images/cameraparameter48.ico"
//                    $itemUrl : "CameraParameterSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "解码器"
//                    $itemImagePath : "../images/barcode48.ico"
//                    $itemUrl : "DecoderSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "DI设定"
//                    $itemImagePath : "../images/di48.ico"
//                    $itemUrl : "DiSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "DO设定"
//                    $itemImagePath : "../images/do48.ico"
//                    $itemUrl : "DoSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "设定档设定"
//                    $itemImagePath : "../images/configs48.ico"
//                    $itemUrl : "ConfigsSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "音效设定"
//                    $itemImagePath : "../images/audio48.ico"
//                    $itemUrl : "AudioSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "输出格式设定"
//                    $itemImagePath : "../images/outputFormat48.ico"
//                    $itemUrl : "OutputFormatSetting.qml"
//                }

//            }
//            RowLayout {
//                spacing: 28

//                AtMainItem {
//                    $itemName : "解码失败设定"
//                    $itemImagePath : "../images/decodingFail48.ico"
//                    $itemUrl : "DecodingFailSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "内容验证设定"
//                    $itemImagePath : "../images/contentFilter48.ico"
//                    $itemUrl : "ContentFilterSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "串口设定"
//                    $itemImagePath : "../images/uart48.ico"
//                    $itemUrl : "UartSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "HttpClient"
//                    $itemImagePath : "../images/httpclient48.ico"
//                    $itemUrl : "HttpClientSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "DbClient"
//                    $itemImagePath : "../images/dbclient48.ico"
//                    $itemUrl : "DatabaseClientSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "网卡设定"
//                    $itemImagePath : "../images/nic48.ico"
//                    $itemUrl : "NicSetting.qml"
//                }


//                AtMainItem {
//                    $itemName : "自我检测"
//                    $itemImagePath : "../images/inspect48.ico"
//                    $itemUrl : "InspectInfo.qml"
//                }

//                AtMainItem {
//                    $itemName : "时间设定"
//                    $itemImagePath : "../images/time48.ico"
//                    $itemUrl : "TimeSetting.qml"
//                }

//                AtMainItem {
//                    $itemName : "多主机设定"
//                    $itemImagePath : "../images/multidev48.ico"
//                    $itemUrl : "MultiDeviceSetting.qml"
//                }


//                AtMainItem {
//                    $itemName : "系统设定"
//                    $itemImagePath : "../images/system48.ico"
//                    $itemUrl : "SystemSetting.qml"
//                }


//                AtMainItem {
//                    $itemName : "关於我们"
//                    $itemImagePath : "../images/about48.ico"
//                    $itemUrl : "About.qml"
//                }

//            }
//        }
//    }
}
