import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import RibbonUI
import "components"

RibbonWindow {
    id:root
    width: 1200
    height: 800
    title: qsTr(RibbonTemplateUri)
    comfirmedQuit: true

    // Title bar's right content
    titleBar.rightContent:RowLayout{
        spacing: 1
        layoutDirection: Qt.RightToLeft
        RibbonButton{
            showBg:false
            iconSource: RibbonIcons.Info
            iconSourceFilled: RibbonIcons_Filled.Info
            tipText: qsTr("About")
            hoverColor: Qt.rgba(0,0,0, 0.3)
            pressedColor: Qt.rgba(0,0,0, 0.4)
            textColor: titleBar.titleTextColor
            textColorReverse: false
            onClicked: root.showWindow(Qt.resolvedUrl("about.qml"))
        }
    }

    // Title bar's left content
    titleBar.leftContent:RowLayout{
        spacing: 1
        RibbonButton{
            showBg:false
            iconSource: RibbonIcons.EmojiSmileSlight
            iconSourceFilled: RibbonIcons_Filled.EmojiSmileSlight
            checkable: true
            tipText: "Test Button 4"
            hoverColor: Qt.rgba(0,0,0, 0.3)
            pressedColor: Qt.rgba(0,0,0, 0.4)
            textColor: titleBar.titleTextColor
            textColorReverse: false
            enabled: false
        }
    }

    // TabBar
    TabBar{
        id: tab_bar
    }

    // MainView is behind TabBar
    MainView{
        topPadding: tab_bar.height
        bottomPadding: bottom_bar.height
        pageWidth: (page_slider.value / 100.0) * width
    }


    // Due to `page_slider`, BottomBar doesn't write as a unique component file
    RibbonBottomBar{
        id: bottom_bar
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        rightContent: RowLayout{
            clip: true
            spacing:1
            Layout.preferredHeight: parent.height
            layoutDirection: Qt.RightToLeft
            RibbonSlider{
                id: page_slider
                slideWidth: 80
                showFilledColor: false
                value: 70
            }
            RibbonButton{
                text:"Test Button 2"
                showBg:false
                adaptHeight:true
                iconSource: RibbonIcons.EmojiSmileSlight
            }
        }
        RibbonButton{
            showBg:false
            adaptHeight:true
            iconSource: RibbonIcons.EmojiSmileSlight
            checkable: true
            tipText: "Test Button 3"
        }
    }

    RibbonTour{
        id: tour
        targetList: [
            {
                title: qsTr("Tab Bar"),
                text: qsTr("A tab bar for window, let user choose the controllers."),
                target: tab_bar,
                enter_func: ()=>{
                    tab_bar.folded = false
                    tour.refresh(300) // Use it if has animation
                }
            },
            {
                title: qsTr("Bottom Bar"),
                text: qsTr("A bottom bar for window."),
                target: bottom_bar
            }
        ]
        target: windowItems
        blurEnabled: true
        targetRect: Qt.rect(windowItems.x + x, windowItems.y + y, width, height)
    }

    RibbonBackStageView{
        id: backstagepopup
        implicitHeight: root.height - root.borderWidth * 2
        implicitWidth: root.width - root.borderWidth * 2
        blurEnabled: true
        blurTarget: root.windowItems
        radius: borderRadius
        pageModel: [{"menu_text":"Home", "menu_icon":RibbonIcons.Home, "type":RibbonBackStageView.MenuItemLocation.Head, "sourceComponent":t_content, "sourceArgs":{'pageName':"Home"}},
            {"menu_text":"File", "menu_icon":RibbonIcons.Document, "type":RibbonBackStageView.MenuItemLocation.Head, "sourceComponent":t_content, "sourceArgs":{'pageName':"File"}},
            {"menu_text":"Search", "menu_icon":RibbonIcons.Search, "type":RibbonBackStageView.MenuItemLocation.Body, "sourceComponent":t_content, "sourceArgs":{'pageName':"Search"}},
            {"menu_text":"Account", "menu_icon":RibbonIcons.PersonAccounts, "type":RibbonBackStageView.MenuItemLocation.Tail, "clickOnly":true, "clickFunc": ()=>console.log("Menu Account clicked")},
            {"menu_text":"About", "menu_icon":RibbonIcons.Info, "type":RibbonBackStageView.MenuItemLocation.Tail, "clickOnly":true, "clickFunc": ()=>root.showWindow(Qt.resolvedUrl("about.qml"))},
            {"menu_text":"Settings", "menu_icon":RibbonIcons.Settings, "type":RibbonBackStageView.MenuItemLocation.Tail, "sourceUrl":Qt.resolvedUrl("pages/SettingsMenuPage.qml")}]
        Component{
            id: t_content
            RibbonBackStagePage{
                onPageNameChanged: t_text.text = pageName
                Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                    RibbonText{
                        id: t_text
                        anchors.centerIn: parent
                        font.pixelSize: 20
                    }
                }
            }
        }
    }

    Component.onCompleted: tour.open()
}
