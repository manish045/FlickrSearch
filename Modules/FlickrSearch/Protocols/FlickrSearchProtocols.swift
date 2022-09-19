//
//  FlickrSearchProtocols.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import Foundation
import UIKit


//MARK: View
protocol FlickrSearchViewInput: AnyObject {
    var presenter: FlickrSearchViewOutput! { get set }
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
}

protocol FlickrSearchInteractorOutput: AnyObject  {

}


//MARK: InteractorInput
protocol FlickrSearchInteractorInput: AnyObject {
    var presenter: FlickrSearchInteractorOutput? { get set }
}

//MARK: Router
protocol FlickrSearchRouterInput: AnyObject {

}

