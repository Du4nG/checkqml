import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

Button {
    id: btnToggle

    width: 50
    height: 50
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    property url btnIconSource

    background: Rectangle {
        id: bgBtn
        color: 'transparent'

        Image {
            id: iconBtn
            source: '../../images/svg/menu_icon.svg'
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
        }

        ColorOverlay{
            anchors.fill: iconBtn
            source: iconBtn
            color: '#9BA4B5'
        }
    }
}
