//
//  OSLog+App.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 07/12/2022.
//

import Foundation
import os.log

extension OSLog {
    convenience init(category: String) {
        self.init(subsystem: Bundle.main.bundleIdentifier!, category: category)
    }
}
