//
//  WalletMainView.swift
//  EtherFiTracker
//

import SwiftUI

struct WalletMainView: View {
    let address: String
    let nickname: String
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Card Tab
            DemoCardView()
                .tabItem {
                    Label("Card", systemImage: "creditcard")
                }
                .tag(0)
            
            // Stake/Wrap Tab
            StakeWrapContainerView(address: address)
                .tabItem {
                    Label("Stake / Wrap", systemImage: "arrow.2.squarepath")
                }
                .tag(1)
            
            // Portfolio Tab
            PortfolioDetailView(address: address)
                .tabItem {
                    Label("Portfolio", systemImage: "chart.pie")
                }
                .tag(2)
            
            // Vault Tab
            VaultView(address: address)
                .tabItem {
                    Label("Vault", systemImage: "lock.shield")
                }
                .tag(3)
        }
        .navigationTitle(nickname)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        WalletMainView(
            address: "0x1234567890abcdef",
            nickname: "My Wallet"
        )
    }
}
