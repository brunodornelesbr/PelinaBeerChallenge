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
    init(movie : Movie) {
        self.movie.accept(movie)
    }
}
