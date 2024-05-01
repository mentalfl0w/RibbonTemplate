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
    comfirmed_quit: true

    // Title bar's right content
    title_bar.right_content:RowLayout{
        spacing: 1
        layoutDirection: Qt.RightToLeft
        RibbonButton{
            show_bg:false
            icon_source: RibbonIcons.Info
            icon_source_filled: RibbonIcons_Filled.Info
            tip_text: qsTr("About")
            hover_color: Qt.rgba(0,0,0, 0.3)
            pressed_color: Qt.rgba(0,0,0, 0.4)
            text_color: title_bar.title_text_color
            text_color_reverse: false
            onClicked: root.show_window(Qt.resolvedUrl("about.qml"))
        }
    }

    // Title bar's left content
    title_bar.left_content:RowLayout{
        spacing: 1
        RibbonButton{
            show_bg:false
            icon_source: RibbonIcons.EmojiSmileSlight
            icon_source_filled: RibbonIcons_Filled.EmojiSmileSlight
            checkable: true
            tip_text: "Test Button 4"
            hover_color: Qt.rgba(0,0,0, 0.3)
            pressed_color: Qt.rgba(0,0,0, 0.4)
            text_color: title_bar.title_text_color
            text_color_reverse: false
            enabled: false
        }
    }

    // TabBar
    TabBar{
        id: tab_bar
    }

    // MainView is behind TabBar
    MainView{
        top_padding: tab_bar.height
        bottom_padding: bottom_bar.height
        page_width: (page_slider.value / 100.0) * width
    }


    // Due to `page_slider`, BottomBar doesn't write as a unique component file
    RibbonBottomBar{
        id: bottom_bar
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        right_content: RowLayout{
            clip: true
            spacing:1
            Layout.preferredHeight: parent.height
            layoutDirection: Qt.RightToLeft
            RibbonSlider{
                id: page_slider
                slide_width: 80
                show_filled_color: false
                value: 70
            }
            RibbonButton{
                text:"Test Button 2"
                show_bg:false
                adapt_height:true
                icon_source: RibbonIcons.EmojiSmileSlight
            }
        }
        RibbonButton{
            show_bg:false
            adapt_height:true
            icon_source: RibbonIcons.EmojiSmileSlight
            checkable: true
            tip_text: "Test Button 3"
        }
    }
}
