//
//  SearchResponse.swift
//  AppleMusicAPI
//
//  Created by Mark on 12.03.2020.
//  Copyright © 2020 Mark. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String
    var collectionName: String?
    var artistName: String
    var artworkUrl60: String?
}
