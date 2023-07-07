import QtQuick
import QtQuick.Controls

Item {
    clip: true
    Rectangle {
        id: rectangle
        color: '#222222'
        anchors.fill: parent

        anchors.topMargin: 50
        anchors.bottomMargin: 50
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        radius: 8

        TextField {
            id: textField
            x: 121
            y: 145
            width: 337
            height: 41
            placeholderText: qsTr("Text Field")
        }

        Switch {
            id: switch1
            x: 519
            width: 53
            height: 28
            text: qsTr('Switch')
            anchors.verticalCenter: parent.verticalCenter
        }

        Button {
            id: btnChangeName
            x: 490
            y: 101
            width: 112
            height: 31
            text: qsTr('Change Name')
            onClicked: {
                backend.welcomeText(textField.text)
            }
        }

        Label {
            id: labelTextName
            x: 121
            y: 116
            width: 310
            height: 40
            text: qsTr("Hey...")
            color: 'red'
        }


        Connections {
            target: backend

            function onSetName(name){
                labelTextName.text = name
            }
        }


    }
}


