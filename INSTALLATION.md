## Pre-requisites
* Apple Computer
* Xcode 10+
* Swift 4
* Device with iOS 8.0+
* Active Apple ID
## Dependencies
All dependencies have been listed in the [Podfile](Podfile). To download and install these packages, run `pod install` from the root of this repository.

## Build/Install Instructions
Xcode is a fully integrated IDE for iOS applications. Thus, simply clone this repo, install dependencies, open the `.workspace` file and then:
* Select deployment target (which iOS device you want to run on)
* Click the play/run button (or click `Product>Run` from the status bar)

## Run Instructions
Click the application icon that has appeared on the device.

## Troubleshooting
* Failure to set up dependencies:
    * Make sure that you are in the root of the project when running the pod command
    * Make sure that you have an active internet connection, as this step downloads packages from the internet
* Failure to build:
    * Make sure that you have opened the `.workspace` file instead of the project file, as this is the file that will source dependencies correctly
    * Make sure that the compiler target is set to Swift 4
* Failure to install:
    * Make sure that the provisioning profile in the project settings is set correctly with your Apple ID
    * Make sure that the target device is running iOS 11.1 or greater
