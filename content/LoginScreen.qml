import QtQuick 6.2
import QtQuick.Controls 6.2


Rectangle {
    id: rectangle
    anchors.fill: parent

    color: "#359e46"

    Image {
        id: image
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/content/images/Kelsius-Logo-Colour.png"
        width: 950
        height: 530

    }

    Text {
        id: appName

        text: "StockCheck"
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 150
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: true
        font.family: Constants.largeFont.family

    }
    Text {
        id: tagLine

        text: "Complete Stock control"
        anchors.top: appName.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 50
        font.bold: true
        font.family: Constants.largeFont.family

    }

    Item {
        id: contentContainer
        anchors.fill: parent


        Loader {
            id: pageLoader
            anchors.fill: parent
            source: "mainPage.qml"
            active: false // Initially set to false to hide the loaded content
        }

        Button {
            id: button
            anchors.horizontalCenter: parent.horizontalCenter
            y: 1249
            width: 700
            height: 150
            text: qsTr("Login")
            checkable: true
            font.weight: Font.Bold
            font.pointSize: 40

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    pageLoader.active = true
                    button.visible = false; // Hide the button when loading mainPage
                }
            }
        }
    }
}
