//
//  BestMoviesNetwork.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit

protocol MoviesNetwork {
    func getMovies(completionHandler : @escaping ([Movie],Error?)->())
    func resetMovies()
}
class BestMoviesNetworkImpl: MoviesNetwork {
    func resetMovies() {
        currentPage = 0
        maxPages = Int.max
        requesting = false
    }
    
    
    private var currentPage = 0
    private var maxPages = Int.max
    private var networkHandler : NetworkHandler!
    private var requesting = false
    
    init(networkHandler : NetworkHandler) {
        self.networkHandler = networkHandler
    }
    
    func getMovies(completionHandler: @escaping ([Movie], Error?) -> ()) {
        guard currentPage < maxPages,requesting == false else {
            completionHandler([],NetworkError.networkBusy)
            return
        }
        currentPage = currentPage + 1
        let url =  APIConstants.bestMoviesUrl
        let params : [String:Any] = ["page":currentPage,"api_key":APIConstants.apikey]
        requesting = true
        networkHandler.request(url, method: .get, params: params, type: BestMoviesRequestObject.self) { [weak self]
            value,error in
            self?.requesting = false
            guard error == nil,let value = value  else {
                completionHandler([],error)
                return
            }
            self?.maxPages = value.totalPages
            completionHandler(value.movieList,nil)
        }
    }
}
