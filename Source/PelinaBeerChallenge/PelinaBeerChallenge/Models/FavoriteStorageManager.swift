//
//  FavoriteStorageManager.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 02/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit


protocol FavoriteStorageManagerProtocol {
     func getListOfFavorites()-> [Movie]
     func updateListOfFavorites(movies : [Movie])
}
class FavoriteStorageManagerImpl : FavoriteStorageManagerProtocol {
    func getListOfFavorites()-> [Movie] {
        if let data = UserDefaults.standard.data(forKey: "Favorite"){
            return (try? JSONDecoder().decode([Movie].self, from: data)) ?? []
        }
        return []
    }
    func updateListOfFavorites(movies : [Movie]) {
        guard let placesData = try? JSONEncoder().encode(movies) else { return }
        UserDefaults.standard.set(placesData, forKey: "Favorite")
    }
}
