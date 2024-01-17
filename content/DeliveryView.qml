import QtQuick 6.2
import QtQuick.Controls 6.5
import QtQuick.Layouts


//Outer rectangle is just to to see swopping between delivery view and inventory view
Rectangle {
    id: rectangleBroder1
    color: "#ffcc05"

    Rectangle {
        id: rectangleDel
        color: "white"
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 20
        anchors.bottomMargin: 20


        // Use Connections to handle the completion of the QML engine
        Connections {
            target: inventoryDatabase

            // Assuming you have a signal named databaseLoaded in DatabaseWrapper
            onDatabaseLoaded: {
                console.log("Database loaded in InventoryView.qml");
                // Perform operations with the database, e.g., execute queries
                var query = "SELECT * FROM DeliveryData";
                var result = inventoryDatabase.database.exec(query);

                while (result.next()) {
                    console.log("Record:", result.value("brand"), result.value("amountDelivered"));
                }
            }
        }

        GridLayout {
            id: gridLayout
            anchors.top: parent.top
            anchors.leftMargin: 20
            anchors.topMargin: 20
            columns: 2
            rowSpacing: 5
            columnSpacing: -1
            anchors {
                        left: parent.left
                        right: parent.right
                    }

            FontMetrics {
                id: fontMetrics
                font.family: "Arial"
                font.pixelSize: 60
                font.bold: true
              }
            property alias font: fontMetrics.font


            Label {
                font: gridLayout.font
                text: "Item Name"
            }
            TextField {

                id: brandInput
                font: gridLayout.font
                Layout.fillWidth: true
                placeholderText: "Brand"
            }
            Label {
                text: "Amount Delivered"
                font: gridLayout.font
            }
            TextField {
                id: amountInput
                font: gridLayout.font
                Layout.fillWidth: true
                placeholderText: "Amount Delivered"
                inputMethodHints: Qt.ImhDigitsOnly
            }
            Label {
                text: "Delivery Date"
                font: gridLayout.font
            }
            TextField {
                id: dateInput
                font: gridLayout.font
                Layout.fillWidth: true
                placeholderText: "Delivery Date"
            }
            Label {
                text: "Item Count"
                font: gridLayout.font
            }
            TextField {
                id: itemCountInput
                font: gridLayout.font
                Layout.fillWidth: true
                placeholderText: "Item Count"
                inputMethodHints: Qt.ImhDigitsOnly
            }

            Button {
                font: gridLayout.font
                text: "Save"
                onClicked: {
                    console.log("Save button clicked");
                    // Save the input to the database
                    var query = "INSERT INTO DeliveryData (brand, amountDelivered, deliveryDate, itemCount) VALUES ("
                                + "'" + brandInput.text + "',"
                                + amountInput.text + ","
                                + "'" + dateInput.text + "',"
                                + itemCountInput.text + ")";

                    var result = db.exec(query);

                        // Check if the query was successful
                        if (result.rowsAffected > 0) {
                            // Clear the form for another entry
                            brandInput.text = "";
                            amountInput.text = "";
                            dateInput.text = "";
                            itemCountInput.text = "";

                            // (Optional) Signal a change in the model if you have connected properties to UI components
                            // This helps update the UI when the underlying data changes
                            brandInput.model = "";
                            amountInput.model = "";
                            dateInput.model = "";
                            itemCountInput.model = "";
                        }

                }
            }
        }
    }
}

