//
//  FlickrPhotosModel.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import Foundation

typealias FlickrPhotoList = [FlickrPhoto]

// MARK: - FlikrPhotoModel
struct FlikrPhotoModel: BaseModel {
    let photos: FlickrPhotos?
    let stat: String
}

struct FlickrPhotos: BaseModel {
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: String?
    let photo: FlickrPhotoList?
}

struct FlickrPhoto: BaseModel {
    let farm: Int?
    let id: String
    let owner: String?
    let secret: String?
    let server: String?
    let title: String?
}
