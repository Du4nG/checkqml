import QtQuick 2.15
import QtQuick.Controls 6.3

Item {
    Rectangle {
        id: rectangle
        color: 'black'
        anchors.fill: parent

        Label {
            id: label
            text: qsTr("Settings Page")
            color: 'white'
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }
}


