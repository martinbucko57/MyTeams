//
//  UserDefaults+Ext.swift
//  MyTeams
//
//  Created by Martin Bucko on 29/12/2021.
//

import Foundation

extension UserDefaults {

    private enum Keys {
        static let favouriteTeams = "favouriteTeams"
    }

    class var favouriteTeams: [Team] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Keys.favouriteTeams) else { return [] }
            do {
                return try JSONDecoder().decode([Team].self, from: data)
            } catch {
                return []
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: Keys.favouriteTeams)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
