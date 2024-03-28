//
//  BookListView.swift
//  ReadingLogs
//
//  Created by 鈴木航太 on 2024/03/23.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Environment(\.modelContext) private var context
    @Query private var books: [Book]
    @State private var presentAddNewBook = false
    
    @State private var searchTerm: String = ""
    
    var filteredBooks: [Book] {
        guard searchTerm.isEmpty == false else { return books }
        return books.filter { $0.tittle.localizedStandardContains(searchTerm) }
    }
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredBooks) { book in
                    BookCellView(book: book)
                    
                }
                .onDelete(perform: { indexSet in
                    delete(indexSet: indexSet)
                })
                .searchable(text: $searchTerm, prompt: "Search Book Title")
            }
            .navigationTitle("Reading Log")
            .navigationDestination(for: Book.self) { book in
                BookDetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        presentAddNewBook.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $presentAddNewBook, content: {
                        AddNewBookView()
                    })
                }
            }
        }
    }
    private func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            let book = books[index]
            context.delete(book)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    BookListView()
}
