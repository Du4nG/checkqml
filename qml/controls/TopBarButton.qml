import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Button {
    id: btnTopBar
    property url btnIconSource
    property color colorDefault: '#2a2d31'
    property color colorMouseOver
    property color colorPressed: '#333333'

    QtObject {
        id: internal
        property var dynamicColor:
            if(btnTopBar.down){
                btnTopBar.down ? colorPressed : colorDefault
            }
            else{
                btnTopBar.hovered ? colorMouseOver : colorDefault
            }
    }

    width: 50
    height: 50

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 16
            width: 16
            visible: false
            fillMode: Image.PreserveAspectFit
        }

        ColorOverlay{
            anchors.fill: iconBtn
            source: iconBtn
            color: '#808080'
        }
    }
}
