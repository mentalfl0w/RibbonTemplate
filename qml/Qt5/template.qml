import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import RibbonUI 1.0
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

    // MessageBarGroup
    RibbonMessageBarGroup{
            id: msg_bar
            implicitWidth: windowItems.width
            x: windowItems.x
            y: titleBar.height + tab_bar.y + tab_bar.height - tab_bar.modernMargin + msg_bar.topMargin
            target: windowItems
            targetRect: Qt.rect(tab_bar.x,y,width,height)
            Component.onCompleted: {
                messageModel.append([{
                        type: RibbonMessageBar.Info,
                        text: "Info (default) MessageBar."
                    },{
                        type: RibbonMessageBar.Warning,
                        text: "Warning defaults to multiline. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi luctus, purus a lobortis tristique, odio augue pharetra metus, ac placerat nunc mi nec dui. Vestibulum aliquam et nunc semper scelerisque. Curabitur vitae orci nec quam condimentum porttitor et sed lacus. Vivamus ac efficitur leo. Cras faucibus mauris libero, ac placerat erat euismod et. Donec pulvinar commodo odio sit amet faucibus. In hac habitasse platea dictumst. Duis eu ante commodo, condimentum nibh pellentesque, laoreet enim. Fusce massa lorem, ultrices eu mi a, fermentum suscipit magna. Integer porta purus pulvinar, hendrerit felis eget, condimentum mauris.Visit our website.",
                        actionALabel: "Yes",
                        actionBLabel: "No",
                        externalURL: "https://github.com/mentalfl0w/RibbonUI",
                        externalURLLabel: "Visit our website."
                    },{
                        type: RibbonMessageBar.Warning,
                        text: "Warning MessageBar content.",
                        actionALabel: "Action",
                        externalURL: "https://github.com/mentalfl0w/RibbonUI",
                        externalURLLabel: "Visit our website.",
                        disableMultiline: true
                    },{
                        type: RibbonMessageBar.SevereWarning,
                        text: "SevereWarning MessageBar with action buttons which defaults to multiline.",
                        actionALabel: "Yes",
                        actionBLabel: "No",
                        externalURL: "https://github.com/mentalfl0w/RibbonUI",
                        externalURLLabel: "Visit our website.",
                    },{
                        type: RibbonMessageBar.Blocked,
                        text: "Blocked MessageBar - single line, with dismiss button and truncated text. Truncation is not available if you use action buttons or multiline and should be used sparingly. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi luctus, purus a lobortis tristique, odio augue pharetra metus, ac placerat nunc mi nec dui. Vestibulum aliquam et nunc semper scelerisque. Curabitur vitae orci nec quam condimentum porttitor et sed lacus. Vivamus ac efficitur leo. Cras faucibus mauris libero, ac placerat erat euismod et. Donec pulvinar commodo odio sit amet faucibus. In hac habitasse platea dictumst. Duis eu ante commodo, condimentum nibh pellentesque, laoreet enim. Fusce massa lorem, ultrices eu mi a, fermentum suscipit magna. Integer porta purus pulvinar, hendrerit felis eget, condimentum mauris.",
                    },{
                        type: RibbonMessageBar.Success,
                        text: "Success MessageBar with single line and action buttons.",
                        actionALabel: "Yes",
                        actionBLabel: "No",
                        externalURL: "https://github.com/mentalfl0w/RibbonUI",
                        externalURLLabel: "Visit our website."
                    },{
                        type: RibbonMessageBar.Error,
                        text: "Error MessageBar with single line, with dismiss button.",
                        externalURL: "https://github.com/mentalfl0w/RibbonUI",
                        externalURLLabel: "Visit our website."
                    }])
            }
        }

    // MainView is behind TabBar
    MainView{
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
        RibbonBackStageMenuItem{
            menuText: "Home"
            menuIcon: RibbonIcons.Home
            type: RibbonBackStageView.MenuItemLocation.Head
            sourceComponent: t_content
            sourceArgs:{'pageName':"Home"}
        }
        RibbonBackStageMenuItem{
            menuText: "File"
            menuIcon: RibbonIcons.Document
            type: RibbonBackStageView.MenuItemLocation.Head
            sourceComponent: t_content
            sourceArgs:{'pageName':"File"}
        }
        RibbonBackStageMenuItem{
            menuText: "Search"
            menuIcon: RibbonIcons.Search
            type: RibbonBackStageView.MenuItemLocation.Body
            sourceComponent: t_content
            sourceArgs:{'pageName':"Search"}
        }
        RibbonBackStageMenuItem{
            menuText: "Account"
            menuIcon: RibbonIcons.PersonAccounts
            type: RibbonBackStageView.MenuItemLocation.Tail
            clickOnly: true
            clickFunc: ()=>console.log("Menu Account clicked")
        }
        RibbonBackStageMenuItem{
            menuText: "About"
            menuIcon: RibbonIcons.Info
            type: RibbonBackStageView.MenuItemLocation.Tail
            clickOnly: true
            clickFunc: ()=>root.showWindow(Qt.resolvedUrl("about.qml"))
        }
        RibbonBackStageMenuItem{
            menuText: "Settings"
            menuIcon: RibbonIcons.Settings
            type: RibbonBackStageView.MenuItemLocation.Tail
            sourceUrl: Qt.resolvedUrl("pages/SettingsMenuPage.qml")
        }
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
