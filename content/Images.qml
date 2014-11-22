
import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0

Item {
    id:images
    anchors.fill: parent
    anchors.margins: 8

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent

        GroupBox {
            id: gridBox
            title: "Search images"
            Layout.fillWidth: true

            GridLayout {
                id: gridLayout
                anchors.fill: parent
                rows: 2
                flow: GridLayout.TopToBottom

                Label { text: "Title:" }
                Label { text: "Description:" }

                TextField {
                 Layout.fillWidth: true
                }
                TextField {
                    Layout.fillWidth: true
                }

            }
        }
    }
}

