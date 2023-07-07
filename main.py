# This Python file uses the following encoding: utf-8
import sys
import os
import datetime

#from pathlib import Path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal, QTimer, QUrl

class MainWindow(QObject):

    setName = Signal(str)
    printTime = Signal(str)
    isVisible = Signal(bool)
    readText = Signal(str)
    textField = ''

    def __init__(self):
        QObject.__init__(self)
        self.timer = QTimer()
        self.timer.timeout.connect(lambda: self.setTime())
        self.timer.start(1000)

    # get tên
    @Slot(str)
    def welcomeText(self, name):
        self.setName.emit('Hey ' + name)

    # lấy text
    @Slot(str)
    def getTextField(self, text):
        self.textField = text

    @Slot(str)
    def writeFile(self, filePath):
        file = open(QUrl(filePath).toLocalFile(), 'w')
        file.write(self.textField)
        file.close()
        print(self.textField)

    # no slot
    def setTime(self):
        now = datetime.datetime.now()
        formatDate = now.strftime('%H:%M:%S %p of %d/%m/%Y')
        # print(formatDate)
        self.printTime.emit(formatDate)

    # test show/hide
    @Slot(bool)
    def showHideRectangle(self, isChecked):
        self.isVisible.emit(isChecked)

    # mở file
    @Slot(str)
    def openFile(self, filePath):
        file = open(QUrl(filePath).toLocalFile(), encoding='utf-8')
        text = file.read()
        file.close()
        print(text)
        self.readText.emit(str(text))



if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()


    # My code
    main = MainWindow()
    engine.rootContext().setContextProperty('backend', main)
    engine.load(os.path.join(os.path.dirname(__file__),'qml/main.qml'))


#    qml_file = Path(__file__).resolve().parent / 'qml/main.qml'
#    engine.load(qml_file)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
