import QtQuick 6.2
import QtQuick.Controls 6.5
import QtQuick.Layouts

Rectangle {
    id: rectangleMain
    anchors.fill: parent
    color: "white"

    Image {
        id: imageTop
        x: 0
        y: 0
        width: 1080
        height: 236
        anchors.topMargin: 30
        source: "qrc:/content/images/foodcheck-2-logo.png"
        fillMode: Image.PreserveAspectFit
    }

    OptionsBar{
        id: optionsBar
        anchors.top: imageTop.bottom


    }



    StackLayout {
        id: stackLayout
        anchors {
            top: optionsBar.bottom
            bottom: parent.bottom
            right: parent.right
            left: parent.left
        }

            DeliveryView {
                id: deliveryView
                width: stackLayout.width
                height: stackLayout.height

            }
            InventoryView {
                id: inventoryView
                width: stackLayout.width
                height: stackLayout.height

            }
            Rectangle {
                id: deliveryView1
                width: stackLayout.width
                height: stackLayout.height
                color: "lightblue"

                // Add content for the "Delivery" view here
                Text {
                    anchors.centerIn: parent
                    text: "Delivery View Content"
                }
            }

            Rectangle {
                id: inventoryView1
                width: stackLayout.width
                height: stackLayout.height
                color: "lightgreen"

                // Add content for the "Inventory" view here
                Text {
                    anchors.centerIn: parent
                    text: "Inventory View Content"
                }
            }



    }
}
