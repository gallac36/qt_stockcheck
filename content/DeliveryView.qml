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

        Component.onCompleted: {
                // Access the database object
                if (databaseHandler.openDatabase()) {
                    inventoryDatabase.createDeliveryTable();
                    console.log("Database opened successfully in DeliveryView.qml");
                } else {
                    console.error("Failed to open the database in DeliveryView.qml");
                }
            }

        // Use Connections to handle the completion of the QML engine
        Connections {
            target: databaseHandler

            // Assuming you have a signal named databaseLoaded in DatabaseWrapper
            onDatabaseLoaded: {
                console.log("Database loaded in InventoryView.qml");
                // Perform operations with the database, e.g., execute queries
                var query = "SELECT * FROM DeliveryData";
                var result = databaseHandler.database.exec(query);

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
                id: saveButton
                font: gridLayout.font
                text: "Save"
                onClicked: {
                    var brandValue = brandInput.text;
                    var amountValue = parseInt(amountInput.text);
                    var dateValue = dateInput.text;
                    var itemCountValue = parseInt(itemCountInput.text);

                    console.log("Values to be inserted:", brandValue, amountValue, dateValue, itemCountValue);

                    // Save the input to the database
                    if (databaseHandler.insertData(brandValue, amountValue, dateValue, itemCountValue)) {
                        console.log("Data inserted successfully!");
                        // Clear the form for another entry
                        brandInput.text = "";
                        amountInput.text = "";
                        dateInput.text = "";
                        itemCountInput.text = "";
                    } else {
                        console.error("Failed to insert data:");
                    }
                }
            }
        }
    }
}

