//
//  NetworkHandler.swift
//  PelinaBeerChallenge
//
//  Created by Bruno Dorneles on 01/03/20.
//  Copyright © 2020 Bruno Dorneles. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
protocol NetworkHandler {
    func request<T: Mappable>(_ urlString: String,
    method: HTTPMethod,
    params: Parameters?,
    type: T.Type,
    completion: @escaping (T?, Error?) -> Void)
}
class NetworkHandlerImpl: NetworkHandler {
    public func request<T: Mappable>(_ urlString: String,
                                            method: HTTPMethod,
                                            params: Parameters?,
                                            type: T.Type,
                                            completion: @escaping (T?, Error?) -> Void) {

        Alamofire.request(urlString, method: method, parameters: params).responseObject { (response: DataResponse<T>) in
            switch response.result {
            case .success:
               
                completion(response.value, nil)
                return
            case .failure(let error):
                completion(nil, error)
                return
            }
        }
    }
}
