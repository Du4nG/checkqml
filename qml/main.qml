import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects

import 'controls'

Window {
    id: mainWindow
    width: 1080
    height: 720
    minimumWidth: 540
    minimumHeight: 360

    visible: true
    color: 'transparent'

    title: qsTr('QML')

    flags: Qt.Window | Qt.FramelessWindowHint

    property color textColor: '#5f6a82'
    property color barColor: '#1d1d1d'
    property int windowStatus: 0
    property int windowMargin: 10

    property alias actualPage: stackView.currentItem

    QtObject {
        id: internal

        function resetResizeBorders(){
            resizeLeft.visible = true
            resizeRight.visible = true
            resizeBottom.visible = true
            resizable.visible = true
        }

        function maximizeRestore(){

            // window is maximized
            if (windowStatus == 0){
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
                resizeLeft.visible = false
                resizeRight.visible = false
                resizeBottom.visible = false
                resizable.visible = false
                maximizeBtn.btnIconSource = '../../images/svg_images/restore_icon.svg'
            }
            else{
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                internal.resetResizeBorders()
                maximizeBtn.btnIconSource = '../../images/svg_images/maximize_icon.svg'
            }
        }

        function ifMaximizedWindowRestore(){
            if (windowStatus == 1){
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                internal.resetResizeBorders()
            }
        }

        function restoreMargins(){
            windowStatus = 0
            windowMargin = 10
            internal.resetResizeBorders()
            maximizeBtn.btnIconSource = '../../images/svg_images/maximize_icon.svg'
        }
    }

    Rectangle {
        id: bg
        color: '#002c313c'
        border.color: '#74383e4c'
        border.width: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10

        Rectangle {
            id: appContainer
            opacity: 1
            visible: true
            color: 'transparent'
            anchors.fill: parent
            z: 1

            Rectangle {
                id: topBar
                height: 100
                visible: true
                color: barColor
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
                    height: 32
                    color: barColor
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 129
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
                        width: 129
                        height: 32
                        anchors.left: parent.right

                        TopBarButton {
                            id: minimizeBtn
                            width: 43
                            colorMouseOver: '#333333'
                            btnIconSource: '../../images/svg_images/minimize_icon.svg'

                            onClicked: {
                                mainWindow.showMinimized()
                                internal.restoreMargins()
                            }
                        }

                        TopBarButton {
                            id: maximizeBtn
                            width: 43
                            colorMouseOver: '#333333'
                            btnIconSource: '../../images/svg_images/maximize_icon.svg'

                            onClicked: internal.maximizeRestore()
                        }

                        TopBarButton {
                            id: closeBtn
                            width: 43
                            colorMouseOver: '#c5083e'
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
                        color: textColor
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
                        color: textColor
                        text: qsTr('| Home ')
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
                    color: barColor
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
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 25
                        clip: true

                        LeftMenuButton {
                            id: btnHome
                            width: leftMenu.width
                            text: 'Home'
                            btnIconSource: '../../images/svg_images/home_icon.svg'
                            isActiveMenu: true // default
                            onClicked: {
                                btnHome.isActiveMenu = true
                                btnSettings.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl('pages/homePage.qml'))
                            }
                        }

                        LeftMenuButton {
                            id: btnOpen
                            width: leftMenu.width
                            text: 'Open'
                            btnIconSource: '../../images/svg_images/open_icon.svg'

                            onPressed: {
                                fileOpen.open()
                            }

                            FileDialog {
                                id: fileOpen
                                title: 'Choose file'
//                                folder: shortcuts.home
//                                selectMultiple: false
                                nameFilters: ['(*.txt)']
                                onAccepted: {
                                    backend.openFile(fileOpen.fileUrl)
                                }
                            }
                        }

                        LeftMenuButton {
                            id: btnSave
                            width: leftMenu.width
                            text: qsTr('Save')
                            btnIconSource: '../../images/svg_images/save_icon.svg'

                            onPressed: {
                                fileSave.open()
                            }

                            FileDialog {
                                id: fileSave
                                title: 'Save'
//                                folder: shortcuts.home
//                                selectExisting: false
                                onAccepted: {
                                    backend.getTextField(actualPage.getText)
                                    backend.writeFile(fileSave.fileUrl)
                                }
                            }
                        }
                    }

                    LeftMenuButton {
                        id: btnSettings
                        width: leftMenu.width
                        text: qsTr('Settings')
                        anchors.bottom: columnMenu.bottom
                        btnIconSource: '../../images/svg_images/settings_icon.svg'
                        onClicked: {
                            btnHome.isActiveMenu = false
                            btnSettings.isActiveMenu = true
                            stackView.push(Qt.resolvedUrl('pages/settingsPage.qml'))
                        }
                    }
                }

                Rectangle {
                    id: contentPages
                    color: 'transparent'
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 25
                    anchors.topMargin: 0

                    StackView {
                        id: stackView
                        anchors.fill: parent
                        initialItem: 'pages/homePage.qml'
                    }
                }

                Rectangle {
                    id: rectangle
                    color: '#282c34'
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPages.bottom
                    anchors.bottom: parent.bottom


                    // icon resizable cần nằm ở trên nên để trong đây
                    MouseArea {
                        id: resizeRightBottom
                        x: 965
                        y: 0
                        width: 25
                        height: 25

                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        cursorShape: Qt.SizeFDiagCursor

                        DragHandler {
                            target: null
                            onActiveChanged:
                                if (active) {
                                    mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                                }
                        }

                        Image {
                            id: resizable
                            anchors.fill: parent
                            x: 985
                            y: 0
                            width: 25
                            height: 25
                            opacity: 0.3
                            source: '../images/svg_images/resize_icon.svg'
                            anchors.leftMargin: 0
                            anchors.topMargin: 0
                            anchors.rightMargin: -6
                            anchors.bottomMargin: -6
                            fillMode: Image.PreserveAspectFit
                        }
                    }

                    MouseArea {
                        id: resizeLeftBottom
                        width: 35
                        height: 35
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: -10
                        anchors.leftMargin: -80

                        cursorShape: Qt.SizeBDiagCursor

                        DragHandler {
                            target: null
                            onActiveChanged:
                                if (active) {
                                    mainWindow.startSystemResize(Qt.LeftEdge | Qt.BottomEdge)
                            }
                        }
                    }
                }
            }
        }

        MouseArea {
            id: resizeTop
            height: 20
            anchors.top: parent.top
            anchors.topMargin: -10
            anchors.left: parent.left
            anchors.right: parent.right
            cursorShape: Qt.SizeVerCursor

            DragHandler {
                target: null
                onActiveChanged:
                    if (active) {
                        mainWindow.startSystemResize(Qt.TopEdge)
                    }
            }
        }

        MouseArea {
            id: resizeLeft
            width: 20
            anchors.left: parent.left
            anchors.leftMargin: -10
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            cursorShape: Qt.SizeHorCursor

            DragHandler {
                target: null
                onActiveChanged:
                    if (active) {
                        mainWindow.startSystemResize(Qt.LeftEdge)
                    }
            }
        }

        MouseArea {
            id: resizeBottom
            height: 20
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -10
            cursorShape: Qt.SizeVerCursor

            DragHandler {
                target: null
                onActiveChanged:
                    if (active) {
                        mainWindow.startSystemResize(Qt.BottomEdge)
                    }
            }
        }

        MouseArea {
            id: resizeRight
            width: 20
            anchors.right: parent.right
            anchors.rightMargin: -10
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            cursorShape: Qt.SizeHorCursor

            DragHandler {
                target: null
                onActiveChanged:
                    if (active) {
                        mainWindow.startSystemResize(Qt.RightEdge)
                    }
            }
        }

        DropShadow {
            anchors.fill: parent
            horizontalOffset: 1
            verticalOffset: 3
            radius: 8
            samples: (1 + radius)*2
            color: '#80000000'
            source: parent
            z: 0
        }
    }

    Connections {
        target: backend

        function onReadText(text){
            actualPage.setText = text
        }
    }
}

