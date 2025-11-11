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
        List {
            ForEach(wallets) { wallet in
                // Navigate to WalletMainView with the wallet details
                NavigationLink(destination: WalletMainView(
                    address: wallet.address,
                    nickname: wallet.nickname
                )) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(wallet.nickname)
                            .font(.headline)
                        Text(wallet.address)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .truncationMode(.middle)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("My Wallets")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddAddressView(
                    etherscanService: EtherscanService(),
                    modelContext: modelContext
                )) {
                    Image(systemName: "plus")
                }
            }
        }
        .overlay {
            if wallets.isEmpty {
                ContentUnavailableView {
                    Label("No Wallets Saved", systemImage: "wallet.pass")
                } description: {
                    Text("Tap the + button to add your first wallet.")
                }
            }
        }
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
