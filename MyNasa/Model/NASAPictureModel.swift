//
//  NASAPictureModel.swift
//  MyNasa
//
//  Created by Dushyanth Potnuru on 25/07/22.
//

import Foundation

// MARK: - NasaPicture
struct NasaPicture: Codable {
    let explanation: String?
    let hdurl: String?
    let mediaType, serviceVersion, title: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
