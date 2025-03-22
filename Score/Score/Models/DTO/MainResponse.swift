//
//  MainResponse.swift
//  Score
//
//  Created by Fiodar Shtytsko on 22/03/2025.
//

import Foundation

// MARK: - MainResponse
struct MainResponse: Codable {
    let response: [Response]
}

// MARK: - Response
struct Response: Codable {
    let wscGameID: String
    let score: Score
    let teams, goals: Goals
    let league: LeagueDTO
    let fixture: Fixture
    let wscGame: WscGame?
    let storifyMeHandle: String?
    let storifyMeID: Int?

    enum CodingKeys: String, CodingKey {
        case wscGameID = "WSCGameId"
        case score, teams, goals, league, fixture, wscGame, storifyMeHandle, storifyMeID
    }
}

// MARK: - Fixture
struct Fixture: Codable {
    let timezone: Timezone
    let periods: Periods
    let timestamp: Int
    let status: Status
    let date: String
    let venue: Venue
    let id: Int
    let referee: String?
}

// MARK: - Periods
struct Periods: Codable {
    let second, first: JSONNull?
}

// MARK: - Status
struct Status: Codable {
    let long: Long
    let short: Short
    let elapsed: JSONNull?
}

enum Long: String, Codable {
    case notStarted = "Not Started"
}

enum Short: String, Codable {
    case ns = "NS"
}

enum Timezone: String, Codable {
    case utc = "UTC"
}

// MARK: - Venue
struct Venue: Codable {
    let name: String
    let id: Int
    let city: String
}

// MARK: - Goals
struct Goals: Codable {
    let home, away: Away?
}

// MARK: - Away
struct Away: Codable {
    let name: String
    let logo: URL
    let id: Int
    let winner: JSONNull?
}

// MARK: - League
struct LeagueDTO: Codable {
    let logo: String
    let season: Int
    let country: Country
    let round: String
    let id: Int
    let flag: String
    let name: Name
}

enum Country: String, Codable {
    case england = "England"
    case germany = "Germany"
    case israel = "Israel"
    case italy = "Italy"
    case spain = "Spain"
}

enum Name: String, Codable {
    case bundesliga = "Bundesliga"
    case copaDelRey = "Copa del Rey"
    case coppaItalia = "Coppa Italia"
    case faCup = "FA Cup"
    case laLiga = "La Liga"
    case ligatHaAl = "Ligat Ha'al"
    case premierLeague = "Premier League"
    case serieA = "Serie A"
}

// MARK: - Score
struct Score: Codable {
    let fulltime, halftime, extratime, penalty: Goals
}

// MARK: - WscGame
struct WscGame: Codable {
    let awayTeamName: String
    let primeStory: PrimeStory?
    let name, gameID, homeTeamName, gameTime: String

    enum CodingKeys: String, CodingKey {
        case awayTeamName, primeStory, name
        case gameID = "gameId"
        case homeTeamName, gameTime
    }
}

// MARK: - PrimeStory
struct PrimeStory: Codable {
    let title: String
    let storyThumbnailSquare: String
    let publishDate: String
    let storyThumbnail: String
    let storyID: String
    let pages: [Page]

    enum CodingKeys: String, CodingKey {
        case title, storyThumbnailSquare, publishDate, storyThumbnail
        case storyID = "storyId"
        case pages
    }
}

// MARK: - Page
struct Page: Codable {
    let duration: Int
    let paggeID: String
    let videoURL: URL
    let title: String?
    let awayScore: Int?
    let eventType: EventType?
    let gameClock: String?
    let homeScore: Int?
    let rating: Int
    let period: String?
    let actionType: ActionType?

    enum CodingKeys: String, CodingKey {
        case duration
        case paggeID = "paggeId"
        case videoURL = "videoUrl"
        case title, awayScore, eventType, gameClock, homeScore, rating, period, actionType
    }
}

enum ActionType: String, Codable {
    case booking = "Booking"
    case defensiveact = "Defensiveact"
    case disqualifiedGoal = "DisqualifiedGoal"
    case gkSave = "GKSave"
    case kickOff = "KickOff"
    case replay = "Replay"
    case shortGoal = "ShortGoal"
    case shot = "Shot"
    case varDecision = "VARDecision"
}

enum EventType: String, Codable {
    case playByPlay = "PlayByPlay"
}


class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}
