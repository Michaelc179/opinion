//
//  opinionApp.swift
//  opinion
//
//  Created by Michael Chen on 1/20/24.
//



import SwiftUI
import SwiftData
import Firebase

@main

struct opinionApp: App {
    
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        
        WindowGroup {
            QuestionView()
        }
//        .modelContainer(sharedModelContainer)
    }
    
    
}
