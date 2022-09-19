//
//  FlickrSearchPresenter.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import Foundation

final class FlickrSearchPresenter: FlickrSearchModuleInput, FlickrSearchViewOutput {
   
    var numberOfRowsInPhotoSection: Int = 0
    var photoArray: FlickrPhotoList = FlickrPhotoList() {
        didSet {
            self.numberOfRowsInPhotoSection = photoArray.count
        }
    }

    var pageNum = AppConstant.Constants.defaultPageNum
    var totalCount = AppConstant.Constants.defaultTotalCount
    var totalPages = AppConstant.Constants.defaultPageNum
    
    //Check if more data is available for search request
    var isMoreDataAvailable: Bool {
        guard totalPages != 0 else {
            return true
        }
        return pageNum < totalPages
    }
    
    weak var view: FlickrSearchViewInput?
    var interactor: FlickrSearchInteractorInput
    var router: FlickrSearchRouterInput
    
    init(interactor: FlickrSearchInteractorInput,
         router: FlickrSearchRouterInput) {
        
        self.interactor = interactor
        self.router = router
    }
    
    func searchFlickrPhotos(matching imageName: String) {
        interactor.loadFlickrPhotos(matching: imageName, pageNum: 0)
    }
    
    //Reset all data when new item is searched
    func clearData() {
        pageNum = AppConstant.Constants.defaultPageNum
        totalCount = AppConstant.Constants.defaultTotalCount
        totalPages = AppConstant.Constants.defaultTotalCount
    }
}

extension FlickrSearchPresenter: FlickrSearchInteractorOutput {
    
    ///  Success response from API Search
    func flickrSearchSuccess(_ flickrPhotos: FlickrPhotos?) {
        guard let flickrPhotos = flickrPhotos else {return}

        if totalCount == AppConstant.Constants.defaultTotalCount {
            totalCount = flickrPhotos.photo?.count ?? 0
            totalPages = flickrPhotos.pages ?? 0
            self.photoArray = flickrPhotos.photo ?? []

            DispatchQueue.main.async { [unowned self] in
                self.view?.displayFlickrSearchImages()
            }
        } else {
            insertMoreFlickrPhotos(with: flickrPhotos.photo ?? [])
        }
    }
    
    /// Failure response from API search
    func flickrSearchError(_ error: APIError) {
    
    }
    
    //MARK: Photo Seach Success
    fileprivate func insertMoreFlickrPhotos(with flickrPhotosList: FlickrPhotoList) {
        totalCount += flickrPhotosList.count
        self.photoArray = flickrPhotosList
    }
}
