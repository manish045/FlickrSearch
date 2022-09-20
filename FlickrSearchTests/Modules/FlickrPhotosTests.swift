//
//  FlickrPhotosTests.swift
//  FlickrSearchTests
//
//  Created by Manish Tamta on 19/09/2022.
//

import XCTest
@testable import FlickrSearch

class FlickrPhotosTests: XCTestCase {
    
    var flickrPhotos: FlickrPhotos!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        flickrPhotos = TestUtil().getFlickrPhotos()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        flickrPhotos = nil
    }

    //MARK: Test sample response mapping to FlickrPhotos
    func testFlickrPhotosJSONDecoder() {
        XCTAssertNotNil(flickrPhotos)
        XCTAssertFalse(flickrPhotos.photo!.isEmpty)
        XCTAssertTrue(flickrPhotos.photo!.count == 2)
        XCTAssertTrue(flickrPhotos.page == 1)
        XCTAssertTrue(flickrPhotos.total == 2)
        XCTAssertTrue(flickrPhotos.perpage == 20)
    }
    
    func testFlickrPhotoEntity() {
        XCTAssertNotNil(flickrPhotos)
        XCTAssertFalse(flickrPhotos.photo!.isEmpty)
        
        let photo = flickrPhotos.photo![0]
        XCTAssertTrue(photo.id == "12345")
        XCTAssertEqual(photo.title, "test image title")
        XCTAssertTrue(photo.farm == 2)
    }
}
