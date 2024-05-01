import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI

// Custom your MainView here
RibbonPaperView{
    id: view
    anchors.fill: parent
    spacing: 0
    ColumnLayout{
        Layout.alignment: Qt.AlignCenter
        Layout.topMargin: 30
        spacing: 20
        RibbonText{
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 50
            text: "RibbonUI"
            font{
                pixelSize: 50
                bold: true
                italic: true
            }
        }
        Image {
            source: "qrc:/qt/qml/RibbonUI/resources/imgs/icon.png"
            fillMode:Image.PreserveAspectFit
            Layout.preferredHeight: 300
            Layout.preferredWidth: height
            Layout.alignment: Qt.AlignHCenter
            layer.enabled: true
            layer.effect: RibbonShadow{}
        }
        RibbonText{
            Layout.alignment: Qt.AlignHCenter
            text: "A Lightweight, minimalist and \nelegant Qt component library."
            font{
                pixelSize: 30
                bold: true
                italic: true
            }
        }
        RibbonText{
            Layout.alignment: Qt.AlignHCenter
            text: "Author: mentalfl0w"
            font{
                pixelSize: 25
                bold: true
                italic: true
            }
        }
        RibbonText{
            Layout.alignment: Qt.AlignHCenter
            text: "Email: mentalflow@ourdocs.cn"
            font{
                pixelSize: 25
                bold: true
                italic: true
            }
        }
        RibbonText{
            Layout.alignment: Qt.AlignHCenter
            text: `Current Version: V${RibbonUI.version}`
            font{
                pixelSize: 20
                bold: true
                italic: true
            }
        }
    }
}
