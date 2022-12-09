//
//  API.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 09/12/2022.
//

import Foundation

enum API {
    struct JetBrains: Decodable {
        let id: Int
        let fullName: String
        let description: String?
        let forks: Int
        let watchers: Int
        let openIssues: Int
        
        enum CodingKeys: String, CodingKey {
            case id
            case fullName = "full_name"
            case description
            case forks
            case watchers
            case openIssues = "open_issues"
        }
    }
}
