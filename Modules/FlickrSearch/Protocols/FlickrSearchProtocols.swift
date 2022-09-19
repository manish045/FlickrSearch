//
//  FlickrSearchProtocols.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import Foundation


//MARK: View
protocol FlickrSearchViewInput: AnyObject {
    var presenter: FlickrSearchViewOutput! { get set }
    func displayFlickrSearchImages()
}

//MARK: Presenter
protocol FlickrSearchModuleInput: AnyObject {
    var view: FlickrSearchViewInput? { get set }
    var interactor: FlickrSearchInteractorInput { get }
    var router: FlickrSearchRouterInput { get }
}

protocol FlickrSearchViewOutput: AnyObject {
    
    var photoArray: FlickrPhotoList {get}
    var numberOfRowsInPhotoSection: Int {get}
    func searchFlickrPhotos(matching imageName: String)
    func clearData()
    var isMoreDataAvailable: Bool { get }
}

protocol FlickrSearchInteractorOutput: AnyObject  {
    func flickrSearchSuccess(_ flickrPhotos: FlickrPhotos?)
    func flickrSearchError(_ error: APIError)
}


//MARK: InteractorInput
protocol FlickrSearchInteractorInput: AnyObject {
    var presenter: FlickrSearchInteractorOutput? { get set }
    func loadFlickrPhotos(matching imageName: String, pageNum: Int)
}

//MARK: Router
protocol FlickrSearchRouterInput: AnyObject {

}

