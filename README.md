# StockCheck App
### A Qt Quick App

This is a simple app that demonstrates the use of Qt Creator to build a Qt Quick app
The app first loads a welcome/login screen "LoginScreen.qml". A loader is used with 
the login button to load the second screen "mainPage.qml. The login button is more for show at this time but credentials and authorisation could be added later.
The main page consists of 2 views in a StackLayout. The views are switched using the 2 main buttons which act more like tabs in this functionality.

The layout was designed using my Samsung A54 which has a screen resolution of 1040*2340. Some elements are more responsive than others.


<img src="/Screenshot_1.jpg" width="150"/>      <img src="/Screenshot_2.jpg" width="150"/>

The exit button quits the app. The code to launch a popup dialogue is there but commented out due to plugin issues.

##ToDo
The inventory view needs to be presented in columns.
Make the inventory view editable.
Sort by date, name, etc
make the delivery date in the delivery view default to today's date.


## Issues
The code to generate a popup dialogue that asks the user if they are sure they want to quit before closing the app is there but commented out. The issue with the quit dialogue indicates that the QtQuick.Dialogs module is not installed or imported in the QML file. But it is, so might be an issue with Qt versions, needs further exploring. 
