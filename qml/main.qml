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

    color: 'transparent'
    title: qsTr('QML')

    flags: Qt.Window | Qt.FramelessWindowHint

    property int windowStatus: 0
    property int windowMargin: 10

    QtObject {
        id: internal
        function maximizeRestore(){
            if (windowStatus === 0){
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
//                maximizeBtn.btnIconSource = '../../images/svg_images/restore_icon.svg'
            }
            else{
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
//                maximizeBtn.btnIconSource = '../../images/svg_images/maximize_icon.svg'
            }
        }

        function ifMaximizedWindowRestore(){
            if (windowStatus == 1){
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10

            }
        }

        function restoreMargins(){
            windowStatus = 0
            windowMargin = 10
        }
    }

    Rectangle {
        id: bg
        color: '#002c313c'
        border.color: '#74383e4c'
        border.width: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        z: 1

        Rectangle {
            id: appContainer
            opacity: 1
            visible: true
            color: '#002c313c'
            anchors.fill: parent
            z: 1
            transformOrigin: Item.Center

            Rectangle {
                id: topBar
                height: 100
                visible: true
                color: '#1c1d20'
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
                    btnIconSource: '../../images/svg_images/menu_icon.svg'
                    onHoveredChanged: animationMenu.running = true
                }

                Rectangle {
                    id: titleBar
                    height: 32
                    color: '#2a2d31'
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
                                internal.ifMaximizedWindowRestore()
                            }
                    }

                    Image {
                        id: iconApp
                        width: 22
                        height: 22
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: '../images/svg_images/icon_app_top.svg'
                        anchors.bottomMargin: 10
                        anchors.topMargin: 10
                        anchors.leftMargin: 10
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: label
                        color: '#c3cbdd'
                        text: qsTr('QML')
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 20
                        anchors.leftMargin: 50
                    }

                    Row {
                        id: row
                        width: 105
                        height: 32
                        anchors.left: parent.right

                        TopBarButton {
                            id: minimizeBtn
                            width: 35
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            btnIconSource: '../../images/svg_images/minimize_icon.svg'
                            onClicked: {
                                mainWindow.showMinimized()
                                internal.restoreMargins()
                            }
                        }

                        TopBarButton {
                            id: maximizeBtn
                            width: 35
                            anchors.left: minimizeBtn.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            btnIconSource: '../../images/svg_images/maximize_icon.svg'
                            onClicked: internal.maximizeRestore()
                        }

                        TopBarButton {
                            id: closeBtn
                            width: 35
                            anchors.left: maximizeBtn.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            btnIconSource: '../../images/svg_images/close_icon.svg'
                            onClicked: mainWindow.close()
                        }
                    }
                }

                Rectangle {
                    id: topBarDescription
                    y: 32
                    height: 68
                    color: '#282c34'
                    anchors.left: toggleBtn.right
                    anchors.right: parent.right
                    anchors.bottom: parent.top
                    anchors.top: titleBar.bottom


                    anchors.bottomMargin: -100

                    Label {
                        id: lebelLeft
                        color: '#5f6a82'
                        text: qsTr('Tool Description')
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 20
                        anchors.rightMargin: 300
                        anchors.leftMargin: 0
                    }

                    Label {
                        id: labelRight
                        color: '#5f6a82'
                        text: qsTr('| Home')
                        anchors.left: lebelLeft.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 20
                    }
                }

            }

            Rectangle {
                id: content
                opacity: 1
                visible: true
                color: '#2c313c'
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
                    color: '#2a2d31'
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
                            text: qsTr('Home')
                            btnIconSource: '../../images/svg_images/home_icon.svg'
                        }

                        LeftMenuButton {
                            id: btnOpen
                            width: leftMenu.width
                            text: qsTr('Open')
                            anchors.top: btnHome.bottom
                            btnIconSource: '../../images/svg_images/open_icon.svg'
                        }

                        LeftMenuButton {
                            id: btnSave
                            width: leftMenu.width
                            text: qsTr('Save')
                            anchors.top: btnOpen.bottom
                            btnIconSource: '../../images/svg_images/save_icon.svg'
                        }
                    }

                    LeftMenuButton {
                        id: btnSettings
                        width: leftMenu.width
                        text: qsTr('Settings')
                        anchors.bottom: columnMenu.bottom
                        btnIconSource: '../../images/svg_images/settings_icon.svg'
                        anchors.topMargin: 0
                    }


                }

                Rectangle {
                    id: contentPages
                    color: '#2c313c'
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
                    color: '#282c23'
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPages.bottom
                    anchors.bottom: parent.bottom


                    Label {
                        id: labelBot
                        x: -60
                        y: -575
                        color: '#5f6a82'
                        text: qsTr('Footer')
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 13
                    }
                }
            }

        }

        DropShadow {
            anchors.fill: parent
            horizontalOffset: 5
            verticalOffset: 5
            radius: 5
            samples: 16
            color: 'black'
            source: parent
            z: 0
        }
    }
}

