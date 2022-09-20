//
//  APIService+URL.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 19/09/2022.
//

import Foundation
import Alamofire

enum APIEnvironment {
    case staging
    case production
    
    var baseURL: String {
        switch self {
        case .staging:
            return AppConstant.APIConstants.flickrAPIBaseURL
        case .production:
            return ""
        }
    }
}

enum EndPoints {
    case search
    
    var url: String {
        switch self {
        case .search:
            return "/services/rest/"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
}

extension APIFlickrService {
    struct URLString {
        private static let environment = APIEnvironment.staging
        static var base: String { environment.baseURL }
    }
    
    static func URL(_ endPoint: EndPoints) -> String {
        return URLString.base + endPoint.url
    }
}

