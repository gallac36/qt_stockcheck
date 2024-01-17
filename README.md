# StockCheck App
### A Qt Quick App

This is a simple app that demonstrates the use of Qt Creator to build a Qt Quick app
The app first loads a welcome/login screen "LoginScreen.qml". A loader is used with 
the login button to load the second screen "mainPage.qml. The login button is more for show at this time but credentials and authorisation could be added later.
The main page consists of 2 views in a StackLayout. The views are switched using the 2 main buttons which act more like tabs in this functionality.

The layout was designed using my Samsung A54 which has a screen resolution of 1040*2340. Some elements are more responsive than others.


<img src="/Screenshot_1.jpg" width="150"/>      <img src="/Screenshot_2.jpg" width="150"/>

The exit button quits the app. The code to launch a popup dialogue is there but commented out due to plugin issues.

## Issues

The primary issue was difficulty accessing an SQLite database in QML for an application developed using Qt Quick. The goal was to interact with the database directly from QML to perform operations such as inserting, querying, and updating data.
Attempted Solution:

To address this issue, an attempt was made to create a DatabaseWrapper class in C++ that would expose the SQLite database to QML. This class utilized signals and slots to emit a signal (databaseLoaded) upon successful database initialization. The intention was to connect this signal to QML and perform database operations when the signal was emitted.

However, despite the effort to use the DatabaseWrapper class, there were challenges in connecting the signal and handling the database object in QML. The onDatabaseLoaded property was created in QML to respond to the emitted signal, but there were difficulties in using the database object (db) directly within QML components.

Unfortunately, due to constraints and time limitations, a complete solution to seamlessly integrate the SQLite database with QML could not be achieved.

The issue with the quit dialogue indicates that the QtQuick.Dialogs module is not installed or imported in the QML file. But it is, so might be an issue with Qt versions, needs further exploring. 
