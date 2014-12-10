import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.0
import SortFilterProxyModel 0.1
import "network.js" as NetworkApi

Item {
    id:users
    anchors.fill: parent
    anchors.margins: 8


    function updateUserListModel() {
        NetworkApi.getUsers(token, function(users) {
            userListModel.clear();
            users.forEach(function(e) {
                userListModel.append({_id: e._id, username: e.username, email: e.email,
                                         role: e.role, created_at: e.created_at, updated_at: e.updated_at});
            });
        });
    }

    function fillUserDetails(listModel) {
        txtObjectId.text = listModel._id;
        txtEmail.text = listModel.email;
        txtUsername.text = listModel.username;
        txtRole.text = listModel.role;
        txtCreated.text = listModel.created_at
        txtUpdated.text = listModel.updated_at;
    }

    function emptyUserDetails(listModel) {
        txtObjectId.text = "";
        txtEmail.text = "";
        txtUsername.text = "";
        txtRole.text = "";
        txtCreated.text = "";
        txtUpdated.text = "";
    }

    function deleteUser() {
        if (txtObjectId.text) {
            NetworkApi.deleteUser(txtObjectId.text, token, function(res) {
                txtStatus.text = res;
                emptyUserDetails();
            });
        }
    }

    function updateUser() {
        if (!txtObjectId.text)
            return;

        var user = {
            username: txtUsername.text,
            email: txtEmail.text,
            role: txtRole.text
        }

        NetworkApi.putUser(txtObjectId.text, JSON.stringify(user), token, function(status, message) {
            if (status === 200) {
                txtStatus.text = "Updated: " + txtObjectId.text;
                emptyUserDetails();
            } else {
                txtStatus.text = "Message from server: " + message;
            }
        });
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
                        columns: 6

                        Label { text: "ObjectId" }
                        TextField { id: txtObjectId }
                        Label { text: "Username" }
                        TextField { id: txtUsername }

                        Label { text: "Email" }
                        TextField { id: txtEmail }

                        Label { text: "Role" }
                        TextField { id: txtRole }

                        Label { text: "Created_at" }
                        TextField { id: txtCreated }

                        Label { text: "Updated_at" }
                        TextField { id: txtUpdated }

                    }
                    Row {
                        spacing: 10
                        Button {
                            text: "Update"
                            onClicked: updateUser();
                        }
                        Button {
                            text: "Delete"
                            onClicked: deleteUser();
                        }
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
                role: "role"
                title: "role"
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
