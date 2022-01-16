//
//  Collection+Ext.swift
//  MyTeams
//
//  Created by Martin Bucko on 15/01/2022.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
