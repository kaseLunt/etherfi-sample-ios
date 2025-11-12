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
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            
            TabView(selection: $selectedTab) {
                DemoCardView()
                    .tabItem {
                        Label("Card", systemImage: "creditcard")
                    }
                    .tag(0)
                
                StakeWrapContainerView(address: address)
                    .tabItem {
                        Label("Stake / Wrap", systemImage: "arrow.2.squarepath")
                    }
                    .tag(1)
                
                PortfolioDetailView(address: address)
                    .tabItem {
                        Label("Portfolio", systemImage: "chart.pie")
                    }
                    .tag(2)
                
                VaultView(address: address)
                    .tabItem {
                        Label("Vault", systemImage: "lock.shield")
                    }
                    .tag(3)
            }
            .accentColor(.etherFiGold)
        }
        .navigationTitle(nickname)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.appBackground, for: .navigationBar)
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
