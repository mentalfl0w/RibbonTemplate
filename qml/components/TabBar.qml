import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI

// Custom your TabBar here
RibbonTabBar {
    id: control
    right_tool_bar: RowLayout{
        spacing: 10
        RibbonButton{
            text:"Test Button 1"
            icon_source: RibbonIcons.EmojiSmileSlight
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
                    icon_source: RibbonIcons.AttachText
                }
                RibbonPushButton{
                    text: qsTr("Menu")
                    icon_source: RibbonIcons.MeetNow
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
                    icon_source: `qrc:/qt/qml/${RibbonTemplateUri}/resources/imgs/heart.png`
                    icon_size: height-5
                }
                RibbonPushButton{
                    text: qsTr("Menu")
                    icon_source: `qrc:/qt/qml/${RibbonTemplateUri}/resources/imgs/search.png`
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
    RibbonTabPage{
        title: qsTr("Others")
        RibbonTabGroup{
            width: theme_layout.width + 30
            text: qsTr("Theme")
            RowLayout{
                id: theme_layout
                anchors.centerIn: parent
                height: parent.height
                spacing: 10
                RibbonComboBox{
                    id: theme_combo
                    model: ListModel {
                        id: model_theme
                        ListElement { text: "Light" }
                        ListElement { text: "Dark" }
                        ListElement { text: "System" }
                    }
                    icon_source: RibbonIcons.DarkTheme
                    Component.onCompleted: update_state()
                    onActivated: {
                        if (currentText === "System")
                            RibbonTheme.theme_mode = RibbonThemeType.System
                        else if (currentText === "Light")
                            RibbonTheme.theme_mode = RibbonThemeType.Light
                        else
                            RibbonTheme.theme_mode = RibbonThemeType.Dark
                    }
                    Connections{
                        target: RibbonTheme
                        function onTheme_modeChanged(){
                            theme_combo.update_state()
                        }
                    }
                    function update_state(){
                        let str = (RibbonTheme.theme_mode === RibbonThemeType.System ? "System" : RibbonTheme.theme_mode === RibbonThemeType.Light ? "Light" : "Dark")
                        currentIndex = find(str)
                    }
                }
            }
        }
    }
}
