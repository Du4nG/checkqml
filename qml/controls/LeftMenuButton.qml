import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects

Button {
    id: btnLeftMenu
    text: qsTr('Left Menu text')

    property url btnIconSource

    property color colorDefault: "#5f6a82"
    property color colorMouseOver: '#cccccc'
    property color colorPressed: '#333333'
    property color activeMenuColorLeft: '#55aaff'
    property color activeMenuColorRight: '#2c313c'

    property int iconWidth: 18
    property int iconHeight: 18
    property bool isActive: true

    QtObject {
        id: internal
        property var dynamicColor:
            if(btnLeftMenu.down){
                btnLeftMenu.down ? colorPressed : colorDefault
            }
            else{
                btnLeftMenu.hovered ? colorMouseOver : colorDefault
            }
    }

    implicitWidth: 250
    implicitHeight: 40

    background:
        Rectangle {
            id: bgBtn
            color: internal.dynamicColor

            Rectangle {
                anchors{
                    top: parent.top
                    left: parent.left
                    bottom: parent.bottom
                }

                color: btnLeftMenu.activeMenuColorLeft
                width: 3
                visible: btnLeftMenu.isActive
            }
            Rectangle {
                anchors{
                    top: parent.top
                    right: parent.right
                    bottom: parent.bottom
                }

                color: btnLeftMenu.activeMenuColorRight
                width: 5
                visible: btnLeftMenu.isActive
            }
        }


    contentItem: Item {
        anchors.fill: parent
        id: content
        Image {
            id: iconBtn
            source: btnIconSource
            anchors.leftMargin: 26
            anchors.left: parent.left
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            height: iconHeight
            anchors.verticalCenter: parent.verticalCenter
            width: iconWidth
            fillMode: Image.PreserveAspectFit
            antialiasing: true
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: 'white'
            antialiasing: true
        }

        Text {
            color: 'white'
            text: btnLeftMenu.text
            font: btnLeftMenu.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 75
        }
    }
}
