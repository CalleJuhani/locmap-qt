import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "content"

ApplicationWindow {
    id: root
    visible: true
    width: 900
    height: 500
    title: "LocMap Control Panel"


    //Custom properties for application window
    //Used as "global" variables
    property string token: "";
    property string apiBase: "http://api.locmap.net/v1/"

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
