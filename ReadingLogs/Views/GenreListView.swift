//
//  GenreListVie.swift
//  ReadingLogs
//
//  Created by 鈴木航太 on 2024/03/24.
//

import SwiftUI
import SwiftData

struct GenreListView: View {
    
    @Query(sort: \Genre.name) 
    private var genres: [Genre]
    var body: some View {
        NavigationStack {
            List {
                ForEach(genres) { genre in
                    Text(genre.name)
                    
                }
            }
            .navigationTitle("Literary Genre")
            
        }
    }
}
