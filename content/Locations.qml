import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.0
import SortFilterProxyModel 0.1
import "network.js" as NetworkApi

Item {
    id:locations
    anchors.fill: parent
    anchors.margins: 8


    function updateLocationListModel() {
        NetworkApi.getLocations(function(locations) {
            locationListModel.clear();
            locations.forEach(function(e) {
                locationListModel.append({_id: e._id, title: e.title, description: e.description,
                                             latitude: e.latitude, longitude: e.longitude,
                                             created_at: e.created_at, updated_at: e.updated_at});
            });
            txtStatus.text = "Loaded locations"
        });
    }


    function deleteLocation() {
        if (txtObjectId.text) {
            NetworkApi.deleteLocation(txtObjectId.text, token, function(res) {
                txtStatus.text = res;
                emptyLocationDetails();
            });
        }
    }


    function updateLocation() {
        if (!txtObjectId.text)
            return;

        var location = {
            title: txtTitle.text,
            description: txtDescription.text,
            latitude: Number(txtLatitude.text),
            longitude: Number(txtLongitude.text)
        }

        NetworkApi.putLocation(txtObjectId.text, JSON.stringify(location), token, function(status, message) {
            if (status === 200) {
                txtStatus.text = "Updated: " + txtObjectId.text;
                emptyLocationDetails();
            } else {
                txtStatus.text = "Message from server: " + message;
            }
        });

    }


    function emptyLocationDetails() {
        txtObjectId.text = "";
        txtTitle.text = "";
        txtDescription.text = "";
        txtLatitude.text = "";
        txtLongitude.text = "";
        txtCreated.text = "";
        txtUpdated.text = "";
    }


    function fillLocationDetails(listModel) {
        txtObjectId.text = listModel._id;
        txtTitle.text = listModel.title;
        txtDescription.text = listModel.description;
        txtLatitude.text = listModel.latitude;
        txtLongitude.text = listModel.longitude;
        txtCreated.text = listModel.created_at;
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
                        id: btnLoadLocations
                        text: "Load"
                        onClicked: updateLocationListModel();
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

            //Location details, update/delete
            GroupBox {
                id: locationBox
                title: "Location details"
                width: parent.width/1.5
                height: 135
                Column {
                    spacing: 5

                    GridLayout {
                        columns: 6

                        Label { text: "ObjectId" }
                        TextField { id: txtObjectId }
                        Label { text: "Title" }
                        TextField { id: txtTitle }

                        Label { text: "Description" }
                        TextField { id: txtDescription }
                        Label { text: "Latitude" }
                        TextField { id: txtLatitude }

                        Label { text: "Longitude" }
                        TextField { id: txtLongitude }

                        Label { text: "Created_at" }
                        TextField { id: txtCreated }
                        Label { text: "Updated_at" }
                        TextField { id: txtUpdated }

                    }
                    Row {
                        spacing: 10
                        Button {
                            text: "Update"
                            onClicked: updateLocation();
                        }
                        Button {
                            text: "Delete"
                            onClicked: deleteLocation();
                        }
                    }
                }

            }

        }


        TableView {
            id: locationsTable
            Layout.fillHeight: true
            Layout.fillWidth: true
            sortIndicatorVisible: true

            onDoubleClicked: fillLocationDetails(proxyModel.get(locationsTable.currentRow));

            TableViewColumn {
                role: "_id"
                title: "ObjectId"
            }
            TableViewColumn {
                role: "title"
                title: "Title"
            }
            TableViewColumn {
                role: "description"
                title: "Description"
            }
            TableViewColumn {
                role: "latitude"
                title: "Latitude"
            }
            TableViewColumn {
                role: "longitude"
                title: "Longitude"
            }
            TableViewColumn {
                role: "owners"
                title: "Owners"
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
                source: locationListModel.count > 0 ? locationListModel : null

                sortOrder: locationsTable.sortIndicatorOrder
                sortCaseSensitivity: Qt.CaseInsensitive
                sortRole: locationListModel.count > 0 ?
                              locationsTable.getColumn(locationsTable.sortIndicatorColumn).role : ""

                filterRole: ""
                filterString: "*" + idSearch.text + "*"
                filterSyntax: SortFilterProxyModel.Wildcard
                filterCaseSensitivity: Qt.CaseInsensitive
            }

        }


        ListModel {
            id: locationListModel
        }


    }
}
