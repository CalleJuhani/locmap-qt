import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import SortFilterProxyModel 0.1
import QtQuick.XmlListModel 2.0
import "network.js" as NetworkApi

Item {
    id:users
    anchors.fill: parent
    anchors.margins: 8


    function updateUserListModel() {
        NetworkApi.getUsers(function(users) {
            userListModel.clear();
            users.forEach(function(e) {
                userListModel.append({_id: e._id, username: e.username, email: e.email, created_at: e.created_at});
            });
        });
    }


    ColumnLayout {
        id: mainLayout
        anchors.fill: parent


        //Search components
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


        TableView {
            id: usersTable
            Layout.fillHeight: true
            Layout.fillWidth: true
            sortIndicatorVisible: true

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

            model: SortFilterProxyModel {
                id: proxyModel
                source: userListModel.count > 0 ? userListModel : null

                sortOrder: usersTable.sortIndicatorOrder
                sortCaseSensitivity: Qt.CaseInsensitive
                sortRole: userListModel.count > 0 ?
                          usersTable.getColumn(usersTable.sortIndicatorColumn).role : ""

                filterRole: ""
                filterString: "*" + idSearch.text + "*"
                filterSyntax: SortFilterProxyModel.Wildcard
                filterCaseSensitivity: Qt.CaseInsensitive
            }

        }


        ListModel {
            id: userListModel
            Component.onCompleted: {
                users.updateUserListModel();
            }
        }


    }
}
