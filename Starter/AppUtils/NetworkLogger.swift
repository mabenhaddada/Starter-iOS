//
//  NetworkLogger.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 08/12/2022.
//

import Alamofire
import Foundation
import os.log

class NetworkLogger {
    
    let logger: OSLog
    
    init(_ logger: OSLog) {
        self.logger = logger
    }
}

extension NetworkLogger: EventMonitor {
    
    func request(_ request: Request, didCreateTask task: URLSessionTask) {
        request.cURLDescription { [weak self] curl in
            guard let self = self else { return }
            os_log(
                .debug, log: self.logger,
                "▶️ %{public}@\n%@",
                request.id.uuidString,
                curl.replacingOccurrences(of: "\t", with: "  ")
            )
        }
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        let responseRepresentation = response.data.flatMap { String(data: $0, encoding: .utf8) } as Any?
                ?? response.data
                ?? "<no data>"
        
        switch response.result {
        case .success:
            os_log(.debug, log: self.logger,
                   "✅ %{public}@\n%@",
                   request.id.uuidString,
                   String(describing: responseRepresentation)
            )
        case .failure(let error):
            switch error {
            case AFError.explicitlyCancelled:
                os_log(.debug, log: self.logger,
                       "🤷‍♂️ %{public}@",
                       request.id.uuidString
                )
            default:
                os_log(.error, log: self.logger,
                       "🛑 %{public}@ - %@\n%@",
                       request.id.uuidString,
                       String(describing: error),
                       String(describing: responseRepresentation)
                )
            }
        }
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        let responseRepresentation = response.data.flatMap { String(data: $0, encoding: .utf8) } as Any?
                ?? response.data
                ?? "<no data>"
        
        switch response.result {
        case .success:
            os_log(.debug, log: self.logger,
                   "✅ %{public}@\n%@",
                   request.id.uuidString,
                   String(describing: responseRepresentation)
            )
        case .failure(let error):
            switch error {
            case AFError.explicitlyCancelled:
                os_log(.debug, log: self.logger,
                       "🤷‍♂️ %{public}@",
                       request.id.uuidString
                )
            default:
                let responseRepresentation = response.data.flatMap { String(data: $0, encoding: .utf8) } as Any?
                    ?? response.data
                    ?? "<no data>"
                os_log(.error, log: self.logger,
                       "🛑 %{public}@ <%@> - %@\n%@",
                       request.id.uuidString,
                       String(describing: Value.self),
                       String(describing: error),
                       String(describing: responseRepresentation)
                )
            }
        }
    }
}
