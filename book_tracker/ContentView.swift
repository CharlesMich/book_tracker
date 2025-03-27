//
//  ContentView.swift
//  book_tracker
//
//  Created by Charles Michael on 3/24/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
//    @Query var books: [Book]
//    @Query(sort: \Book.title) var books: [Book]
//    @Query(sort: \Book.rating, order: .reverse) var books: [Book]
//    @Query(sort: [SortDescriptor(\Book.title), SortDescriptor(\Book.author)]) var books: [Book]
    @Query(sort: [SortDescriptor(\Book.title, order: .reverse)]) var books: [Book]
    
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book){
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading){
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .navigationDestination(for: Book.self){ book in
                        DetailView(book: book)
                    }
                }
                .onDelete(perform: deleteBook)
            }
                .navigationTitle("BookHub")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading){
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Add book", systemImage: "plus"){
                            showingAddScreen.toggle()
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen){
                    AddBookView()
                }
        }
    }
    func deleteBook(at offsets: IndexSet){
        for offset in offsets {
            let book = books[offset]
            
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
