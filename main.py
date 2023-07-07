# This Python file uses the following encoding: utf-8
import sys
import os
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

    setName = Signal(str)

    @Slot(str)
    def welcomeText(self, name):
        self.setName.emit('Hey ' + name)


if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()


    # My code
    main = MainWindow()
    engine.rootContext().setContextProperty('backend', main)
    engine.load(os.path.join(os.path.dirname(__file__),'qml/main.qml'))


    qml_file = Path(__file__).resolve().parent / 'qml/main.qml'
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
