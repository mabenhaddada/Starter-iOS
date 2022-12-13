//
//  APIServiceProtocol.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 07/12/2022.
//

import RxSwift

protocol APIServiceProtocol {
    func getJetBrainsRepos() -> Single<[API.JetBrains]>
}
