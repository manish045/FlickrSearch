//
//  NetworkingTests.swift
//  FlickrSearchTests
//
//  Created by Manish Tamta on 19/09/2022.
//

import XCTest
@testable import FlickrSearch

class NetworkingTests: XCTestCase {
    
    var network: NetworkRequest!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        network = NetworkClientMock()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        network = nil
    }

    func testNetworkDataRequestSuccess() {
        let param = [
            "method": "flickr.photos.search",
            "format": "json",
            "nojsoncallback": 1,
            "text": "nature",
            "page": 1,
            "per_page": AppConstant.Constants.defaultPageSize
        ] as [String : Any]
        
        _ = network.performRequest(endPoint: .search, parameters: param) { (result: APIResult<FlikrPhotoModel, APIError>) in
            switch result {
            case .success(let model):
                XCTAssertTrue(model.photos!.photo!.count == 2)
                XCTAssertFalse(model.photos!.page == 0)
            case .error(_):
                break
            }
        }
    }
    
    func testNetworkDataRequestInvalidStatusFailure() {
        
        let param = [
            "method": "flickr.photos.search",
            "format": "json",
            "nojsoncallback": 1,
            "text": "abc",
            "page": -1,
            "per_page": AppConstant.Constants.defaultPageSize
        ] as [String : Any]
        
        _ = network.performRequest(endPoint: .search, parameters: param) { (result: APIResult<FlikrPhotoModel, APIError>) in
            switch result {
            case .success(_):
                XCTFail("Should fail with error")
            case .error(let error):
                XCTAssertTrue(error.asString == "Server is down")
            }
        }
    }
    
    func testNetworkDataRequestEmptyDataFailure() {
        let param = [
            "method": "flickr.photos.search",
            "format": "json",
            "nojsoncallback": 1,
            "text": "dfdfdf",
            "page": 1,
            "per_page": AppConstant.Constants.defaultPageSize
        ] as [String : Any]
        
        _ = network.performRequest(endPoint: .search, parameters: param) { (result: APIResult<FlikrPhotoModel, APIError>) in
            switch result {
            case .success(_):
                XCTFail("Should fail with error")
            case .error(let error):
                XCTAssertTrue(error.asString == "Empty response from the server")
            }
        }
    }
}
