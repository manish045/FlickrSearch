//
//  FlickrSearchPresenterTests.swift
//  FlickrSearchTests
//
//  Created by Manish Tamta on 19/09/2022.
//

import XCTest
@testable import FlickrSearch

class FlickrSearchPresenterTests: XCTestCase {
    
    var interactor: FlickrSearchInteractorMock!
    var presenter: FlickrSearchPresenterMock!
    var view: FlickrSearchViewControllerMock!
    var router: FlickrSearchRouterInput!
    var network: NetworkRequest!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        router = FlickrSearchRouterMock()
        network = NetworkClientMock()
        interactor = FlickrSearchInteractorMock(network: network)
        presenter = FlickrSearchPresenterMock(router: router,
                                              interactor: interactor)

        interactor.presenter = presenter
        view = FlickrSearchViewControllerMock(presenter: presenter)
        
        presenter.view = view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        view = nil
        interactor = nil
        network = nil
    }
    
    func testSearchMethodCall() {
        presenter.searchFlickrPhotos(matching: "nature")
        XCTAssertTrue(presenter.flickrSearchSuccess)
        XCTAssertNotNil(presenter.photoArray)
        XCTAssertTrue(presenter.numberOfRowsInPhotoSection == 2)
        XCTAssertTrue(presenter.paginationIndex == 1)
    }
    
    func testDidSelectPhotoCall() {
        presenter.didSelectPhoto(at: 0)
        XCTAssertTrue(presenter.selectedPhoto)
    }
}

final class FlickrSearchPresenterMock: FlickrSearchModuleInput, FlickrSearchViewOutput, FlickrSearchInteractorOutput {
    
    weak var view: FlickrSearchViewInput?
    var router: FlickrSearchRouterInput
    var interactor: FlickrSearchInteractorInput

    var numberOfRowsInPhotoSection: Int = 0
    var paginationIndex: Int = 0
    var isEmpty: Bool = true
    var photoArray: FlickrPhotoList = [] {
        didSet {
            numberOfRowsInPhotoSection = photoArray.count
            paginationIndex = photoArray.count - 1
            isEmpty = photoArray.isEmpty
        }
    }

    
    var isMoreDataAvailable: Bool { return true }
    var flickrSearchSuccess = false
    var selectedPhoto = false
    
    init(router: FlickrSearchRouterInput,
         interactor: FlickrSearchInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    func searchFlickrPhotos(matching imageName: String) {
        interactor.loadFlickrPhotos(matching: imageName, pageNum: 1)
    }
    
    func flickrSearchSuccess(_ flickrPhotos: FlickrPhotos?) {
        flickrSearchSuccess = true
        XCTAssertFalse(flickrPhotos!.photo!.isEmpty)
        let flickrPhotoList = buildFlickrPhotoUrlList(from: flickrPhotos?.photo ?? [])
        photoArray = flickrPhotoList
    }
    
    func flickrSearchError(_ error: APIError) {
        flickrSearchSuccess = false
    }
    
    func clearData() {}
    
    //MARK: FlickrImageURLList
    func buildFlickrPhotoUrlList(from photos: FlickrPhotoList) -> FlickrPhotoList {
        let flickrPhotoUrlList = photos.filter({$0.url?.isEmpty == false})
        return flickrPhotoUrlList
    }
    
    func didSelectPhoto(at index: Int) {
        selectedPhoto = true
    }
}


final class FlickrSearchViewControllerMock: UIViewController, FlickrSearchViewInput {
    
    var presenter: FlickrSearchViewOutput!
    var showFlickrImages = false
    
    init(presenter: FlickrSearchViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeViewState(_ state: ViewState) {}
    
    func displayFlickrSearchImages() {
        showFlickrImages = true
    }
    
    func insertFlickrSearchImages(at indexPaths: [IndexPath]) {}
}


final class FlickrSearchRouterMock: FlickrSearchRouterInput {
    
    weak var viewController: UIViewController?
    var showFlickrPhotoDetailsCalled = false
    
    func showFlickrPhotoDetails(with imageUrl: URL) {
        showFlickrPhotoDetailsCalled = true
    }
}
