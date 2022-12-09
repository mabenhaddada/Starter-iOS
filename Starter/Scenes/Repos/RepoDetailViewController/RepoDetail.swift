//
//  RepoDetail.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 09/12/2022.
//

import RxSwift

struct RepoDetail {
    let info: () -> Observable<Info>
    
    struct Info: Hashable {
        let fullName: String
        let description: String?
    }
}

extension RepoDetail {
    static func current(fullName name: String, description: String?) -> Self {
        .init(info: {
            .just(.init(fullName: name, description: description))
        })
    }
    
    static func mock() -> Self {
        .init(info: {
            .just(.init(fullName: "Repo", description: nil))
        })
    }
}
