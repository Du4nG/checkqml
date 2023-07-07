import QtQuick
import QtQuick.Controls

Item {
    Rectangle {
        id: rectangle
        color: '#55aaff'
        anchors.fill: parent

        Label {
            id: label
            text: qsTr('Home Page')
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}


