//
//  FlickrSearchModuleBuilder.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import UIKit


protocol FlickrModuleBuilder: AnyObject {
    func buildModule() -> FlickrSearchViewController
}


final class FlickrSearchModuleBuilder: FlickrModuleBuilder {
    
    // Create an instance for view controller and all related dependencies
    func buildModule() -> FlickrSearchViewController {
        let flickrViewController = FlickrSearchViewController()
        let presenter = FlickrSearchPresenter()
        let interactor = FlickrSearchIneractor()
        let router = FlickrSearchRouter()
        
        presenter.view = flickrViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        flickrViewController.presenter = presenter
        router.viewController = flickrViewController
        
        return flickrViewController
    }
}
