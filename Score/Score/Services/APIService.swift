//
//  APIService.swift
//  Score
//
//  Created by Fiodar Shtytsko on 21/03/2025.
//

import Foundation

protocol APIServiceProtocol {
    func fetchLeagues(from url: URL) async throws -> [League]
}

enum APIService {
    static func fetchLeagues(from url: URL) async throws -> [League] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(MainResponse.self, from: data)
        return LeagueMapper.map(rawMatches: decoded.response)
    }
}

struct APIServiceImpl: APIServiceProtocol {
    func fetchLeagues(from url: URL) async throws -> [League] {
        try await APIService.fetchLeagues(from: url)
    }
}
