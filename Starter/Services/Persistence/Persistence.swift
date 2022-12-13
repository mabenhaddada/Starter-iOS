//
//  Persistence.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 07/12/2022.
//

import Foundation
import GRDB

final class Persistence {
    let dbWriter: DatabaseWriter
    
    convenience init(at path: String) throws {
        try self.init(try DatabasePool(path: path, configuration: GRDB.Configuration()))
    }
    
    private init(_ dbWriter: DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try Self.setup(dbWriter)
    }
    
    static func setup(_ dbWriter: DatabaseWriter) throws {
        try dbMigrator.migrate(dbWriter)
    }
    
    private static var dbMigrator: DatabaseMigrator = {
        var dbMigrator = DatabaseMigrator()
        
        #if DEBUG
        // Clear all Data when migrations change (Speed up Dev)
        dbMigrator.eraseDatabaseOnSchemaChange = true
        #endif
        
        // Schema v1
        dbMigrator.registerMigration("x", migrate: SchemaV1.createX)
        
        return dbMigrator
    }()
}
