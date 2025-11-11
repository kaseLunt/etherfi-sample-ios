//
//  AddAddressView.swift
//  EtherFiTracker
//

import SwiftUI
import SwiftData

struct AddAddressView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    // ViewModel is created and owned by the View
    @State private var viewModel: AddAddressViewModel
    
    // Designated initializer for production use
    init(etherscanService: EtherscanServiceProtocol, modelContext: ModelContext) {
        let vm = AddAddressViewModel(
            etherscanService: etherscanService,
            modelContext: modelContext
        )
        _viewModel = State(initialValue: vm)
    }

    var body: some View {
        Form {
            Section("Wallet Details") {
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
                .disabled(viewModel.isLoading || viewModel.nickname.isEmpty || viewModel.address.isEmpty)
            }
            
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
                dismiss()
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        for: WalletAddress.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    
    return NavigationStack {
        AddAddressView(
            etherscanService: EtherscanService(),
            modelContext: container.mainContext
        )
    }
    .modelContainer(container)
}
