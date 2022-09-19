//
//  FlickrSearchPresenter.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import Foundation

final class FlickrSearchPresenter: FlickrSearchModuleInput, FlickrSearchViewOutput, FlickrSearchInteractorOutput {
   
    var numberOfRowsInPhotoSection: Int = 0
    var photoArray: FlickrPhotoList = FlickrPhotoList() {
        didSet {
            self.numberOfRowsInPhotoSection = photoArray.count
        }
    }

    
    weak var view: FlickrSearchViewInput?
    var interactor: FlickrSearchInteractorInput
    var router: FlickrSearchRouterInput
    
    init(interactor: FlickrSearchInteractorInput,
         router: FlickrSearchRouterInput) {
        
        self.interactor = interactor
        self.router = router
    }
}
