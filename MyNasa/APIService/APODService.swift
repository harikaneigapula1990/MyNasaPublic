//
//  APODService.swift
//  MyNasa
//
//  Created by Dushyanth Potnuru on 24/07/22.
//

import Foundation
import PromiseKit

class APODService {
    private var httpService: BaseService
    
    init() {
        self.httpService = HttpService()
    }
    
    func fetchPictureOfTheDay(date: String? = nil) -> Promise<NasaPicture>{
        
        if let date = date {
          let url = Constant.APOD + "&date=" + date
            return httpService.getUrl(url: url).map { data in
                let nasaPicture: NasaPicture = try! JSONDecoder().decode(NasaPicture.self, from: data)
                return nasaPicture
            }
        }
        return httpService.getUrl(url: Constant.APOD).map { data in
            let nasaPicture: NasaPicture = try! JSONDecoder().decode(NasaPicture.self, from: data)
            return nasaPicture
        }
            
    }
    
}
