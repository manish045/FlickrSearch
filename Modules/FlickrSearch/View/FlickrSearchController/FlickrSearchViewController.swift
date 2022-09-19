//
//  FlickrSearchViewController.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import UIKit

class FlickrSearchViewController: UIViewController, FlickrSearchViewInput {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        // Do any additional setup after loading the view.

        setUpNavigation()
        configureSearchController()
        configureCollectionView()
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
    
    //MARK: ConfigureCollectionView
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = createLayout()
        self.collectionView.registerNibCell(ofType: FlickrImageCollectionViewCell.self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    //MARK: CreateSection
    private enum FlickrSearchSection: Int, CaseIterable {
        case flickrImage
    }
    
    //MARK: CollectionView Cell Layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                heightDimension: .fractionalWidth(0.5)))
            item.contentInsets.bottom = 16
            item.contentInsets.trailing = 16
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                             heightDimension: .estimated(100)),
                                                                            subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 32, leading: 16, bottom: 0, trailing: 0)
            return section
        }
    }
    
    func displayFlickrSearchImages() {
        self.collectionView.reloadData()
    }
}

extension FlickrSearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension FlickrSearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return FlickrSearchSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRowsInPhotoSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(FlickrImageCollectionViewCell.self, indexPath: indexPath)
        cell.model = presenter.photoArray[indexPath.row]
        return cell
    }
}

extension FlickrSearchViewController: FlickrSearchEventDelegate {
    
    /// Search for text from searchBar in API
    func didTapSearchBar(withText searchText: String) {
        // hides active search on controller
        searchController.isActive = false
        presenter.clearData()

        searchController.searchBar.text = searchText
        presenter.searchFlickrPhotos(matching: searchText)
    }
}
