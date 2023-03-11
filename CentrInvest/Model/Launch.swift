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
    var cores: [Cores?]?
    var dateUtc: String?
    var success: Bool?
}

struct Links: Decodable {
    var patch: Patch?
}

struct Patch: Decodable {
    var small: String?
}

struct Cores: Decodable {
    var flight: Int?
}
