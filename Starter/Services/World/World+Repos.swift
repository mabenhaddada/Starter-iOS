//
//  World+Repos.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 09/12/2022.
//

import Foundation
import RxSwift

extension World {
    func getJetBrainsRepos() -> Single<[API.JetBrains]>{
        apiService().getJetBrainsRepos()
    }
}
