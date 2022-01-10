//
//  Player.swift
//  MyTeams
//
//  Created by Martin Bucko on 08/01/2022.
//

import Foundation

struct Player: Codable {
    var id: Int?
    var name: String?
    var number: Int?
    var position: String?
    //var grid: String?
    
    enum CodingKeys: String, CodingKey {
        case position = "pos"
        case id, name, number
    }
}
