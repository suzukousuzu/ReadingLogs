//
//  AddNewNote.swift
//  ReadingLogs
//
//  Created by 鈴木航太 on 2024/03/24.
//

import SwiftUI
import SwiftData

struct AddNewNote: View {
    let book: Book
    
    @State private var title: String = ""
    @State private var message: String = ""
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Form {
            TextField("Note Title", text: $title)
            TextField("Note messsage", text: $message)
            
        }
        .navigationTitle("New Note")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Close")
                })
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    let note = Note(title: title, message: message)
                    note.book = book
                    context.insert(note)
                    
                    do {
                        try context.save()
                        book.notes.append(note)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    dismiss()
                }, label: {
                    Text("Save")
                })
            }
        }
    }
}
