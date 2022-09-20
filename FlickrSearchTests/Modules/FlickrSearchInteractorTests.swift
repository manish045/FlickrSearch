//
//  FlickrSearchInteractorTests.swift
//  FlickrSearchTests
//
//  Created by Manish Tamta on 19/09/2022.
//

import XCTest
@testable import FlickrSearch

class FlickrSearchInteractorTests: XCTestCase {
    
    var interactor: FlickrSearchInteractorMock!
    var presenter: FlickrSearchPresenterInputMock!
    
    override func setUp() {
        presenter = FlickrSearchPresenterInputMock()
        let network = NetworkClientMock()
        interactor = FlickrSearchInteractorMock(network: network)
        interactor.presenter = presenter
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        interactor = nil
        presenter = nil
    }
    
    func testLoadFlickrPhotos() {
        interactor.loadFlickrPhotos(matching: "nature", pageNum: 1)
        XCTAssertTrue(interactor.loadPhotosCalled)
        XCTAssertTrue(presenter.flickrSuccessCalled)
    }
    
    func testLoadFlickrPhotosErrorResponse() {
        interactor.loadFlickrPhotos(matching: "nature", pageNum: -1)
        XCTAssertFalse(presenter.flickrSuccessCalled)
        XCTAssertTrue(interactor.loadPhotosCalled)
    }
}

final class FlickrSearchInteractorMock: FlickrSearchInteractorInput {
    
    weak var presenter: FlickrSearchInteractorOutput?
    var loadPhotosCalled: Bool = false
    var network: NetworkRequest?
    
    init(network: NetworkRequest) {
        self.network = network
    }
    
    func loadFlickrPhotos(matching imageName: String, pageNum: Int) {
        let param = [
            "method": "flickr.photos.search",
            "format": "json",
            "nojsoncallback": 1,
            "text": imageName,
            "page": pageNum,
            "per_page": AppConstant.Constants.defaultPageSize
        ] as [String : Any]
        
        _ = network?.performRequest(endPoint: .search, parameters: param) { (result: APIResult<FlikrPhotoModel, APIError>) in
            switch result {
            case .success(let model):
                self.loadPhotosCalled = true
                self.presenter?.flickrSearchSuccess(model.photos)
            case .error(let error):
                self.loadPhotosCalled = true
                self.presenter?.flickrSearchError(error)
            }
        }
    }
}

final class FlickrSearchPresenterInputMock: FlickrSearchInteractorOutput {
    
    var flickrSuccessCalled = false
    
    func flickrSearchSuccess(_ flickrPhotos: FlickrPhotos?) {
        flickrSuccessCalled = true
        XCTAssertFalse(flickrPhotos!.photo!.isEmpty)
    }
    
    func flickrSearchError(_ error: APIError) {
        flickrSuccessCalled = false
    }
}
