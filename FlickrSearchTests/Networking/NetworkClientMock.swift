//
//  NetworkClientMock.swift
//  FlickrSearchTests
//
//  Created by Manish Tamta on 19/09/2022.
//

import XCTest
import UIKit
@testable import FlickrSearch

final class NetworkClientMock: NetworkRequest {
    
    func performRequest<T>(endPoint: EndPoints, parameters: [String : Any], completion: @escaping (APIResult<T, APIError>) -> Void) where T : BaseModel {
        
        let params = parameters
        let text = params["text"] as! String
        let page = params["page"] as! Int
        
        if (text == "nature") && (page == 1) {
            guard let pathString = Bundle(for: type(of: self)).path(forResource: "TestData", ofType: "json") else {
                fatalError("json not found")
            }
            
            guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
                fatalError("unable to convert json into string")
            }
            
            let jsonData = json.data(using: .utf8)!
            let model = try! JSONDecoder().decode(FlikrPhotoModel.self, from: jsonData)
            completion(.success(model as! T))
        }else if (text == "nature") && (page == -1) {
            completion(.error(.serverError("Server is down")))
        } else if (text == "dfdfdf") && (page == -1) {
            completion(.error(.somethingWrong))
        }
    }
}
