//
//  Venue.swift
//  MyTeams
//
//  Created by Martin Bucko on 08/01/2022.
//

import Foundation

struct Venue: Codable {
    var id: Int?
    var name: String?
    var address: String?
    var city: String?
    var capacity: Int?
    var surface: String?
    var image: URL?
}
