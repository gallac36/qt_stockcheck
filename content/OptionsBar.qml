import QtQuick 6.3
import QtQuick.Controls 6.2
import QtQuick.Layouts

Rectangle {
    id: optionsBarRec
    height: 150
    color: "white"
    anchors {
        left: parent.left
        top: parent.top
        right: parent.right
    }


    Button {
        id: deliveryButton
        anchors.top: parent.top
        height: parent.height
        width: parent.width/3
        padding: 20
        text: "Delivery"
        font.pixelSize: 70
        font.bold: true
        onClicked: stackLayout.currentIndex = 0 // Show the "Delivery" view

    }
    Button {
        id: invButton
        anchors {
            left: deliveryButton.right
            top: parent.top
        }
        padding: 20
        height: parent.height
        width: parent.width/3
        text: "Inventory"
        spacing: 10
        font.pixelSize: 70
        font.bold: true
        onClicked: stackLayout.currentIndex = 1 // Show the "Inventory" view


    }
    Button {
        id: exitButton

        anchors {
            right: parent.right
            top: parent.top
        }

        Layout.margins: 10
        width: parent.width/5
        height: parent.height

        text: "Exit"
        font.pixelSize: 70
        font.bold: true

        onClicked: {
                // Show a confirmation dialog
                // Well it would but haveing difficulties with import QtQuick.Dialogs 1.4
                /*
                var confirmationDialog = Qt.createQmlObject(
                    'import QtQuick.Dialogs 1.4; MessageDialog { title: "Confirmation"; text: "Are you sure you want to exit?"; standardButtons: StandardButton.Yes | StandardButton.No }',
                    parent
                );

                confirmationDialog.open();

                // Connect to the dialog's accepted signal
                confirmationDialog.accepted.connect(function() {
                    // User clicked "Yes", exit the application
                    Qt.quit();
                });
                */

            Qt.quit();


            }
    }

}

