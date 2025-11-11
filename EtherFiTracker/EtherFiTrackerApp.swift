//
//  EtherFiTrackerApp.swift
//  EtherFiTracker
//
//  Created by Kase Lunt on 11/11/25.
//

import SwiftUI
import SwiftData

@main
struct EtherFiTrackerApp: App {
    
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: WalletAddress.self)
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            // We wrap our starting view in a NavigationStack
            // This enables navigation (like the NavHost)
            NavigationStack {
                AddressListView()
            }
        }
        // This injects the database into the entire app.
        // Any view can now access it.
        .modelContainer(modelContainer)
    }
}
