import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import Themes 0.1

Button {
    id: root

    width: 120
    height: 40

    property color textColor        : ColorThemes.white
    property int textAlignment      : Qt.AlignCenter
    property var buttonDynamicColor : (root.down || root.hovered)? ColorThemes.main_color_hover
                                                                 : ColorThemes.main_color

    contentItem: Text {
        text: root.text
        color: textColor
        horizontalAlignment: textAlignment
        verticalAlignment: Qt.AlignVCenter
        elide: Qt.ElideRight
    }

    background: Rectangle {
        id: rootBG
        implicitHeight: root.height
        implicitWidth: root.width
        color: "#FFFFFF"
        radius: 5

        layer.enabled: root.hovered | root.down
        layer.effect: DropShadow {
            transparentBorder: true
            color: buttonDynamicColor
            samples: 10
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: false
        cursorShape: Qt.PointingHandCursor
    }
}
