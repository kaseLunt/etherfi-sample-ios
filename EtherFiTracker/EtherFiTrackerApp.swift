//
//  EtherFiTrackerApp.swift
//  EtherFiTracker
//

import SwiftUI
import SwiftData

@main
struct EtherFiTrackerApp: App {
    let modelContainer: ModelContainer
    
    init() {
        do {
            // Initialize SwiftData container for WalletAddress persistence
            modelContainer = try ModelContainer(for: WalletAddress.self)
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                AddressListView()
            }
        }
        .modelContainer(modelContainer)
    }
}
