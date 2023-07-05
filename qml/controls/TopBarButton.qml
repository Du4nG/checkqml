import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Button {
    id: btnTopBar
    property url btnIconSource
    property color colorDefault: '#00a1f1'
    property color colorMouseOver: '#cccccc'
    property color colorPressed: '#333333'
    width: 50
    height: 50

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

    background: Rectangle{
        id: rectangle
        color: 'transparent'
        radius: 10

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
            visible: false
        }

//        ColorOverlay {
//            anchors.fill: iconBtn
//            source: iconBtn
//            color: 'white'
//            antialiasing: true
//        }
    }
}

