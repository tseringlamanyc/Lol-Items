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

struct Items: Decodable, Hashable {
    let image: Media
    let name: String
    let tags: [String]
}

struct Media: Decodable, Hashable {
    let full: String
    
    // http://ddragon.leagueoflegends.com/cdn/10.24.1/img/item/1001.png 
}
