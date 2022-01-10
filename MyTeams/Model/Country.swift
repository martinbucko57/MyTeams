//
//  Country.swift
//  MyTeams
//
//  Created by Martin Bucko on 08/01/2022.
//

import Foundation

struct Country: Codable, Hashable {
    var name: String
    var code: String?
    var flag: String?
}
