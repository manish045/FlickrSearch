//
//  FlickrSearchViewController.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import UIKit

class FlickrSearchViewController: UIViewController, FlickrSearchViewInput {
   
    var presenter: FlickrSearchViewOutput!

    lazy var searchController: UISearchController = {
        let searchVC = SearchViewController()
        searchVC.searchDelegate = self
        let controller = UISearchController(searchResultsController: searchVC)
        controller.obscuresBackgroundDuringPresentation = true
        controller.searchResultsUpdater = nil
        controller.searchBar.placeholder = AppConstant.Strings.placeholder
        controller.searchBar.delegate = searchVC
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        configureSearchController()
        // Do any additional setup after loading the view.
    }
    
    private func setUpNavigation() {
        title = AppConstant.Strings.flickrSearchTitle
    }
    
    // MARK: configureSearchController
    private func configureSearchController() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension FlickrSearchViewController: FlickrSearchEventDelegate {
    
}
