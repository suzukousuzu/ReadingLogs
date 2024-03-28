//
//  Genre.swift
//  ReadingLogs
//
//  Created by 鈴木航太 on 2024/03/24.
//

import Foundation
import SwiftData

@Model
final class Genre {
    var name: String
    var books: [Book] = []
    
    init(name: String) {
        self.name = name
    }
}
