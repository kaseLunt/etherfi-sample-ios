//
//  AddressListView.swift
//  EtherFiTracker
//
//  Created by Kase Lunt on 11/11/25.
//

import SwiftUI
import SwiftData

struct AddressListView: View {
    
    // Live-updating query for all saved WalletAddress objects
    @Query(sort: \WalletAddress.nickname) private var wallets: [WalletAddress]
    
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        List {
            ForEach(wallets) { wallet in
                NavigationLink(destination: Text("Detail for \(wallet.nickname)")) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(wallet.nickname)
                            .font(.headline)
                        Text(wallet.address)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("My Wallets")
        .toolbar {
            // Adds the "+" button to the top-right
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddAddressView(etherscanService: EtherscanService())) {
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

struct AddressListView_Previews: PreviewProvider {
    static var previews: some View {
        let container = try! ModelContainer(
            for: WalletAddress.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        // Add some sample data
        let sample = WalletAddress(nickname: "Preview Wallet", address: "0x1234...5678")
        container.mainContext.insert(sample)
        
        return NavigationStack {
            AddressListView()
        }
        .modelContainer(container)
    }
}
