//
//  NoteListView.swift
//  ReadingLogs
//
//  Created by 鈴木航太 on 2024/03/24.
//

import SwiftUI
import SwiftData

struct NoteListView: View {
    let book: Book
    
    @Environment(\.modelContext) private var context
    var body: some View {
        List {
            ForEach(book.notes) { note in
                VStack(alignment: .leading) {
                    Text(note.title)
                        .bold()
                    Text(note.message)
                }
            }
            .onDelete(perform: { indexSet in
                deleteNote(indexSet: indexSet)
            })
        }
    }
    
    private func deleteNote(indexSet: IndexSet) {
        indexSet.forEach { index in
            let note = book.notes[index]
            context.delete(note)
            
            book.notes.remove(at: index)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
