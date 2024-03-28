//
//  AddNewBookView.swift
//  ReadingLogs
//
//  Created by 鈴木航太 on 2024/03/23.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AddNewBookView: View {
    @State private var tittle = ""
    @State private var author = ""
    @State private var publishedYear: Int?
    
    @State private var selectedCover: PhotosPickerItem?
    @State private var selectedCoverData: Data?
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedGenre = Set<Genre>()
    
    private var isValid: Bool {
        !tittle.isEmpty && !author.isEmpty && publishedYear != nil
    }
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, content: {
                // MARK: - Title
                Text("Book Tittle: ")
                TextField("Enter Title", text: $tittle)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    PhotosPicker(selection: $selectedCover, matching: .images, photoLibrary: .shared()) {
                        Label("Add Cover", systemImage: "book.closed")
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                    if let selectedCoverData,
                       let image = UIImage(data: selectedCoverData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 10))
                            .frame(width: 100, height: 100)
                    
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    }
                }
                
                // MARK: - Author
                Text("Author:")
                TextField("Enter author", text: $author)
                    .textFieldStyle(.roundedBorder)
                
                Text("PublishedYear:")
                TextField("Enter PublishedYear", value: $publishedYear, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                GenreSelectionView(selectedGenre: $selectedGenre)
                
                HStack {
                    Button("Cancel", role: .destructive) {
                        dismiss()
                       
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let publishedYear = publishedYear.self else { return }
                        let book = Book(tittle: tittle, author: author, publishedYear: publishedYear)
                        
                        book.genre = Array(selectedGenre)
                        
                        if let selectedCover {
                            book.cover = selectedCoverData
                        }
                        selectedGenre.forEach { genre in
                            genre.books.append(book)
                            context.insert(genre)
                        }
                        
                        context.insert(book)
                        
                        do {
                            try context.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                        dismiss()
                        
                    }
                    .buttonStyle(.bordered)
                    .disabled(!isValid)
                }
                
                Spacer()
                
            })
            .padding()
            .navigationTitle("Add New Book")
            .task(id: selectedCover) {
                if let data = try? await selectedCover?.loadTransferable(type: Data.self) {
                    selectedCoverData = data
                }
            }
        }
    }
}

#Preview {
    AddNewBookView()
}
