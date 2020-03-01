//
//  DateFormatter+Extension.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//


import UIKit

extension DateFormatter {
    static func formatFromAPI(string: String)->Date?{
        let dateFormatter = DateFormatter(withFormat: "yyyy-mm-dd", locale: "en-US")
       return dateFormatter.date(from: string)
    }
    static func formatToShow(date : Date?)->String{
        guard date != nil else {return "N/D"}
        
        let dateFormatter = DateFormatter(withFormat: "mm/dd/yy", locale: "en-US")
      return  dateFormatter.string(from: date!)
    }
}


