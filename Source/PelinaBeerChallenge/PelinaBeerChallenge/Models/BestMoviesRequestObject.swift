//
//  BestMoviesRequestObject.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit
import ObjectMapper

    class BestMoviesRequestObject: Mappable {
      var success = true
      var movieList = [Movie]()
      var page = 0
      var totalPages = 0
        required convenience init?(map: Map) {
            self.init()
        }
        
        func mapping(map: Map) {
            movieList <- map["results"]
            success <- map["success"]
            page <- map["page"]
            totalPages <- map["total_pages"]
        }
    }

