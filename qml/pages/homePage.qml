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
            Keys.onEnterPressed: {
                backend.showHideRectangle(switchHome.checked)
            }
            placeholderText: qsTr("Text Field")
        }

        Switch {
            id: switchHome
            x: 519
            checked: true
            width: 53
            height: 28
            text: qsTr('Switch')
            anchors.verticalCenter: parent.verticalCenter
            onToggled: {
                backend.showHideRectangle(switchHome.checked)
            }
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

        Label {
            id: labelDate
            x: 121
            y: 211
            width: 310
            height: 40
            text: qsTr('Date:')
            color: 'red'
        }

        Connections {
            target: backend

            // đặt theo tên Signal, setName => onSetName
            function onSetName(name){
                labelTextName.text = name
            }

            function onPrintTime(time){
                labelDate.text = time
            }

            function onIsVisible(isVisible){
                rectangle.visible = isVisible
            }
        }
    }
}


