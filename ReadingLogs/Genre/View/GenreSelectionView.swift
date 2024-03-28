//
//  GenreSelectionView.swift
//  ReadingLogs
//
//  Created by 鈴木航太 on 2024/03/25.
//

import SwiftUI
import SwiftData

struct GenreSelectionView: View {
    @Query(sort: \Genre.name) private var genres: [Genre]
    @Binding var selectedGenre: Set<Genre>
    var body: some View {
        List {
            Section("Library Genre") {
                ForEach(genres) { genre in
                    HStack {
                        Text(genre.name)
                        Spacer()
                        Image(systemName: selectedGenre.contains(genre) ? "checkmark.circle.fill" : "circle.dashed")
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !selectedGenre.contains(genre) {
                            selectedGenre.insert(genre)
                        } else {
                            selectedGenre.remove(genre)
                        }
                    }
                    
                }
            }
        }
        .listStyle(.plain)
    }
}
