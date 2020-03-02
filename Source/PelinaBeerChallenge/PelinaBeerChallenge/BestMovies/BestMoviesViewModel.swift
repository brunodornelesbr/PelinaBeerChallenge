//
//  BestMoviesViewModel.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class BestMoviesViewModel: NSObject {
    private var availableMovies = BehaviorRelay<[Movie]>(value : [])
    private var requesting = BehaviorRelay<Bool>(value: false)
    var movies : Observable<[Movie]> {return availableMovies.asObservable()}
    var network : MoviesNetwork
    var favoriteManager : FavoriteManager
    init(network : MoviesNetwork,favoriteManager : FavoriteManager) {
        self.network = network
        self.favoriteManager = favoriteManager
        super.init()
    }
    
    func getUpcomingMovies(){
        requesting.accept(true)
        network.getMovies {[weak self] value, error in
            guard let self = self else {return}
            self.requesting.accept(false)
            self.addNewMoviesToTheList(newMovies: value)
        }
    }
    func addNewMoviesToTheList(newMovies : [Movie]) {
        var addNewMovies = self.availableMovies.value
        addNewMovies.append(contentsOf: newMovies)
        self.availableMovies.accept(addNewMovies)
    }
    func requestMoreItems() {
        getUpcomingMovies()
    }
    
    func errorThreatment(error: Error){
        //      self.errorMessageToDisplay.accept(error.localizedDescription)
    }
    
    func didSelectMovieAt(indexPath : IndexPath){
        let movie = availableMovies.value[indexPath.row]
        // router.routeToDetailsMovie(movie : movie)
    }
    
    func checkIfIsFavorite(movie : Movie) -> Bool{
        return favoriteManager.isThisFavorite(movie: movie)
    }
    
    func didToggleFavorite(movie : Movie){
        self.favoriteManager.toggleFavorite(movie: movie)
    }
    
    func indexPathFor(movie : Movie) -> IndexPath {
        let row = availableMovies.value.firstIndex(of: movie) ?? 0
        return IndexPath(row: row, section: 0)
    }
}
