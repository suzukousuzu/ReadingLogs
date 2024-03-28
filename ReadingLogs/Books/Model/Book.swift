//
//  Book.swift
//  ReadingLogs
//
//  Created by 鈴木航太 on 2024/03/23.
//

import Foundation
import SwiftData

@Model
final class Book {
    var tittle: String
    var author: String
    var publishedYear: Int
    
    @Attribute(.externalStorage)
    var cover: Data?
    
    @Relationship(deleteRule: .cascade, inverse: \Note.book)
    var notes = [Note]()
    
    @Relationship(deleteRule: .nullify, inverse: \Genre.books)
    var genre = [Genre]()
    
    init(tittle: String, author: String, publishedYear: Int) {
        self.tittle = tittle
        self.author = author
        self.publishedYear = publishedYear
    }
}
