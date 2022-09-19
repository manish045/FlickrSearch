//
//  FlickrServiceUtil.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 19/09/2022.
//

import Foundation

enum KeyString: String {
    case publicKey
}


struct MSUtils {
    
    func buildServiceRequestUrl(baseUrl: String) -> String? {
        if var urlComponents = URLComponents(string: baseUrl) {
            
            guard let publicKey = getAPIKeys()[KeyString.publicKey.rawValue] as? String else {return nil}
            
            //addd auth params
            var requestParams = [String : String]()
            requestParams["apikey"] = publicKey
            
            //build query string
            var queryItems = [URLQueryItem]()
            for (key, value) in requestParams {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            
            urlComponents.queryItems = queryItems
            
            if let urlAbsoluteString = urlComponents.url?.absoluteString {
                return urlAbsoluteString
            }
        }
        
        return nil
    }

    //MARK:- Get Keys from Flickr Plist file
    func getAPIKeys() -> [String: Any] {
        if let path = Bundle.main.path(forResource: "FlickrPlist", ofType: "plist") {
            let plist = NSDictionary(contentsOfFile: path) ?? ["":""]
            let publicKey = plist[KeyString.publicKey.rawValue] as! String
            let dict = [KeyString.publicKey.rawValue: publicKey]
            return dict
            
        }
        return ["": ""]
    }
}
