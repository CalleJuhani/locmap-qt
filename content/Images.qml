
import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import SortFilterProxyModel 0.1

Item {
    id:images
    anchors.fill: parent
    anchors.margins: 8

    SplitView {
        anchors.fill: parent

        ColumnLayout {
            id: leftLayout
            width: parent.width / 2

            GroupBox {
                id: gridBox
                title: "Search images"
                Layout.fillWidth: true

                GridLayout {
                    id: gridLayout
                    rows: 2
                    flow: GridLayout.TopToBottom

                    Label { text: "ObjectId:" }
                    Label { text: "Location:" }

                    TextField {
                        Layout.fillWidth: true
                    }
                    TextField {
                        Layout.fillWidth: true
                    }

                }
            }

            JSONListModel {
                id: imagesModel
                source: "http://api.locmap.net/v1/images"
                query: "$.[*]"
            }

            TableView {
                id: imagesTable
                sortIndicatorVisible: true
                Layout.fillWidth: true
                Layout.fillHeight: true

                model: SortFilterProxyModel {
                    id: proxyModel
                    source: imagesModel.model.count > 0 ? imagesModel.model : null

                    sortOrder: imagesTable.sortIndicatorOrder
                    sortCaseSensitivity: Qt.CaseInsensitive
                    sortRole: imagesModel.model.count > 0 ?
                                  imagesTable.getColumn(imagesTable.sortIndicatorColumn).role : ""

                    filterString: "*" + "" + "*"
                    filterSyntax: SortFilterProxyModel.Wildcard
                    filterCaseSensitivity: Qt.CaseInsensitive
                }

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
}

