import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import '../styles'

AtSettingTemplate {

    $titleName : "条码设定"
    $titleImagePath : "../images/barcode.ico"

    property bool isChanged : false

    $cbSaveButton : function() {
        settingViews.pop()
    }


    AtSettingContent {
        id: decodeSetting
        ColumnLayout {
            spacing: 6
            RowLayout {
                /* 1D */
                AtCheckBox {
                    id: upc
                    text: "UPC/EAN/JAN"
                    visible : true
                    checked: qmlSettings.decoderUPC_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderUPC_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderUPC_0 = 1
                            } else {
                                qmlSettings.decoderUPC_0 = 0
                            }
                        }
                    }
                }

                AtCheckBox {
                    id: c11
                    text: "C11"
                    checked: qmlSettings.decoderC11_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderC11_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderC11_0 = 1
                            } else {
                                qmlSettings.decoderC11_0 = 0
                            }
                        }
                    }
                }

                AtCheckBox {
                    id: c39
                    text: "C39"
                    checked: qmlSettings.decoderC39_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderC39_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderC39_0 = 1
                            } else {
                                qmlSettings.decoderC39_0 = 0
                            }
                        }
                    }
                }

                AtCheckBox {
                    id: c93
                    text: "C93"
                    checked: qmlSettings.decoderC93_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderC93_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderC93_0 = 1
                            } else {
                                qmlSettings.decoderC93_0 = 0
                            }
                        }
                    }
                }

                AtCheckBox {
                    id: c128
                    text: "C128"
                    checked: qmlSettings.decoderC128_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderC128_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderC128_0 = 1
                            } else {
                                qmlSettings.decoderC128_0 = 0
                            }
                        }
                    }
                }

                AtCheckBox {
                    id: i25
                    visible: true
                    text: "I25"
                    checked: qmlSettings.decoderI25_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderI25_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderI25_0 = 1
                            } else {
                                qmlSettings.decoderI25_0 = 0
                            }
                        }
                    }
                }
            }

            RowLayout {
                AtCheckBox {
                    id: nec25
                    text: "NEC25"
                    visible: true
                    checked: qmlSettings.decoderNEC25_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderNEC25_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderNEC25_0 = 1
                            } else {
                                qmlSettings.decoderNEC25_0 = 0
                            }
                        }
                    }
                }

                AtCheckBox {
                    id: pharma
                    text: "PHARMA"
                    visible: false
                    checked: qmlSettings.decoderPHARMA_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderPHARMA_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderPHARMA_0 = 1
                            } else {
                                qmlSettings.decoderPHARMA_0 = 0
                            }
                        }
                    }
                }


                AtCheckBox {
                    id: m25
                    text: "M25"
                    visible: true
                    checked: qmlSettings.decoderM25_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderM25_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderM25_0 = 1
                            } else {
                                qmlSettings.decoderM25_0 = 0
                            }
                        }
                    }
                }

                AtCheckBox {
                    id: s25
                    text: "S25"
                    visible: true
                    checked: qmlSettings.decoderS25_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderS25_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderS25_0 = 1
                            } else {
                                qmlSettings.decoderS25_0 = 0
                            }
                        }
                    }
                }

                AtCheckBox {
                    id: cb
                    text: "CB"
                    visible: true
                    checked: qmlSettings.decoderCB_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderCB_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderCB_0 = 1
                            } else {
                                qmlSettings.decoderCB_0 = 0
                            }
                        }
                    }
                }
            }

            RowLayout {
                AtCheckBox {
                    id: az
                    text: "AZ"
                    visible: true
                    checked: qmlSettings.decoderAZ_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderAZ_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderAZ_0 = 1
                            } else {
                                qmlSettings.decoderAZ_0 = 0
                            }
                        }
                    }
                }

                AtCheckBox {
                    id: dm
                    text: "DM"
                    checked: qmlSettings.decoderDM_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderDM_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderDM_0 = 1
                            } else {
                                qmlSettings.decoderDM_0 = 0
                            }
                        }
                    }
                }

                AtCheckBox {
                    id: dmRect
                    text: "DM_RECT"
                    checked: qmlSettings.decoderDmRect_0
                    visible: dm.checked
                    onCheckedChanged: {
                        if ( qmlSettings.decoderDmRect_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderDmRect_0 = 1
                            } else {
                                qmlSettings.decoderDmRect_0 = 0
                            }
                        }
                    }
                }

                AtCheckBox {
                    id: dmInverse
                    text: "DM_INVERSE"
                    checked: qmlSettings.decoderDmInverse_0
                    visible: dm.checked
                    onCheckedChanged: {
                        if ( qmlSettings.decoderDmInverse_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderDmInverse_0 = 1
                            } else {
                                qmlSettings.decoderDmInverse_0 = 0
                            }
                        }
                    }
                }

                AtCheckBox {
                    id: qr
                    text: "QR"
                    checked: qmlSettings.decoderQR_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderQR_0 != checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderQR_0 = 1
                            } else {
                                qmlSettings.decoderQR_0 = 0
                            }
                        }
                    }
                }

                AtCheckBox {
                    id: qrInverse
                    text: "QR_INVERSE"
                    checked: qmlSettings.decoderQrInverse_0
                    visible: qr.checked

                    onCheckedChanged: {
                        if ( qmlSettings.decoderQrInverse_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderQrInverse_0 = 1
                            } else {
                                qmlSettings.decoderQrInverse_0 = 0
                            }
                        }
                    }
                }
            }

            RowLayout {
                AtCheckBox {
                    id: allowRepeat_0
                    text: "允许条码重覆"
                    checked: qmlSettings.decoderAllowRepeat_0

                    onCheckedChanged: {
                        if ( qmlSettings.decoderAllowRepeat_0 !== checked) {
                            isChanged = true
                            if(checked) {
                                qmlSettings.decoderAllowRepeat_0 = 1
                            } else {
                                qmlSettings.decoderAllowRepeat_0 = 0
                            }
                        }
                    }
                }
            }
        }
    }
}
