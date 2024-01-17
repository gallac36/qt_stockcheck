import QtQuick 6.2
//Outer rectangle is just to make it easier to see swopping between delivery view and inventory view
Rectangle {
    id: rectangleBroder2
    color: "#81b8d6"

    Rectangle {
        id: rectangleInv
        color: "white"
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 20
        anchors.bottomMargin: 20


        // Use Connections to handle the completion of the QML engine
        Connections {
            target: inventoryDatabase // Assuming inventoryDatabase is the id of the database object in your root context
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

                Text {
                    text: "Brand: " + model.brand +
                          ", Amount: " + model.amountDelivered +
                          ", Date: " + model.deliveryDate +
                          ", Item Count: " + model.itemCount
                }
            }
        }

        Component.onCompleted: {
            // Load data from the database when the view is created
            loadData();
        }

        function loadData() {
            inventoryModel.clear();
            var query = "SELECT * FROM DeliveryData";
            var result = db.exec(query);
            while (result.next()) {
                inventoryModel.append({
                    brand: result.value("brand"),
                    amountDelivered: result.value("amountDelivered"),
                    deliveryDate: result.value("deliveryDate"),
                    itemCount: result.value("itemCount")
                });
            }
        }
    }
}

