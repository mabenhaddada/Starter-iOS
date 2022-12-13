//
//  SchemaV1.swift
//  Starter
//
//  Created by Mohamed Amine BEN HADDADA on 07/12/2022.
//

import Foundation
import GRDB

enum SchemaV1 {
    static func createX(_ db: Database) throws {
        try db.create(table: "x") { table in
            table.column("id", .text)
                .primaryKey()
        }
    }
}
