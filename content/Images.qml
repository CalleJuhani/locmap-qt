import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.0
import SortFilterProxyModel 0.1
import "network.js" as NetworkApi

Item {
    id:images
    anchors.fill: parent
    anchors.margins: 8


    function updateImageListModel() {
        NetworkApi.getImages(function(images) {
            imageListModel.clear();
            images.forEach(function(e) {
                imageListModel.append({_id: e._id, location: e.location, owner: e.owner, created_at: e.created_at});
            });
        });
    }


    function fillImageDetails(listModel) {
        txtObjectId.text = listModel._id;
        txtLocation.text = listModel.location;
        txtOwner.text = listModel.owner;
        txtCreated.text = listModel.created_at
    }

    function emptyImageDetails(listModel) {
        txtObjectId.text = "";
        txtLocation.text = "";
        txtOwner.text = "";
        txtCreated.text = "";
    }

    function deleteImage() {
        if (txtObjectId.text) {
            NetworkApi.deleteImage(txtObjectId.text, token, function(res) {
                txtStatus.text = res;
                emptyImageDetails();
                imagesTable.currentRow = -1;
            });
        }
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
                        id: btnLoadImages
                        text: "Load"
                        onClicked: updateImageListModel();
                    }

                    Row {
                        spacing: 10

                        Label { text: "Filter:" }

                        TextField {
                            id: txtSearch
                            Layout.fillWidth: true
                        }
                    }
                }
            }

            //Image details, delete
            GroupBox {
                id: imageBox
                title: "Image details"
                width: parent.width/1.5
                height: 110
                Column {
                    spacing: 5

                    GridLayout {
                        columns: 4

                        Label { text: "ObjectId" }
                        TextField { id: txtObjectId }
                        Label { text: "Location" }
                        TextField { id: txtLocation }

                        Label { text: "Owner" }
                        TextField { id: txtOwner }
                        Label { text: "Created_at" }
                        TextField { id: txtCreated }

                    }
                    Row {
                        spacing: 10
                        Button {
                            text: "Delete"
                            onClicked: deleteImage();
                        }
                    }
                }

            }

        }


        SplitView {
            Layout.fillHeight: true
            Layout.fillWidth: true

        TableView {
            id: imagesTable
            width: parent.width / 2;
            sortIndicatorVisible: true

            onDoubleClicked: fillImageDetails(proxyModel.get(imagesTable.currentRow));

            TableViewColumn {
                role: "_id"
                title: "ObjectId"
                width: 120
            }
            TableViewColumn {
                role: "location"
                title: "Location"
                width: 120
            }
            TableViewColumn {
                role: "created_at"
                title: "Created"
            }
            TableViewColumn {
                role: "owner"
                title: "Owner"
            }

            model: SortFilterProxyModel {
                id: proxyModel
                source: imageListModel.count > 0 ? imageListModel : null

                sortOrder: imagesTable.sortIndicatorOrder
                sortCaseSensitivity: Qt.CaseInsensitive
                sortRole: imageListModel.count > 0 ?
                              imagesTable.getColumn(imagesTable.sortIndicatorColumn).role : ""

                filterRole: ""
                filterString: "*" + txtSearch.text + "*"
                filterSyntax: SortFilterProxyModel.Wildcard
                filterCaseSensitivity: Qt.CaseInsensitive
            }

        }

        Image {
            width: parent.width / 2
            id: image
            fillMode: Image.PreserveAspectFit
            source: imagesTable.currentRow !== -1 ? "http://api.locmap.net/v1/images/" + proxyModel.get(imagesTable.currentRow)._id : ""

            BusyIndicator {
                running: image.status === Image.Loading
                anchors.centerIn: parent
            }
        }

        }


        ListModel {
            id: imageListModel
        }


    }
}
