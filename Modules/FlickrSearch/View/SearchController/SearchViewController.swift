//
//  SearchViewController.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import UIKit

protocol FlickrSearchEventDelegate: AnyObject {
    func didTapSearchBar(withText searchText: String)
}

final class SearchViewController: UIViewController, UISearchBarDelegate {
    
    weak var searchDelegate: FlickrSearchEventDelegate?
    private var databaseManager: DBManagerView
    
    init(databaseManager: DBManagerView = DatabaseManager(type: .searchKeyword)) {
        self.databaseManager = databaseManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        searchBar.text = text
        searchBar.resignFirstResponder()
        searchDelegate?.didTapSearchBar(withText: text)
        saveKeyword(text: text)
    }
    
    private func saveKeyword(text: String) {
        let model = SearchKeywordModel(keyword: text)
        databaseManager.saveSearchText(list: [model])
    }
}
