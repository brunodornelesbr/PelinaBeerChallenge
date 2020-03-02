//
//  Favorite.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit
import ObjectMapper
class FavoriteManager {
    var listOfFavorites : [Movie] = []
    var storageManager : FavoriteStorageManagerProtocol
    init(storageManager : FavoriteStorageManagerProtocol) {
        self.storageManager = storageManager
        loadFavorites()
    }
    func loadFavorites() {
          listOfFavorites = storageManager.getListOfFavorites()
    }
    
   private func updateListOfFavoritesWithFavoritesList() {
    storageManager.updateListOfFavorites(movies: listOfFavorites)
    }
    
    func isThisFavorite(movie : Movie) -> Bool {
        return listOfFavorites.firstIndex(of: movie) != nil
    }
    
    func toggleFavorite(movie : Movie) {
        if let index = listOfFavorites.firstIndex(of: movie){
            listOfFavorites.remove(at: index)
        } else {
            listOfFavorites.append(movie)
        }
        updateListOfFavoritesWithFavoritesList()
    }
}
