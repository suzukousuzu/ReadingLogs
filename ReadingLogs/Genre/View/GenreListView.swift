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
    
    @State private var presenteAddNewGenre = false
    
    @Environment(\.modelContext) private var context
    var body: some View {
        NavigationStack {
            List {
                ForEach(genres) { genre in
                    NavigationLink(value: genre) {
                        Text(genre.name)
                    }
                  
                    
                }
                .onDelete(perform: { indexSet in
                    deleteGenre(indextSet: indexSet)
                })
            }
            .navigationDestination(for: Genre.self, destination: { genre in
                GenreDetailView(genre: genre)
            })
            .navigationTitle("Literary Genre")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        presenteAddNewGenre.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $presenteAddNewGenre, content: {
                        AddNewGenre()
                            .presentationDetents([.fraction(0.3)])
                            .interactiveDismissDisabled()
                    })
                }
            }
            
        }
    }
    
    private func deleteGenre(indextSet: IndexSet) {
        indextSet.forEach { index in
            let genre = genres[index]
            context.delete(genre)
            
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
