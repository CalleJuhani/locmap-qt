
import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0

Item {
    id:users
    anchors.fill: parent
    anchors.margins: 8

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent

        GroupBox {
            id: gridBox
            title: "Search users"
            Layout.fillWidth: true

            GridLayout {
                id: gridLayout
                anchors.fill: parent
                rows: 3
                flow: GridLayout.TopToBottom

                Label { text: "ObjectID:" }
                Label { text: "Username:" }
                Label { text: "Email:" }

                TextField {
                 Layout.fillWidth: true
                }
                TextField {
                    Layout.fillWidth: true
                }
                TextField {
                    Layout.fillWidth: true
                }

            }

        }


        ListModel {
            id: dummyModel
            Component.onCompleted: {
                for (var i = 0 ; i < 100 ; ++i) {
                    append({"id": i, "username": "user" + i, "email" :"gg@gg.com", "credit" : "N/A"})
                }
            }
        }

        TableView{
            model: dummyModel
            Layout.fillHeight: true
            Layout.fillWidth: true

            TableViewColumn {
                role: "id"
                title: "ObjectId"
                width: 120
            }
            TableViewColumn {
                role: "username"
                title: "Username"
                width: 120
            }
            TableViewColumn {
                role: "email"
                title: "Email"
                width: 120
            }
        }

    }
}

