//
//  SearchViewController.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import UIKit

protocol FlickrSearchEventDelegate: AnyObject {

}

final class SearchViewController: UIViewController, UISearchBarDelegate {
    
    weak var searchDelegate: FlickrSearchEventDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchBar.resignFirstResponder()
    }
}

extension SearchViewController: FlickrSearchEventDelegate {
    
}
