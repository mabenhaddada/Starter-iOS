//
//  String+orEmpty.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 09/12/2022.
//

import Foundation

extension Optional where Wrapped: StringProtocol {
    var orEmpty: Wrapped {
        switch self {
        case .none:
            return ""
        case .some(let text):
            return text
        }
    }
}
