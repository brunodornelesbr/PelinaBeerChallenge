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

enum FilteringOptions : String {
    case name = "Name"
    case releaseDate = "Release Date"
    case score = "Score"
}
class BestMoviesViewModel: NSObject {
    private var availableMovies = BehaviorRelay<[Movie]>(value : [])
    private var requesting = BehaviorRelay<Bool>(value: false)
    var movies : Observable<[Movie]> {return availableMovies.asObservable()}
    var network : MoviesNetwork
    var favoriteManager : FavoriteManager
    weak var coordinator : MoviesCoordinator?
    var options = BehaviorRelay<[FilteringOptions]>(value: [FilteringOptions.name,FilteringOptions.releaseDate,FilteringOptions.score]) 
    init(network : MoviesNetwork,favoriteManager : FavoriteManager, coordinator : MoviesCoordinator) {
        self.network = network
        self.favoriteManager = favoriteManager
        self.coordinator = coordinator
        super.init()
    }
    func resetMovies() {
        network.resetMovies()
        availableMovies.accept([])
        favoriteManager.loadFavorites()
        getMovies()
    }
    
    func getMovies(){
        if requesting.value == false {
            requesting.accept(true)
            network.getMovies {[weak self] value, error in
                guard let self = self else {return}
                self.requesting.accept(false)
                self.addNewMoviesToTheList(newMovies: value)
            }
        }
    }
    func addNewMoviesToTheList(newMovies : [Movie]) {
        var addNewMovies = self.availableMovies.value
        addNewMovies.append(contentsOf: newMovies)
        self.availableMovies.accept(addNewMovies)
    }
    func requestMoreItems() {
        getMovies()
    }
    
    func didSelectMovieAt(indexPath : IndexPath){
        let movie = availableMovies.value[indexPath.row]
        coordinator?.showDetails(movie:movie)
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
    
    func didSelect(segmentControlIndex : Int) {
        let option = options.value[segmentControlIndex]
        let filter = MovieFilter()
        let orderedMovies =  filter.filterBy(option: option, movies: availableMovies.value)
        availableMovies.accept(orderedMovies)
        
    }
}
