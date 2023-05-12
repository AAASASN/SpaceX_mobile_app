//
//  CrewMember.swift
//  CentrInvest
//
//  Created by Александр Мараенко on 20.03.2023.
//

import Foundation

struct CrewMember: Decodable {
    let name, agency: String
    let image: String
    let wikipedia: String
    let launches: [String]
    let id: String
}
