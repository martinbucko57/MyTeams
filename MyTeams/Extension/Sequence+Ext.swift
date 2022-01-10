//
//  Sequence+Ext.swift
//  MyTeams
//
//  Created by Martin Bucko on 03/01/2022.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
