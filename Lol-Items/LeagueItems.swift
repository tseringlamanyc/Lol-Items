//
//  LeagueItems.swift
//  Lol-Items
//
//  Created by Tsering Lama on 11/25/20.
//

import Foundation

struct AllData: Decodable {
    let data: [String: Items]
}

struct Items: Decodable {
    let image: Media
}

struct Media: Decodable {
    let full: String 
}
