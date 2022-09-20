//
//  SearchKeyword.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 19/09/2022.
//

import Foundation
import RealmSwift

typealias SearchKeywordModelList = [SearchKeywordModel]

struct SearchKeywordModel {
    var keyword: String
}

extension SearchKeywordModel: Entity {

    private var storableResponseModel: StorableKeywordModel {
        let realmTrendingGIF = StorableKeywordModel()
        realmTrendingGIF.keyword = keyword
        return realmTrendingGIF
    }
    
    func toStorable() -> StorableKeywordModel {
        return storableResponseModel
    }
}


class StorableKeywordModel: Object, Storable {
    
    @Persisted var keyword: String
    @Persisted var uuid: String = ""
    
    var model: SearchKeywordModel {
        get {
            return SearchKeywordModel(keyword: keyword)
        }
    }
}

public protocol Entity {
    associatedtype StoreType: Storable
    
    func toStorable() -> StoreType
}

public protocol Storable {
    associatedtype EntityObject: Entity
    
    var model: EntityObject { get }
    var uuid: String { get }
}
