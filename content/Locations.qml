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
            title: "Search locations"
            Layout.fillWidth: true

            GridLayout {
                id: gridLayout
                anchors.fill: parent
                rows: 3
                flow: GridLayout.TopToBottom

                Label { text: "ObjectID:" }
                Label { text: "Title:" }
                Label { text: "Description:" }

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

        JSONListModel {
            id: jsonModel1
            source: "http://api.locmap.net/v1/locations"
            query: "$.[*]"
        }

        TableView {
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
                role: "title"
                title: "Title"
            }
            TableViewColumn {
                role: "description"
                title: "Description"
            }
            TableViewColumn {
                role: "latitude"
                title: "Latitude"
            }
            TableViewColumn {
                role: "longitude"
                title: "Longitude"
            }
            TableViewColumn {
                role: "owners"
                title: "Owners"
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

