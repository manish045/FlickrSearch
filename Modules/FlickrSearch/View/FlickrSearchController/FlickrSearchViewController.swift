//
//  FlickrSearchViewController.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import UIKit

//MARK: ViewState
public enum ViewState: Equatable {
    case none
    case loading
    case error(String)
    case content
}

class FlickrSearchViewController: UIViewController, FlickrSearchViewInput, AlertsPresenting {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: FlickrSearchViewOutput!
    var viewState: ViewState = .none
    
    private var searchText = ""
    
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
        self.collectionView.registerNibCell(ofType: FooterCollectionViewCell.self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    //MARK: CreateSection
    private enum FlickrSearchSection: Int, CaseIterable {
        case flickrImage
        case loader
    }
    
    //MARK: CollectionView Cell Layout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch FlickrSearchSection(rawValue: sectionNumber) {
            case .flickrImage:
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
                
            default:
                let height:CGFloat = 50
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                    heightDimension: .fractionalHeight(1)))
                item.contentInsets.bottom = 0
                item.contentInsets.trailing = 0
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .estimated(height)),
                                                                                subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 8, leading: 8, bottom: 0, trailing: 0)
                return section
            }
        }
    }
    
    func displayFlickrSearchImages() {
        self.collectionView.reloadData()
    }
    
    func insertFlickrSearchImages(at indexPaths: [IndexPath]) {
        collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: indexPaths)
        })
    }
    
    /// Manage change in app state while performing api.
    func changeViewState(_ state: ViewState) {
        viewState = state
        switch state {
        case .loading:
            if presenter.isEmpty {
                showSpinner()
            }else{
                let indexSet = IndexSet(integer: FlickrSearchSection.loader.rawValue)
                self.collectionView.reloadSections(indexSet)
            }
        case .content:
            hideSpinner()
        case .error(let message):
            hideSpinner()
            showAlert(title: AppConstant.Strings.error, message: message, retryAction: { [unowned self] in
                self.presenter.searchFlickrPhotos(matching: self.searchText)
            })
        default:
            break
        }
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
        switch FlickrSearchSection(rawValue: section) {
        case .flickrImage:
            return presenter.numberOfRowsInPhotoSection
        default:
            return (self.viewState == .loading && !self.presenter.isEmpty) ? 1 : 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch FlickrSearchSection(rawValue: indexPath.section) {
        case .flickrImage:
            let cell = collectionView.dequeueCell(FlickrImageCollectionViewCell.self, indexPath: indexPath)
            cell.model = presenter.photoArray[indexPath.row]
            return cell
        default:
            let cell = collectionView.dequeueCell(FooterCollectionViewCell.self, indexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard viewState != .loading, indexPath.row == presenter.paginationIndex else {
            return
        }
        presenter.searchFlickrPhotos(matching: searchText)
    }
}

extension FlickrSearchViewController: FlickrSearchEventDelegate {
    
    /// Search for text from searchBar in API
    func didTapSearchBar(withText searchText: String) {
        // hides active search on controller
        searchController.isActive = false
        guard !searchText.isEmpty || searchText != self.searchText else { return }
        presenter.clearData()

        self.searchText = searchText
        searchController.searchBar.text = searchText
        presenter.searchFlickrPhotos(matching: searchText)
    }
}
