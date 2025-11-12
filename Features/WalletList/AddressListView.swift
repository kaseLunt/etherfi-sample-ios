//
//  AddressListView.swift
//  EtherFiTracker
//

import SwiftUI
import SwiftData

struct AddressListView: View {
    @Query(sort: \WalletAddress.nickname) private var wallets: [WalletAddress]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            
            List {
                ForEach(wallets) { wallet in
                    NavigationLink(destination: WalletMainView(
                        address: wallet.address,
                        nickname: wallet.nickname
                    )) {
                        WalletRow(wallet: wallet)
                    }
                    .listRowBackground(Color.cardBackground)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .navigationTitle("My Wallets")
            .toolbarBackground(Color.appBackground, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddAddressView(
                        etherscanService: EtherscanService(),
                        modelContext: modelContext
                    )) {
                        Image(systemName: "plus")
                            .foregroundColor(.etherFiGold)
                    }
                }
            }
            .overlay {
                if wallets.isEmpty {
                    emptyState
                }
            }
        }
    }
    
    private var emptyState: some View {
        VStack(spacing: 16) {
            Text("📱")
                .font(.system(size: 80))
            
            Text("No wallets saved")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.textLavender)
            
            Text("Tap the '+' button to add your first wallet!")
                .font(.system(size: 14))
                .foregroundColor(.textLavender.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(32)
    }
}

// MARK: - Wallet Row
private struct WalletRow: View {
    let wallet: WalletAddress
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(wallet.nickname)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.textLavender)
            
            Text(wallet.address)
                .font(.system(size: 14))
                .foregroundColor(.textLavender.opacity(0.7))
                .lineLimit(1)
                .truncationMode(.middle)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    let container = try! ModelContainer(
        for: WalletAddress.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    
    let sample = WalletAddress(nickname: "Preview Wallet", address: "0x1234567890abcdef")
    container.mainContext.insert(sample)
    
    return NavigationStack {
        AddressListView()
    }
    .modelContainer(container)
}
