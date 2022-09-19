//
//  SearchViewController.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//  Created by Manish Tamta on 19/09/2022.
//

import UIKit

protocol FlickrSearchEventDelegate: AnyObject {
    func didTapSearchBar(withText searchText: String)
}

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    weak var searchDelegate: FlickrSearchEventDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    var savedList = SearchKeywordModelList() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
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
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadKeywords()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /// Hides keyboard on pressing cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        
        searchBar.text = text
        searchBar.resignFirstResponder()
        searchDelegate?.didTapSearchBar(withText: text)
        saveKeyword(text: text)
    }
    
    private func saveKeyword(text: String) {
        let model = SearchKeywordModel(keyword: text)
        databaseManager.saveSearchText(list: [model])
    }
    
    private func loadKeywords() {
        databaseManager.fetchSaveSearchText { [weak self] result in
            switch result {
            case .success(let model):
                guard let self = self else {return}
                self.savedList = model
            case .error(_):
                break
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = savedList[indexPath.row].keyword
        searchDelegate?.didTapSearchBar(withText: text)
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = savedList[indexPath.row].keyword
        cell.textLabel?.textColor = .white
        return cell
    }
}
