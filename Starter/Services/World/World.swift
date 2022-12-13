//
//  World.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 07/12/2022.
//

import Foundation

struct World {
    var calendar: () -> Calendar
    
    var date: () -> Date
    
    var defaults: () -> UserDefaults
    
    var locale: () -> Locale
    
    var persistence: () -> Persistence
    
    var apiService: () -> APIServiceProtocol
}

var Current = World(
    calendar: { Calendar.current },
    date: { Date() },
    defaults: { UserDefaults.standard },
    locale: { Locale.current },
    persistence: { preconditionFailure("Not implemented") },
    apiService: { preconditionFailure("Not implemented") }
)
