import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15


Button {
    id: btnToggle

    width: 50
    height: 50
    padding: 0
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    property url btnIconSource
    property color colorDefault: "#af55aaff"
    property color colorMouseOver: '#cccccc'
    property color colorPressed: '#333333'

//    QtObject {
//        id: internal
//        property var dynamicColor:
//            if (btnToggle.down){
//                btnToggle.down ? colorPressed : colorDefault
//            }
//            else{
//                btnToggle.hovered ? colorMouseOver : colorDefault
//            }
//    }

    background: Rectangle {
        id: bgBtn
        color: 'transparent'

        Image {
            id: iconBtn
            source: '../../images/svg_images/menu_icon.svg'
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
        }
    }
}
