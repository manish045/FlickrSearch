//
//  FlickrSearchProtocols.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import Foundation
import UIKit

//MARK: BaseViewInput

protocol BaseViewInput: AnyObject {
    func showSpinner()
    func hideSpinner()
}

extension BaseViewInput where Self: UIViewController {
    func showSpinner() {
        view.showSpinner()
    }
    
    func hideSpinner() {
        view.hideSpinner()
    }
}


//MARK: View
protocol FlickrSearchViewInput: BaseViewInput {
    var presenter: FlickrSearchViewOutput! { get set }
    func changeViewState(_ state: ViewState)
    func displayFlickrSearchImages()
    func insertFlickrSearchImages(at indexPaths: [IndexPath])
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
    var paginationIndex: Int { get }
    var isEmpty: Bool {get}
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

