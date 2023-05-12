//
//  Launch.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 07.03.2023.
//

import Foundation

struct Launch: Decodable {
    var flightNumber: Int?
    let ships: [String]
    var links: Links?
    var name: String?
    var details: String?
    var cores: [Cores?]?
    var dateUtc: String?
    var success: Bool?
}

// MARK: - Links
struct Links: Decodable {
    let patch: Patch
    let reddit: Reddit
    let presskit: String?
    let webcast: String?
    let youtubeId: String?
    let article: String?
    let wikipedia: String?

//    enum CodingKeys: String, CodingKey {
//        case patch, reddit, flickr, presskit, webcast
//        case youtubeID = "youtube_id"
//        case article, wikipedia
//    }
}

// MARK: - Patch
struct Patch: Decodable {
    let small, large: String?
}

// MARK: - Reddit
struct Reddit: Decodable {
    let campaign: String?
    let launch: String?
    let media, recovery: String?
}

struct Cores: Decodable {
    var flight: Int?
}
