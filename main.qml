import QtQuick 2.2
import QtQuick.Controls 1.1
import QtPositioning 5.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Loader {
        id: pageLoader
        source: "hello.qml"
        //anchors.fill: parent
        anchors.centerIn: parent
    }

    function setSource(sorsa) {
        pageLoader.source = sorsa
    }


    menuBar: MenuBar {


        Menu {
            title: qsTr("View")
            MenuItem {
                text: qsTr("Map")
                onTriggered: setSource("map.qml")
            }
            MenuItem {
                text: qsTr("Locations")

            }
        }
        Menu {
            title: qsTr("Add")
            MenuItem {
                text: qsTr("Location")
                onTriggered: setSource("newLocation.qml")
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
}
