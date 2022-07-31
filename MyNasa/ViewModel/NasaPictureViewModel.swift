//
//  NasaPictureViewModel.swift
//  MyNasa
//
//  Created by Dushyanth Potnuru on 25/07/22.
//

import Foundation
import PromiseKit

class NasaPictureViewModel {
    var model: NasaPicture
    var apodService = APODService()
    
    init(model: NasaPicture) {
        self.model = model
    }
    
    func getPicture(date: String? = nil) -> Promise<NasaPicture> {
        return apodService.fetchPictureOfTheDay(date: date).map { pictures in
            return pictures
        }
    }
    
    
    
}
