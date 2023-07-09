import QtQuick
import QtQuick.Controls

Item {
    property color lightTextColor: '#EEEEEE'
    property color lightBarColor:  '#222831' //'#1d1d1d'
    property color lightContentColor:  '#393E46' //'#1d1d1d'

    Rectangle {
        id: rectangle
        anchors.fill: parent
        color: '#B5C99A'

        Switch {
            id: switchTheme
            checked: true
            width: 53
            height: 28
            text: qsTr('Dark Mode')
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            onToggled: {
//                backend.showHideRectangle(switchTheme.checked)
                if (checked)
                    rectangle.color = '#B5C99A'
                else
                    rectangle.color = '#4C4B16'

            }
        }

//        Connections {
//            target: backend

//            function onIsVisible(isVisible){
//                textField.visible = isVisible
//            }
//        }
    }
}


