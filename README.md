# FlickrSearch


Minimum Requirement:-

Xcode Version 13.2.1 or above
Minimum iOS version 14.0
To Run project:-

Clone the repository
Open the folder FlickrSearch
Navigate to FlickrSearch.xcodeproj
Open FlickrSearch.xcodeproj using XCode
Run the project and search for any keyword like "kittens".

Architecture

This Application is based on VIPER architecture for clean separation of different layers.
VIPER is a design pattern mostly used on the development of iOS applications. 
It’s an alternative to other design patterns like MVC or MVVM and offers a good layer of abstraction resulting in a more scalable and testable code. 


Networking

This application use Alamofire based API


UnitTests

This module consists XCTTest classes for testing.


Swift Package Manager

Alamofire(v 4.9.1), SDWebImage, RealmSwift has been installed using swift package manager. In case of missing package dependency in Xcode project, go to File > Packages > Reset Package Caches wait for it to be finished. Once done clean the build and run the app.
