//
//  NetworkService.swift
//  MyNasa
//
//  Created by Dushyanth Potnuru on 24/07/22.
//

import Foundation
import Alamofire
import PromiseKit

protocol BaseService {
    func getUrl(url: String) -> Promise<Data>
}

class HttpService: BaseService {
    func getUrl(url: String) -> Promise<Data>{
        return Promise { resolve in
            AF.request(url).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    resolve.fulfill(data)
                case .failure(let error):
                    resolve.reject(error)
                }
            })
            
        }
    }
    
    
}

