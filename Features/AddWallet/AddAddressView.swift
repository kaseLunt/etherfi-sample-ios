//
//  AddAddressView.swift
//  EtherFiTracker
//
//  Created by Kase Lunt on 11/11/25.
//

import SwiftUI
import SwiftData

struct AddAddressView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: AddAddressViewModel
    
    init(etherscanService: EtherscanServiceProtocol) {
        _viewModel = State(
            initialValue: AddAddressViewModel(
                etherscanService: etherscanService,
                modelContext:
                   try! ModelContainer(for: WalletAddress.self).mainContext
            )
        )
    }
    
    init(preview: Bool = false) {
        let container = try! ModelContainer(for: WalletAddress.self, inMemory: true)
        _viewModel = State(
            initialValue: AddAddressViewModel(
                etherscanService: EtherscanService(),
                modelContext: container.mainContext
            )
        )
    }

    var body: some View {
        Form {
            Section("Wallet Details") {
                // This is the equivalent of OutlinedTextField
                // $viewModel.nickname binds the text field to the VM property
                TextField("Nickname (e.g., My Main Wallet)", text: $viewModel.nickname)
                TextField("Ethereum Address (0x...)", text: $viewModel.address)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            
            Section {
                Button(action: {
                    viewModel.saveAddress()
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Save Address")
                            .frame(maxWidth: .infinity)
                    }
                }
                // Disable button if loading or fields are empty
                .disabled(viewModel.isLoading || viewModel.nickname.isEmpty || viewModel.address.isEmpty)
            }
            
            // Show error message if one exists
            if let errorMessage = viewModel.errorMessage {
                Section {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Add Wallet")
        .onChange(of: viewModel.isSaveSuccess) {
            if viewModel.isSaveSuccess {
                dismiss() // Pop back to the previous screen
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddAddressView(preview: true)
    }
}
