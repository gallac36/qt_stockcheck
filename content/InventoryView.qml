import QtQuick 6.2
import QtQuick.Controls 6.5
import QtQuick.Layouts


//Outer rectangle is just to make it easier to see swopping between delivery view and inventory view
Rectangle {
    id: rectangleBroder2
    color: "#81b8d6"

    signal onDatabaseLoaded()

    function loadData() {
        // Ensure that the database is open
        if (!databaseHandler.open()) {
            console.log("Database is not open");
            return;
        }

        inventoryModel.clear();
        var query = "SELECT * FROM DeliveryData";

        console.log("Executing query:", query);
        var result = databaseHandler.execQuery(query);
        console.log("Result query:", result);


        // Emit the onDatabaseLoaded signal
       // onDatabaseLoaded();


        console.log("Result in QML:", result);
         // Ensure that result is a QVariantList
        if (result && typeof result === "object" && result.length > 0) {
                for (var i = 0; i < result.length; ++i) {
                    var row = result[i];
                    console.log("Brand:", row.brand, "Amount Delivered:", row.amountDelivered);

                    // Append the row to the ListModel
                    inventoryModel.append({
                        brand: row.brand,
                        amountDelivered: row.amountDelivered,
                        deliveryDate: row.deliveryDate,
                        itemCount: row.itemCount
                    });
                }
            } else {
                console.log("Invalid result from execQuery");
            }
    }

    Rectangle {
        id: rectangleInv
        color: "white"
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 20
        anchors.bottomMargin: 20

        //signal onDatabaseLoaded()

        // Use Connections to handle the completion of the QML engine
        Connections {
            target: databaseHandler
            onDatabaseLoaded: {
                console.log("Database loaded in InventoryView.qml");
                // Perform operations with the database, e.g., execute queries
                var query = "SELECT * FROM DeliveryData";
                var result = inventoryDatabase.exec(query);

                while (result.next()) {
                    console.log("Record:", result.value("brand"), result.value("amountDelivered"));
                }
            }
        }

        ListView {
            id: listView
            width: stackLayout.width
            height: stackLayout.height

            model: ListModel {
                id: inventoryModel
            }

            delegate: Item {

                width: listView.width
                height: 50

                Rectangle {
                    width: listView.width
                    height: 50

                    // Your background color or other styling for each row

                    GridLayout {
                        columns: 4 // Number of columns

                        Text {
                            text: "Brand: " + model.brand
                        }

                        Text {
                            text: "Amount: " + model.amountDelivered
                        }

                        Text {
                            text: "Date: " + model.deliveryDate
                        }

                        Text {
                            text: "Item Count: " + model.itemCount
                        }
                    }
                }
            }
        }

        Component.onCompleted: {
            // Load data from the database when the view is created
            loadData();
        }


    }
}

