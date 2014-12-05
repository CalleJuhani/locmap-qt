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
            id: gridBox
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

                        print(JSON.stringify(credentials));
                        NetworkApi.post("http://api.locmap.net/v1/auth/login", JSON.stringify(credentials), function(res) {
                            if (res){
                                token = res;
                                print(token);
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


    }

}
