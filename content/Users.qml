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
        NetworkApi.getUsers(token, function(users) {
            userListModel.clear();
            users.forEach(function(e) {
                userListModel.append({_id: e._id, username: e.username, email: e.email, created_at: e.created_at, updated_at: e.updated_at});
            });
        });
    }


    function fillUserDetails(listModel) {
        txtObjectId.text = listModel._id;
        txtEmail.text = listModel.email;
        txtUsername.text = listModel.username;
        txtCreated.text = listModel.created_at
        txtUpdated.text = listModel.updated_at;
    }


    ColumnLayout {
        id: mainLayout
        anchors.fill: parent

        SplitView {
            anchors.fill: parent

            //List controls
            GroupBox {
                id: gridBox
                title: "List controls"
                width: parent.width/3

                Column {
                    spacing: 10
                    Button {
                        id: btnLoadUsers
                        text: "Load"
                        onClicked: updateUserListModel();
                    }

                    Row {
                        spacing: 10

                        Label { text: "Filter:" }

                        TextField {
                            id: idSearch
                            Layout.fillWidth: true
                        }
                    }
                }
            }

            //User details, update/delete
            GroupBox {
                id: userBox
                title: "User details"
                width: parent.width/1.5
                height: 110
                Column {
                    spacing: 5

                    GridLayout {
                        columns: 4

                        Label { text: "ObjectId" }
                        TextField { id: txtObjectId }
                        Label { text: "Username" }
                        TextField { id: txtUsername }

                        Label { text: "Email" }
                        TextField { id: txtEmail }
                        Label { text: "Created_at" }
                        TextField { id: txtCreated }

                        Label { text: "Updated_at" }
                        TextField { id: txtUpdated }

                    }
                    Row {
                        spacing: 10
                        Button { text: "Update" }
                        Button { text: "Delete" }
                    }
                }

            }

        }


        TableView {
            id: usersTable
            Layout.fillHeight: true
            Layout.fillWidth: true
            sortIndicatorVisible: true

            onDoubleClicked: fillUserDetails(proxyModel.get(usersTable.currentRow));

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
        }


    }
}
