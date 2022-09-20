//
//  DatabaseManager.swift
//  FlickrSearch
//
//  Created by Manish Tamta on 19/09/2022.
//

import Foundation
import RealmSwift

enum SaveType: String {
    case searchKeyword = "searchKeyword"
}

protocol DBManagerView {
    func saveSearchText(list : SearchKeywordModelList)
    func fetchSaveSearchText(_ completion: @escaping ((APIResult<SearchKeywordModelList, Error>) -> Void))
}

class DatabaseManager: DBManagerView {
    
    var type: SaveType
    var realm: Realm?
    
    init(type: SaveType) {
        self.type = type
        loadRealm()
    }
    
    func loadRealm() {
        // Open the realm with a specific file URL, for example a username
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL!.deleteLastPathComponent()
        config.fileURL!.appendPathComponent(type.rawValue)
        config.fileURL!.appendPathExtension("realm")
        realm = try! Realm(configuration: config)
    }
    
    //Save the updated or new keyword
    func saveSearchText(list : SearchKeywordModelList) {
        do {
            let storableTrendingList = list.compactMap{ ($0).toStorable() }
            try  realm?.write {
                realm?.add(storableTrendingList)
            }
        } catch let error as NSError {
            // Handle error
            print("Error saving forecast data")
            print(error)
        }
    }
    
    //Fetch saved keyword from database
    func fetchSaveSearchText(_ completion: @escaping ((APIResult<SearchKeywordModelList, Error>) -> Void)) {
        // Open the local-only default realm
        guard let searchKeywordRealm = realm else {return}

        let storableSearchKeywordList = searchKeywordRealm.objects(StorableKeywordModel.self)
        let searchKeywordList = storableSearchKeywordList.compactMap{ ($0).model }
        completion(.success(Array(searchKeywordList)))
    }
}
