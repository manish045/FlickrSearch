//
//  FlickrSearchViewControllerTests.swift
//  FlickrSearchTests
//
//  Created by Manish Tamta on 19/09/2022.
//

import XCTest
@testable import FlickrSearch

class FlickrSearchViewControllerTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func testControllerIBConnections() throws {
        let sut = try makeSUT()
        XCTAssertNotNil(sut.collectionView)
    }
    
    //MARK: Test the datasource before request to server
    func testEmptyValueInDataSourceBeforeLoadingDataFromServer() throws {
        
        let sut = try makeSUT()
        let collectionView = sut.collectionView
        // expected one section
        XCTAssertEqual(collectionView?.numberOfSections, 2, "Expected two section in collection view")
        
        // expected zero cells
        XCTAssertEqual(collectionView?.numberOfItems(inSection: 0), 0)
        
        // expected one cells
        XCTAssertEqual(collectionView?.numberOfItems(inSection: 1), 0)
    }
    
    //MARK: Test the datasource after request to server
    func testValueInDataSourceWhenLoadingDataFromServer() throws {
        
        let sut = try makeSUT()
        let collectionView = sut.collectionView
        
        sut.presenter.searchFlickrPhotos(matching: "nature")
                
        // expected one section
        XCTAssertEqual(collectionView?.numberOfSections, 2, "Expected two section in collection view")
        
        // expected zero cells
        XCTAssertEqual(collectionView?.numberOfItems(inSection: 0), 2)
        
        // expected one cells
        XCTAssertEqual(collectionView?.numberOfItems(inSection: 1), 0)
    }
    
    
    private func makeSUT() throws -> FlickrSearchViewController {
        let router = FlickrSearchRouterMock()
        let network = NetworkClientMock()
        let interactor = FlickrSearchInteractorMock(network: network)
        let presenter = FlickrSearchPresenterMock(router: router,
                                              interactor: interactor)

        interactor.presenter = presenter
        let view = FlickrSearchViewController()
        
        presenter.view = view
        view.presenter = presenter
        _ = view.view
        return view
    }
}
