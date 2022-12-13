//
//  AppPaths.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 07/12/2022.
//

import Foundation

enum AppPaths {
    private static let fileManager = FileManager.default
    
    private static let defaultRootDirectoryURL = fileManager
        .urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        .appendingPathComponent(Bundle.main.bundleIdentifier!)
    
    static func createDirectoriesIfNeeded() throws {
        if !fileManager.fileExists(atPath: defaultRootDirectoryURL.path) {
            try fileManager.createDirectory(
                at: defaultRootDirectoryURL,
                withIntermediateDirectories: true
            )
        }
    }
    
    // MARK: - Persistence
    
    static var dbWritablePath: String {
        defaultRootDirectoryURL
            .appendingPathComponent("db.sqlite")
            .path
    }
}
