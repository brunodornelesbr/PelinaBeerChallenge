//
//  FavoritesNetwork.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 02/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit

class FavoritesNetwork: MoviesNetwork {
    func resetMovies() {
        didGetMovies = false
    }
    
    var favoriteManager : FavoriteManager
    var didGetMovies = false
    init(favoriteManager : FavoriteManager) {
        self.favoriteManager = favoriteManager
    }
    
    func getMovies(completionHandler: @escaping ([Movie], Error?) -> ()) {
        if didGetMovies {
            completionHandler([],nil)
        } else {
            completionHandler(favoriteManager.listOfFavorites,nil)
            didGetMovies = true
        }
        return
    }
}
