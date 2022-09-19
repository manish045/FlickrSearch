//
//  FlickrPhotosModel.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 18/09/2022.
//

import Foundation

typealias FlickrPhotoList = [FlickrPhoto]

// MARK: - FlikrPhotoModel
struct FlikrPhotoModel: Decodable {
    let photos: FlickrPhotos?
    let stat: String
}

struct FlickrPhotos: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: FlickrPhotoList
    
    enum CodingKeys: String, CodingKey {
        case photos
    }
    
    // The keys inside of the "FlickrPhotosKeys" object
    enum FlickrPhotosKeys: String, CodingKey {
        case page
        case pages
        case perpage
        case total
        case photo
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        // Extract the photos object as a nested container
        let photos = try values.nestedContainer(keyedBy: FlickrPhotosKeys.self, forKey: .photos)

        self.page = try photos.decode(Int.self, forKey: .page)
        self.pages = try photos.decode(Int.self, forKey: .pages)
        self.perpage = try photos.decode(Int.self, forKey: .perpage)
        self.total = try photos.decode(String.self, forKey: .total)
        self.photo = try photos.decode([FlickrPhoto].self, forKey: .photo)
    }
}

struct FlickrPhoto: Decodable {
    let farm: Int
    let id: String
    let owner: String
    let secret: String
    let server: String
    let title: String
}
