import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import SortFilterProxyModel 0.1
import QtQuick.XmlListModel 2.0

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
                 id: idSearch
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

        /*XmlListModel {
            id: usersModel
            source: "http://student.labranet.jamk.fi/~G2481/qt/users.xml"
            query: "/users/user"

            XmlRole { name: "id"; query: "id/string()" }
            XmlRole { name: "username"; query: "username/string()" }
            XmlRole { name: "email"; query: "email/string()" }
        }*/

        JSONListModel {
            id: jsonModel1
            source: "http://api.locmap.net/v1/users"
            // All books in the store object
            query: "$.[*]"
        }

        /*ListModel {
            id: usersModel
            Component.onCompleted: {
                for (var i = 0 ; i < 100 ; ++i) {
                    append({"id": i, "username": "user" + i, "email": "gg@gg.com"})
                }
            }
        }*/

        TableView {
            //model: dummyModel
            id: usersTable
            Layout.fillHeight: true
            Layout.fillWidth: true
            sortIndicatorVisible: true

            model: SortFilterProxyModel {
                id: proxyModel
                source: jsonModel1.model.count > 0 ? jsonModel1.model : null

                sortOrder: usersTable.sortIndicatorOrder
                sortCaseSensitivity: Qt.CaseInsensitive
                sortRole: jsonModel1.model.count > 0 ?
                          usersTable.getColumn(usersTable.sortIndicatorColumn).role : ""

                filterString: "*" + idSearch.text + "*"
                filterSyntax: SortFilterProxyModel.Wildcard
                filterCaseSensitivity: Qt.CaseInsensitive
            }

            TableViewColumn {
                role: "_id"
                title: "ObjectId"
            }
            TableViewColumn {
                role: "username"
                title: "Username"
            }
            TableViewColumn {
                role: "email"
                title: "Email"
            }
            TableViewColumn {
                role: "created_at"
                title: "Created"
            }
            TableViewColumn {
                role: "updated_at"
                title: "Updated"
            }
        }

    }
}

