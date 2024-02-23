import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt.labs.qmlmodels

import Controls 0.1

Window {
    width: 800
    height: 600
    visible: true
    title: qsTr("Excel Parser")



    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 10


        Text {
            text: qsTr("1. Выберите нужный Excel файл")
            font.family: "Segoe UI"
            color: "#7a7a7a"
            font.bold: true
            font.pixelSize: 20
        }



        CustomPathHolder {
            id: excelFilePathHolder
            isFolderDialog: false
            Layout.fillWidth: true
            Layout.preferredHeight: 43
            Layout.topMargin: 6
            Layout.bottomMargin: 6
            Layout.rightMargin: 10



            onBrowseClicked: fileDialog.open();
        }

        FileDialog {
            id: fileDialog
            nameFilters: ["Файлы Excel (*.xlsx)"]
            fileMode: FileDialog.OpenFile
            currentFolder: StandardPaths.standardLocations(StandardPaths.DownloadLocation)[0]
            onAccepted: {
                const filename = selectedFile.toString().slice(8);
                excelFilePathHolder.text = filename;
                sheetModel.updateFromFile(filename);
            }
        }


        Text {
            text: qsTr("2. Выберите нужный лист")
            font.family: "Segoe UI"
            color: "#7a7a7a"
            font.bold: true
            font.pixelSize: 20
        }



        RowLayout {
            spacing: 10


            CustomComboBox {
                id: sheetName
                placeholderText: "Выберите лист..."
                model: sheetModel
            }

            CustomButton {
                text: qsTr("Загрузить")
                onClicked: columnNames.text = appcore.getColumnNames(fileDialog.selectedFile.toString().slice(8),
                                                                     sheetName.currentText);

            }
        }

        Text {
            text: qsTr("3. Выберите действие для каждой из колонок")
            font.family: "Segoe UI"
            color: "#7a7a7a"
            font.bold: true
            font.pixelSize: 20
        }

        RowLayout {
            spacing: 10

            Text {
                text: qsTr("Названия колонок: ")
                font.family: "Segoe UI"
                color: "#006ded"
                font.pixelSize: 20

            }

            Text {
                id: columnNames
                font.family: "Segoe UI"

            }

            RowLayout {
                spacing: 10
            }

            ComboBox {

                    textRole: "text"
                    valueRole: "value"
                    model: [
                        { value: Qt.NoModifier, text: qsTr("No modifier") },
                        { value: Qt.ShiftModifier, text: qsTr("Shift") },
                        { value: Qt.ControlModifier, text: qsTr("Control") }
                    ]
                }
        }
    }
}
