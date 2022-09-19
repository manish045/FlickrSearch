//
//  AppConstant.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import Foundation

import UIKit

struct AppConstant {
    
    //MARK: String Constants
    enum Strings {
        static let flickrSearchTitle = "Flickr Search"
        static let placeholder = "Search Flickr images..."
    }
    
    //MARK: NetworkAPI Constants
    enum APIConstants {
        static let flickrAPIBaseURL = "https://api.flickr.com"
    }
    
    //MARK: Numeric Constants
    enum Constants {
        static let defaultPageNum: Int = 0
        static let defaultTotalCount: Int = 0
        static let defaultPageSize: Int = 20
    }
}


