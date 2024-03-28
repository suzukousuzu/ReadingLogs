//
//  GenreDetailView.swift
//  ReadingLogs
//
//  Created by 鈴木航太 on 2024/03/26.
//

import SwiftUI
import SwiftData

struct GenreDetailView: View {
    let genre: Genre
    var body: some View {
        VStack {
            Group {
                if genre.books.isEmpty {
                    ContentUnavailableView("No Books Under This Denre", systemImage: "square.stack.3d.up.slash")
                } else {
                    List(genre.books) { book in
                        Text(book.tittle)
                        
                    }
                }
            }
        }
        .navigationTitle(genre.name)
    }
}
