//
//  MovieFilter.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 02/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit

class MovieFilter {
    func filterBy(option : FilteringOptions,movies : [Movie]) -> [Movie] {
        switch option {
        case .name:
            return filterByName(movies: movies)
        case .releaseDate:
            return filterByReleaseDate(movies: movies)
        case .score:
            return filterByScore(movies: movies)
        }
    }
    
    func filterByName(movies : [Movie])->[Movie] {
        return movies.sorted{$0.original_title > $1.original_title}
        }
    
        
        func filterByReleaseDate(movies : [Movie])->[Movie] {
            return movies.sorted{$0.releaseDate > $1.releaseDate}
           }
        
        func filterByScore(movies : [Movie])->[Movie] {
            return movies.sorted {$0.voteAverage > $1.voteAverage}
           }
}
