import QtQuick 2.2
import QtQuick.Controls 1.1
import QtPositioning 5.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    menuBar: MenuBar {
        Menu {
            title: qsTr("View")
            MenuItem {
                text: qsTr("Map")
                onTriggered: Qt.quit();
            }
            MenuItem {
                text: qsTr("Locations")
            }
        }
        Menu {
            title: qsTr("Add")
            MenuItem {
                text: qsTr("Location")
            }
        }
        Menu {
            title: qsTr("User")
            MenuItem {
                text: qsTr("Log in")
            }
            MenuItem {
                text: qsTr("Register")
            }
        }
    }

    Text {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }
}
