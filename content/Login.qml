import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import "network.js" as NetworkApi

Item {
    id:login
    anchors.fill: parent
    anchors.margins: 8

    ColumnLayout {
        id: mainLayout
        anchors.top: parent.top
        width: parent.width

        GroupBox {
            id: loginBox
            title: "Log In"
            Layout.fillWidth: true

            GridLayout {
                id: gridLayout
                width: 300
                columns: 2
                flow: GridLayout.LeftToRight

                Label {
                    text: "Email"
                }

                TextField {
                    id: txtEmail
                    width: 80
                    height: 20
                }

                Label {
                    text: "Password"
                }

                TextField {
                    id: txtPassword
                    echoMode: TextInput.Password
                    width: 80
                    height: 20
                }

                Button {
                    id: btnLogin
                    text: "Log In"
                    onClicked: {
                        var credentials = {
                            email: txtEmail.text,
                            password: txtPassword.text
                        }
                        NetworkApi.base = apiBase;
                        print(JSON.stringify(credentials));
                        NetworkApi.postLogin(JSON.stringify(credentials), function(res) {
                            if (res){
                                token = res;
                                print(token);
                                txtStatus.text = "Logged in"
                                //activate tabs
                                locationsPage.enabled = true;
                                usersPage.enabled = true;
                                imagesPage.enabled = true;
                            }
                        });
                    }

                }

            }

        }

        GroupBox {
            id: settingsBox
            title: "Settings"
            Layout.fillWidth: true

            Column {
                Label {
                    text: "API address"
                }

                TextField {
                    text: apiBase
                    width: 200
                }

                Button {
                    text: "Update"
                }

            }



        }

    }

}
