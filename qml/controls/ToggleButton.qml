import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: btnToggle

    property color colorDefault: '#55aaff'
    property color colorMouseOver: '#cccccc'
    property color colorPressed: '#333333'
    width: 50
    height: 50

    QtObject {
        id: internal
        property var dynamicColor:
            if(btnToggle.down){
                btnToggle.down ? colorPressed : colorDefault
            }
            else{
                btnToggle.hovered ? colorMouseOver : colorDefault
            }
    }

    background: Rectangle{
        id: rectangle
        color: internal.dynamicColor
        radius: 10

        Image {
            id: iconBtn
            source: '../../images/svg_images/menu_icon.svg'
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
        }

//        ColorOverlay {
//            anchors.fill: iconBtn
//            source: iconBtn
//            color: 'white'
//            antialiasing: False
//        }
    }
}
