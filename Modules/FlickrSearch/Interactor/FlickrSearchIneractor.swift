//
//  FlickrSearchIneractor.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import Foundation

class FlickrSearchIneractor: FlickrSearchInteractorInput {
    
    weak var presenter: FlickrSearchInteractorOutput?
    var network: PerformRequest
    
    init(network: PerformRequest = APIFlickrService()) {
        self.network = network
    }
    
    //MARK: Load Flickr images for searched text from the network
    func loadFlickrPhotos(matching imageName: String, pageNum: Int) {
        let param = [
            "method": "flickr.photos.search",
            "format": "json",
            "nojsoncallback": 1,
            "text": imageName,
            "page": pageNum,
            "per_page": AppConstant.Constants.defaultPageSize
        ] as [String : Any]
        
        self.network.performRequest(endPoint: .search, parameters: param) { [weak self] (result: APIResult<FlikrPhotoModel, APIError>) in
            switch result {
            case .success(let model):
                guard let self = self else {return}
                self.presenter?.flickrSearchSuccess(model.photos)
            case .error(let error):
                guard let self = self else {return}
                self.presenter?.flickrSearchError(error)
                break
            }
        }
    }
}
