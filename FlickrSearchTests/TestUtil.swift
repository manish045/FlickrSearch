//
//  TestUtil.swift
//  FlickrSearchTests
//
//  Created by Manish Tamta on 19/09/2022.
//

import XCTest
@testable import FlickrSearch

class TestUtil {
     func getFlickrPhotos() -> FlickrPhotos {
         guard let pathString = Bundle(for: type(of: self)).path(forResource: "TestData", ofType: "json") else {
             fatalError("json not found")
         }
         
         guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
             fatalError("unable to convert json into string")
         }
         
         let jsonData = json.data(using: .utf8)!
         let model = try! JSONDecoder().decode(FlikrPhotoModel.self, from: jsonData)
         return model.photos!
    }
}
