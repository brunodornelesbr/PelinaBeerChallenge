//
//  NetworkError.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit

public enum NetworkError: Error {
    case networkBusy
    case errorFromApi(apiError : String)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkBusy:
            return "n/d"
        case .errorFromApi(let apiError):
            return apiError
        }
    }
}
