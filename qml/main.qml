import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import 'controls'

Window {
    id: mainWindow
    width: 1080
    height: 720
    visible: true

    color: "#00ffffff"
    title: qsTr("NOTE Complement")

    flags: Qt.Window | Qt.FramelessWindowHint

    Rectangle {
        id: appContainer
        opacity: 1
        visible: true
        color: "#2c313c"
        anchors.fill: parent

        transformOrigin: Item.Center

        Rectangle {
            id: topBar
            height: 100
            visible: true
            color: "#1c1d20"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            ToggleButton {
                id: toggleBtn
                width: 70
                height: 100
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 0
                anchors.topMargin: 0

                onHoveredChanged: animationMenu.running = true
            }

            Rectangle {
                id: titleBar
                height: 50
                color: "#2a2d31"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 105
                anchors.leftMargin: 70
                anchors.topMargin: 0

                DragHandler {
                    onActiveChanged:
                        if (active){
                            mainWindow.startSystemMove()
                        }
                }

                Image {
                    id: iconApp
                    width: 22
                    height: 22
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    source: "../images/svg_images/icon_app_top.svg"
                    anchors.bottomMargin: 10
                    anchors.topMargin: 10
                    anchors.leftMargin: 10
                    fillMode: Image.PreserveAspectFit
                }

                Label {
                    id: label
                    color: "#c3cbdd"
                    text: qsTr("NOTE Complement")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 20
                    anchors.leftMargin: 50
                }

                Row {
                    id: row
                    y: 0
                    width: 105

                    height: 50
                    anchors.left: parent.right
                    anchors.leftMargin: 0

                    TopBarButton {
                        id: minimizeBtn
                        width: 35
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        icon.source: "../images/svg_images/minimize_icon.svg"
                        anchors.topMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                    }

                    TopBarButton {
                        id: maximizeBtn
                        width: 35
                        anchors.left: minimizeBtn.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        display: AbstractButton.TextBesideIcon
                        icon.source: "../images/svg_images/maximize_icon.svg"
                        anchors.topMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                    }
                    TopBarButton {
                        id: closeBtn
                        width: 35
                        anchors.left: maximizeBtn.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        icon.source: "../images/svg_images/close_icon.svg"
                        anchors.topMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                    }
                }
            }

            Rectangle {
                id: topBarDescription
                y: 46
                height: 50
                color: "#282c34"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 70
                anchors.bottomMargin: 0

                Label {
                    id: labelTopInfo
                    color: "#5f6a82"
                    text: qsTr("Tool description")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 20
                    anchors.rightMargin: 300
                    anchors.leftMargin: 10
                }

                Label {
                    id: labelTopInfo1
                    color: "#5f6a82"
                    text: qsTr("| Home")
                    anchors.left: labelTopInfo.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignRight
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 680
                    anchors.rightMargin: 0
                    font.pointSize: 20
                }
            }

        }

        Rectangle {
            id: content
            opacity: 1
            visible: true
            color: "#2c313c"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: topBar.bottom
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0

            Rectangle {
                id: leftMenu
                width: 70

                opacity: 1
                visible: true
                color: "#2a2d31"
                layer.enabled: true

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0

                PropertyAnimation {
                    id: animationMenu
                    target: leftMenu
                    property: 'width'
                    to:
                        if (leftMenu.width == 70)
                            return 200;
                        else return 70;
                    duration: 500
                    easing.type: Easing.InOutQuint
                }

                MouseArea {
                    anchors.fill: parent
                    onExited: {
                        // Start the animation to collapse the menu when the mouse leaves
                        animationMenu.start();
                    }
                }

                Column {
                    id: columnMenu
                    anchors.fill: parent
                    anchors.bottomMargin: 24
                    clip: true

                    LeftMenuButton {
                        id: btnHome
                        width: leftMenu.width
                        text: qsTr("Button")
                        icon.source: "../images/svg_images/home_icon.svg"
                    }

                    LeftMenuButton {
                        id: btnOpen
                        width: leftMenu.width
                        text: qsTr("Open")
                        anchors.top: btnHome.bottom
                        icon.source: "../images/svg_images/open_icon.svg"
                    }

                    LeftMenuButton {
                        id: btnSave
                        width: leftMenu.width
                        text: qsTr("Save")
                        anchors.top: btnOpen.bottom
                        icon.source: "../images/svg_images/save_icon.svg"
                        anchors.topMargin: 0
                    }
                }

                LeftMenuButton {
                    id: btnSettings
                    width: leftMenu.width
                    text: qsTr("Settings")
                    anchors.bottom: columnMenu.bottom
                    icon.source: "../images/svg_images/settings_icon.svg"
                    anchors.topMargin: 0
                }


            }

            Rectangle {
                id: contentPages
                color: "#2c313c"
                anchors.left: leftMenu.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 25
                anchors.topMargin: 0
            }

            Rectangle {
                id: rectangle
                x: 203
                y: 324
                color: "#282c23"
                anchors.left: leftMenu.right
                anchors.right: parent.right
                anchors.top: contentPages.bottom
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.topMargin: 0

                Label {
                    id: labelTopInfo2
                    x: -60
                    y: -575
                    color: "#5f6a82"
                    text: qsTr("Tool description")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 20
                    anchors.rightMargin: 300
                    anchors.leftMargin: 10
                }
            }
        }

    }

    DropShadow {
        anchors.fill: bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#ffffff"
        source: bg
        z: 0
    }
}

