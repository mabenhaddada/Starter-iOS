//
//  APIService.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 09/12/2022.
//

import os.log
import Alamofire
import RxSwift

class APIService {
    init() {
        session = Self.createSession()
    }
    
    private let session: Session
    private let jsonDecoder = JSONDecoder()
    
    private static func createSession() -> Session {
        Session(
            cachedResponseHandler: ResponseCacher(behavior: .doNotCache),
            eventMonitors: [NetworkLogger(log)]
        )
    }
    
    private func getDecodable<T: Decodable>(url: URL) -> Single<T> {
        let session = self.session
        
        return Single<Data>.create(subscribe: { observer in
            let task = session.request(url, headers: [.accept("application/json")])
                .validate()
                .responseData(completionHandler: {
                    switch $0.result {
                    case .success(let data):
                        observer(.success(data))
                    case .failure(let error):
                        observer(.failure(error))
                    }
                })
            return Disposables.create { task.cancel() }
        })
        .map({ [weak self] data in
            guard let self = self else { preconditionFailure() }
            
            return try self.jsonDecoder.decode(T.self, from: data)
        })
    }
}

// MARK: - APIServiceProtocol
extension APIService: APIServiceProtocol {
    func getJetBrainsRepos() -> Single<[API.JetBrains]> {
        guard let url = URL(string: "https://api.github.com/orgs/jetbrains/repos?page=1") else {
            preconditionFailure()
        }
        
        return getDecodable(url: url)
    }
}

fileprivate let log = OSLog(category: "API")
