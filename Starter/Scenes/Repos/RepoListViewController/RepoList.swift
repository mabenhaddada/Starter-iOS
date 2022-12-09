//
//  RepoList.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 08/12/2022.
//

import Foundation
import RxSwift

struct RepoList {
    let repos: () -> Single<[Repo]>
    
    struct Repo: Hashable {
        let fullName: String
        let description: String?
        let forks: Int
        let openIssues: Int
        let watchers: Int
    }
}

extension RepoList {
    static func current() -> RepoList {
        .init(repos: {
            Current.getJetBrainsRepos()
                .map({ $0.map(RepoList.Repo.init) })
        })
    }
    
    static func mock() -> RepoList {
        .init(repos: {
            .just([
                .init(
                    fullName: "Repo 1",
                    description: "Repo 1 Desciption",
                    forks: .zero,
                    openIssues: 4,
                    watchers: 2
                ),
                .init(
                    fullName: "Repo 2",
                    description: nil,
                    forks: 2,
                    openIssues: 13,
                    watchers: 5
                )
            ])
        })
    }
}

extension RepoList.Repo {
    fileprivate init(_ api: API.JetBrains) {
        self.fullName = api.fullName
        self.description = api.description
        self.forks = api.forks
        self.openIssues = api.openIssues
        self.watchers = api.watchers
    }
}
