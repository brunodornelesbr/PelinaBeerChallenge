//
//  APIConstants.swift
//  TheMovieDBKobe
//
//  Created by Bruno Dorneles on 15/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit

struct APIConstants {
static let apikey = "c5850ed73901b8d268d0898a8a9d8bff"
static let baseUrl = "https://api.themoviedb.org/3"
static let upcomingMoviesUrl = "\(baseUrl)/movie/upcoming"
static let imageUrl = "https://image.tmdb.org/t/p/w500/%@"
static let genreList = "\(baseUrl)/genre/movie/list"
static let searchMovie = "\(baseUrl)/search/movie"
}

