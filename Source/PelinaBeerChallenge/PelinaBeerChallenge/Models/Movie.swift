//
//  Movie.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit
import ObjectMapper
class Movie: Mappable, Codable {
    
    var id  = -1
    var original_title = ""
    var posterPath : String?
    var backdropPath : String?
    var genres = ""
    var releaseDate : Date?
    var overview = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        original_title <- map["original_title"]
        posterPath <- map["poster_path"]
        backdropPath <- map["backdrop_path"]
        overview <- map["overview"]
        var genreIds = [Int]()
        genreIds <- map["genre_ids"]
        
        var release = ""
        release<-map["release_date"]
        releaseDate = DateFormatter.formatFromAPI(string: release)
    }
    
    func getPosterURL()->URL?{
        guard let path = posterPath else {return nil}
        let urlString = String(format:APIConstants.imageUrl,path)
        return URL(string: urlString)
    }
    
    func getBackdropURL()->URL?{
          guard let path = backdropPath else {return nil}
          let urlString = String(format:APIConstants.imageUrl,path)
          return URL(string: urlString)
      }
    
}

extension Movie : Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
