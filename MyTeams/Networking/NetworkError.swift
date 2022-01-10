//
//  NetworkError.swift
//  MyTeams
//
//  Created by Martin Bucko on 20/12/2021.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse, invalidData, invalidURL
}
