import QtQuick 2.1
import QtQuick.Controls 1.0
import QtPositioning 5.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import "content"

ApplicationWindow {
    id: root
    visible: true
    width: 740
    height: 480
    title: "LocMap Control Panel"


    //Custom properties for application window
    //Used as "global" variables
    property string token: "";


    //TabView that forms the main layout of the program
    TabView {
        id:tabs
        anchors.fill: parent

        Tab {
            id: loginPage
            title: "Log In"
            Login {}
        }

        Tab {
            id: locationsPage
            enabled: false
            title: "Locations"
            Locations {}
        }

        Tab {
            id: usersPage
            enabled: false
            title: "Users"
            Users {}
        }

        Tab {
            id: imagesPage
            enabled: false
            title: "Images"
            Images {}
        }

    }

    statusBar: StatusBar {
        RowLayout {
            Label {
                id: txtStatus
                text: ""
            }
        }
    }


}
