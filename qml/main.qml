import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects
import QtQuick.Dialogs

import 'controls'

Window {
    id: mainWindow

    // Set the width and height to half of the screen resolution
    width: 1080//windowWidth
    height: 720 //windowHeight
    minimumWidth: 800
    minimumHeight: 500
    visible: true
//    color: 'transparent'
    title: 'test'

    // Remove title bar
//    flags: Qt.Window | Qt.FramelessWindowHint

    property int screenWidth: Screen.desktopAvailableWidth
    property int screenHeight: Screen.desktopAvailableHeight
    property int initialWidth: screenWidth / 3*2
    property int initialHeight: screenHeight / 3*2
  
    property color textColor: '#EEEEEE'
    property color barColor:  '#222831' //'#1d1d1d'
    property color contentColor:  '#393E46' //'#1d1d1d'
    
    property int windowStatus: 0
    property int windowMargin: 10   
    
    
    // Text Edit Properties
    property alias actualPage: stackView.currentItem

    // Internal functions
    QtObject{
        id: internal

        function resetResizeBorders(){
            // Resize visibility
            resizeLeft.visible = true
            resizeRight.visible = true
            resizeBottom.visible = true
            resizeWindow.visible = true
        }

        function maximizeRestore(){
            if(windowStatus == 0){
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
                // Resize visibility
                resizeLeft.visible = false
                resizeRight.visible = false
                resizeBottom.visible = false
                resizeWindow.visible = false
                btnMaximizeRestore.btnIconSource = '../../images/svg/restore_icon.svg'
            }
            else{
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                // Resize visibility
                internal.resetResizeBorders()
                btnMaximizeRestore.btnIconSource = '../../images/svg/maximize_icon.svg'
            }
        }

        function ifMaximizedWindowRestore(){
            if(windowStatus == 1){
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                // Resize visibility
                internal.resetResizeBorders()
                btnMaximizeRestore.btnIconSource = '../../images/svg/maximize_icon.svg'
            }
        }

        function restoreMargins(){
            windowStatus = 0
            windowMargin = 10
            // Resize visibility
            internal.resetResizeBorders()
            btnMaximizeRestore.btnIconSource = '../../images/svg/maximize_icon.svg'
        }
    }

    Rectangle {
        id: bg
        color: 'transparent'
//        border.color: ''
//        border.width: 1
        anchors.fill: parent
        clip: true
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        z: 1

        Rectangle {
            id: appContainer
            color: 'transparent'
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                height: 60
                color: barColor
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top

                Rectangle {
                    id: topBarDescription
                    color: '#282c34'
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: titleBar.bottom
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 70

                    Label {
                        id: labelTopInfo
                        color: textColor
                        text: 'labelTopInfo'
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 300
                        anchors.leftMargin: 10
                    }
                }

                Rectangle {
                    id: titleBar
                    height: 30
                    color: 'transparent'
                    anchors.left: parent.left
                    anchors.right: rowBtns.left
                    anchors.top: parent.top
                    anchors.topMargin: 0

                    DragHandler {
                        onActiveChanged: if(active){
                                             mainWindow.startSystemMove()
                                             internal.ifMaximizedWindowRestore()
                                         }
                    }

                    Image {
                        id: iconApp
                        width: 20
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: '../images/svg/qt.svg'
                        anchors.leftMargin: 8

                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: label
                        color: '#c3cbdd'
                        text: qsTr('My Application Title')
                        anchors.left: iconApp.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: -288
                        anchors.topMargin: -71
                        anchors.bottomMargin: 143
                        font.pointSize: 10
                        anchors.leftMargin: 293
                    }
                }

                Row {
                    id: rowBtns
                    width: 129
                    anchors.right: parent.right
                    anchors.top: parent.top

                    TopBarButton{
                        id: btnMinimize
                        width: parent.width / 3
                        btnIconSource: '../../images/svg/minimize_icon.svg'
                        colorMouseOver: '#6096B4'
                        onClicked: {
                            mainWindow.showMinimized()
                            internal.restoreMargins()
                        }
                    }

                    TopBarButton {
                        id: btnMaximizeRestore
                        width: parent.width / 3
                        colorMouseOver: '#90A17D'
                        btnIconSource: '../../images/svg/maximize_icon.svg'
                        onClicked: internal.maximizeRestore()
                    }

                    TopBarButton {
                        id: btnClose
                        width: parent.width / 3
                        colorMouseOver: '#c5083e'
                        btnIconSource: '../../images/svg/close_icon.svg'
                        onClicked: mainWindow.close()
                    }
                }


            }

            Rectangle {
                id: content
                color: 'transparent'
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom

                Rectangle {
                    id: leftMenu
                    width: 70
                    color: barColor
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true

                    // expand/collapse
                    PropertyAnimation {
                        id: animationMenu
                        target: leftMenu
                        property: 'width'
                        to:
                            if(leftMenu.width == 70)
                                return 150;
                            else
                                return 70
                        duration: 500
                        easing.type: Easing.InOutQuint
                    }


                    ToggleButton {
                        width: 70
//                        anchors.horizontalCenter: parent.horizontalCenter
                        onHoveredChanged: animationMenu.running = true

                        Column {
                            id: columnMenu
                            anchors.fill: parent
                            anchors.bottomMargin: 90

                            LeftMenuButton {
                                id: btnHome
                                width: leftMenu.width
                                text: 'Home'
                                btnIconSource: '../../images/svg/home_icon.svg'
                                isActiveMenu: true

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
                                btnIconSource: '../../images/svg/open_icon.svg'

                                onPressed: {
                                    fileOpen.open()
                                }

                                FileDialog{
                                    id: fileOpen
                                    title: 'Please choose a file'
                                    // folder: shortcuts.home
                                    // selectMultiple: false
                                    nameFilters: ['Text File (*.txt)']
                                    onAccepted: {
                                        backend.openFile(fileOpen.fileUrl)
                                    }
                                }
                            }

                            LeftMenuButton {
                                id: btnSave
                                width: leftMenu.width
                                text: 'Save'
                                btnIconSource: '../../images/svg/save_icon.svg'

                                onPressed: {
                                    fileSave.open()
                                }

                                FileDialog{
                                    id: fileSave
                                    title: 'Save file'
                                    //                                folder: shortcuts.home
                                    nameFilters: ['Text File (*.txt)']
                                    //                                selectExisting: false
                                    onAccepted: {
                                        backend.getTextField(actualPage.getText)
                                        backend.writeFile(fileSave.fileUrl)
                                    }
                                }
                            }
                        }
                    }



                    LeftMenuButton {
                        id: btnSettings
                        width: leftMenu.width
                        text: 'Settings'
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 25
                        btnIconSource: '../../images/svg/settings_icon.svg'

                        onClicked: {
                            btnHome.isActiveMenu = false
                            btnSettings.isActiveMenu = true
                            stackView.push('pages/settingsPage.qml')
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
                    anchors.bottomMargin: 25
                    clip: true

                    StackView {
                        id: stackView
                        anchors.fill: parent
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        initialItem: 'pages/settingsPage.qml'
                    }
                }

                MouseArea {
                   id: resizeLeftBottom
                   width: 20
                   height: 20
                   anchors.left: parent.left
                   anchors.bottom: parent.bottom
                   anchors.leftMargin: -10
                   anchors.bottomMargin: -10


                   cursorShape: Qt.SizeBDiagCursor

                   DragHandler {
                       target: null
                       onActiveChanged:
                           if (active) {
                               mainWindow.startSystemResize(Qt.LeftEdge | Qt.BottomEdge)
                       }
                   }
                }

                MouseArea {
                    id: resizeRightBottom
                    width: 10
                    height: 10
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: -5
                    anchors.bottomMargin: -5
                    cursorShape: Qt.SizeFDiagCursor

                    DragHandler {
                        target: null
                        onActiveChanged:
                            if (active) {
                                mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                            }
                    }

                    Image {
                        id: resizeWindow
                        width: 16
                        height: 16
                        source: '../images/svg/resize_icon.svg'
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        sourceSize.height: 16
                        sourceSize.width: 16
                        fillMode: Image.PreserveAspectFit
                        antialiasing: false
                    }
                }
            }

        }
    }


    DropShadow{
        anchors.fill: bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: '#80000000'
        source: bg
        z: 0
    }

    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 5
        anchors.bottomMargin: 20
        anchors.topMargin: 30
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.LeftEdge) }
        }
    }

    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 30
        anchors.bottomMargin: 20
        anchors.rightMargin: 5
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.RightEdge) }
        }
    }

    MouseArea {
        id: resizeBottom
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        cursorShape: Qt.SizeVerCursor

        DragHandler{
            target: null
            onActiveChanged: if (active) { mainWindow.startSystemResize(Qt.BottomEdge) }
        }
    }

    Connections{
        target: backend

        function onReadText(text){
            actualPage.setText = text
        }
    }

}
