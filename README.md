# ColorMemoryGame

This is a game where you have to remember cards and find two pairs which have to be matched. In the end of the game you can save your best score into internal database. 
I built this game as an assignment and would like to share my source code publicly. 

To write the app I used Swift 4 with Xcode 9. While developing User Interface I built it with a storyboard and autolayout, and a tableview with High Scores I set programmatically using SnapKit framework to speed up setting constraints programmatically. Additionally as an internal database to save scores I used Realm Database. 
Also I've done a bit of Unit Testing. 


To be able to run the app on simulator you need to:

1. Open Terminal
2. Navigate to the project
3. run 'pod install'

If you still can't run the app the check the scheme of the app. To do so:

1. Open the project with .xcworkspace extension
2. At the top near a 'stop' button you need to edit scheme
3. When the window pop up go to Run -> Info -> Change Excutable to AccedoTvTestApp.app
4. Close the window and build a project. 

