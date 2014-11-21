import QtQuick 2.1
import QtQuick.Controls 1.0
import QtPositioning 5.2
import QtQuick.Layouts 1.0
import "content"

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: "Locmap"

    TabView {
        id:tabs
        anchors.fill: parent

        Tab {
            id: locationsPage
            title: "Locations"
            Locations {}
        }
        Tab {
            id: collectionsPage
            title: "Collections"
        }
        Tab {
            id: usersPage
            title: "Users"
            Users {}
        }
        Tab {
            id: imagesPage
            title: "Images"
        }
    }

}
