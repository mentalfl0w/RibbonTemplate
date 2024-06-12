import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI

// Custom your TabBar here
RibbonTabBar {
    id: control
    rightToolBar: RowLayout{
        spacing: 10
        RibbonButton{
            text:"Test Button 1"
            iconSource: RibbonIcons.EmojiSmileSlight
            checkable: true
        }
    }
    RibbonTabPage{
        id: basic_page
        title: qsTr("Basic")
        RibbonTabGroup{
            width: pushbutton_layout.width + 30
            text: qsTr("Push Button")
            RowLayout{
                id: pushbutton_layout
                anchors.centerIn: parent
                height: parent.height
                spacing: 10
                RibbonPushButton{
                    text: qsTr("No Menu")
                    iconSource: RibbonIcons.AttachText
                }
                RibbonPushButton{
                    text: qsTr("Menu")
                    iconSource: RibbonIcons.MeetNow
                    Action{
                        text: "Test Item 1"
                    }
                    RibbonMenuSeparator{}
                    Action{
                        text: "Test Item 2"
                        enabled: false
                    }
                }
                RibbonPushButton{
                    text: qsTr("No Menu")
                    iconSource: `qrc:/qt-project.org/imports/${RibbonTemplateUri}/resources/imgs/heart.png`
                    iconSize: height-5
                }
                RibbonPushButton{
                    text: qsTr("Menu")
                    iconSource: `qrc:/qt-project.org/imports/${RibbonTemplateUri}/resources/imgs/search.png`
                    Action{
                        text: "Test Item 3"
                    }
                    RibbonMenuSeparator{}
                    Action{
                        text: "Test Item 4"
                        enabled: false
                    }
                }
            }
        }
    }

    onSettingsBtnClicked:{
        backstagepopup.open()
    }
}
