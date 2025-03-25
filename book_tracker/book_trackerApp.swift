//
//  book_trackerApp.swift
//  book_tracker
//
//  Created by Charles Michael on 3/24/25.
//

import SwiftUI
import SwiftData

@main
struct book_trackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Book.self)
        }
    }
}
