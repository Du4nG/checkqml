import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

Button {
    id: btnTopBar
    flat: true
    property url btnIconSource
    property color colorDefault: 'transparent'
    property color colorMouseOver
    property color colorPressed: '#66808080'

    property color colorOverlayDefault: '#606060'
    property color colorOverlay: 'white'

    QtObject {
        id: internal
        property var dynamicColor:
            if(btnTopBar.down){
                btnTopBar.down ? colorPressed : colorDefault
            }
            else{
                btnTopBar.hovered ? colorMouseOver : colorDefault
            }

        property var dynamicColorOverlay:
            btnTopBar.hovered ? colorOverlay : colorOverlayDefault
    }

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor
        anchors {
            top: parent.top
            bottom: parent.bottom
        }

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
            color: internal.dynamicColorOverlay
        }
    }
}
