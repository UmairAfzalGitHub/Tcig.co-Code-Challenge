
![Platform](https://img.shields.io/badge/Platform-iOS-orange.svg)
![Languages](https://img.shields.io/badge/Language-Swift-orange.svg)

Tcig technical challenge application created for demo purposes.

## Demo
<img src="https://media.giphy.com/media/7yUlSmCzh3wubJjyqJ/giphy.gif" width="250" height="500" />

## Calendar Demo
<img src="https://media.giphy.com/media/zssRLtBXgtHkTCwFGQ/giphy.gif" width="250" height="500" />

## Features

- [x] Search Page Design
- [x] DropDownTextField Control
- [x] Proprty List Data Fetching 
- [x] Error Handling With Popups
- [x] Unit Test For Model

## Cool Feature

- [x] [Highly customisable Custom Calendar Built using Swift By Me](https://github.com/UmairAfzalGitHub/Custom-Calendar-Swift) 😉
- [x] Swipe Date Range Selection

## Requirements

- iOS 13.0+
- Xcode 11+
- Swift 5+

## Design Pattern: Model-View-ViewModel (MVVM)
is a structural design pattern that separates objects into three distinct groups:
- #### Models 
  - hold application data. They’re usually structs or simple classes.
- #### Views 
  - display visual elements and controls on the screen. They’re typically subclasses of UIView.
- #### View models
  - transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references.

## Dependencies

- [IQKeyBoardManager](https://github.com/hackiftekhar/IQKeyboardManager)
  - Directly added to the project. No cocoapods or carthage dependencies involved.

## Installation

### Clone Or Download Repository

- Assuming you have downloaded the project in Downloads folder. Open the folder named Tcig-Demo and double click tcig-demo.xcodeproj. Build the project using cmd+B key as a good practice. Hit cmd+R to run the project on desired simulator selected.

### NOTE:

- The top most element i.e "Package Search" and back arrow. The design shows that the current screen is pushed from a screen and should be set in a UINavigationController and the back button and title is a deafult property of UINavigationContrloller. Howver for the technical assesment I have just added a button for back arrow and did set its image and used a label instead of navigation title with text "Package Search".
- When actions are triggered for three selection options i.e "Package, Hotels, Destination" the bottom view should be a container view and based on selection the relevant child viewController should be displayed. Due to time constraint and to achieve the required functionality its designed as a single view that holds all the UI elements.
- As per the design I however had a first look feedback. For instance the switch button for switching the from and to location in this case is overlapping the textfields and longer text either would be cut down or its width would be restricted in production app.
- Keeping UI/UX and design consistency as a keen area to look upon the "Star Rating" heading and its value label should have matched the left spacing as of rest of the elements. I have for now matched the design.
