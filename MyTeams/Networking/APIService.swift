//
//  APIService.swift
//  MyTeams
//
//  Created by Martin Bucko on 26/12/2021.
//

import Foundation

class APIService {
    
    static let networkManager: NetworkManager = NetworkManager()
    
    static func searchTeamByName(teamName: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        let parameters = [EndpointConstants.searchParamValue: teamName]
//        networkManager.request(endpointEnum: .teams, parameters: parameters) { (result: Result<GeneralResponse<ResponseTeams>, Error>) in
        networkManager.request(json: TestingData.searchTeamByName, parameters: parameters) { (result: Result<GeneralResponse<ResponseTeams>, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.response.map { $0.team } ))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    static func fetchFixturesForTeam(teamId: Int, season: String, completion: @escaping (Result<[ResponseFixture], Error>) -> Void) {
        let parameters = [
            EndpointConstants.teamParamValue: String(teamId),
            EndpointConstants.seasonParamValue: season
        ]
//        networkManager.request(endpointEnum: .fixtures, parameters: parameters) { (result: Result<GeneralResponse<ResponseFixture>, Error>) in
        networkManager.request(json: TestingData.allFixturesForTeamInSeason, parameters: parameters) { (result: Result<GeneralResponse<ResponseFixture>, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.response))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    static func fetchFixture(fixtureId: Int, completion: @escaping (Result<ResponseFixture?, Error>) -> Void) {
        let parameters = [EndpointConstants.idParamValue: String(fixtureId)]
//        networkManager.request(endpointEnum: .fixtures, parameters: parameters) { (result: Result<GeneralResponse<ResponseFixture>, Error>) in
        networkManager.request(json: TestingData.fixtureById, parameters: parameters) { (result: Result<GeneralResponse<ResponseFixture>, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.response.first))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    static func fetchLeaguesForTeam(teamId: Int, season: String, completion: @escaping (Result<[League], Error>) -> Void) {
        let parameters = [
            EndpointConstants.teamParamValue: String(teamId),
            EndpointConstants.seasonParamValue: season
        ]
//        networkManager.request(endpointEnum: .leagues, parameters: parameters) { (result: Result<GeneralResponse<ResponseLeague>, Error>) in
        networkManager.request(json: TestingData.leaguesForTeamInSeason, parameters: parameters) { (result: Result<GeneralResponse<ResponseLeague>, Error>) in
            switch result {
            case .success(let data):
                let leagues = data.response
                    .filter { $0.seasons.first?.coverage.standings ?? false }
                    .map { $0.league }
                completion(.success(leagues))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    static func fetchStandingsForLeague(leagueId: Int, season: String, completion: @escaping (Result<[[LeagueStanding]], Error>) -> Void) {
        let parameters = [
            EndpointConstants.leagueParamValue: String(leagueId),
            EndpointConstants.seasonParamValue: season
        ]
//        networkManager.request(endpointEnum: .standings, parameters: parameters) { (result: Result<GeneralResponse<ResponseLeagueStandings>, Error>) in
        networkManager.request(json: TestingData.standingsForLeagueInSeason, parameters: parameters) { (result: Result<GeneralResponse<ResponseLeagueStandings>, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.response.first?.league.standings ?? [[]]))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
