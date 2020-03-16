//
//  Album.swift
//  TopAlbums
//
//  Created by Jason Maxwell Custodio on 3/15/20.
//  Copyright © 2020 Jason Maxwell Custodio. All rights reserved.
//

import Foundation
import UIKit

struct AppleRSS: Codable {
    let feed: Feed
    
    struct Feed: Codable {
        let results: [Album]
    }
}

struct Album: Codable {
    let artistName: String
    let name: String
    let artworkUrl: URL
    let releaseDate: String
    let copyright: String
    let genres: [Genre]
    let url: URL
    var artwork: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case artworkUrl = "artworkUrl100"
        case artistName
        case name
        case releaseDate
        case copyright
        case genres
        case url
    }
    
    struct Genre: Codable {
        let name: String
    }
}
