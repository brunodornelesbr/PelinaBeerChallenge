//
//  DetailMovieViewModel.swift
//  TheMovieDBKobe
//
//  Created by Bruno Dorneles on 15/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class DetailMovieViewModel {
    var movie = BehaviorRelay<Movie>(value : Movie())
    var favoriteManager : FavoriteManager
    var isFavorite = BehaviorRelay<Bool>(value: false)
    init(movie : Movie,favoriteManager : FavoriteManager) {
        self.movie.accept(movie)
        self.favoriteManager = favoriteManager
        updateFavorite()
    }
    func updateFavorite() {
        isFavorite.accept(favoriteManager.isThisFavorite(movie: movie.value))
    }
    
    func checkIfIsFavorite(movie : Movie) -> Bool{
        return favoriteManager.isThisFavorite(movie: movie)
    }
    
    func didToggleFavorite(){
        self.favoriteManager.toggleFavorite(movie: movie.value)
        updateFavorite()
    }
}
