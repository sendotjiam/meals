### Overview
This project contains MVVM Pattern that wrapped in Clean Architecture which divides the application structures into Data, Domain, and Features/Presentation layer. The goals of this multilayer structure are actually to make the code supports separation of concerns and single responsibility of its object.

### Dependencies
All dependencies are being managed by using CocoaPods.
1. RxSwift as a reactive programming tool for this application. The purpose of using RxSwift is actually to help the code to be more optimal when carrying out the data binding process.
2. SnapKit for programmatically autolayout.
3. XCTest as iOS native unit test framework.  
4. Alamofire for HTTP networking to Meal API (https://www.themealdb.com/api.php).
5. Kingfisher for downloading and caching images from the web.

### Run the projects
1. Clone the project from the repository.
2. Run 'pod install' command in terminal to integrate the project with all dependencies.
3. Open .xcworkspace file.
4. Choose the 'Meals' scheme and simulator.
5. Run the project.

### Run the tests
1. Open .xcworkspace file.
2. Choose the 'MealsTests' scheme and simulator.
3. Run the test.

### Brief Infos
* You can try pinching and zooming the image after tapping the image view on the Meal Detail page.

### Clean Architecture Layers
1. Data layer
    - NetworkService: contains ApiClient
    - CoreDataService: service for handle CoreData operations
    - Repositories: as a bridge to ApiClient for Networking
    - Models: contains response models from API
2. Domain layer
    - UseCases: single responsibility object that contains business logic to parse object from Data model to Domain model and as a bridge from Data layer to Presentation layer.
    - Models: domain model for View
3. Presentation layer:
    - View: user interface
    - ViewModel: view logic and binding
    - Wireframe: use by view controller as a tool for some navigations

### Thankyou for your time.
