//
//  AddAddressViewModel.swift
//  EtherFiTracker
//
//  Created by Kase Lunt on 11/11/25.
//

import Foundation
import SwiftData

@Observable
final class AddAddressViewModel {
    var nickname: String = ""
    var address: String = ""
    
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var isSaveSuccess: Bool = false
    
    private let etherscanService: EtherscanServiceProtocol
    
    private let modelContext: ModelContext
    
    init(etherscanService: EtherscanServiceProtocol, modelContext: ModelContext) {
        self.etherscanService = etherscanService
        self.modelContext = modelContext
    }
    
    @MainActor // Ensures UI-related properties are updated on the main thread
    func saveAddress() {
        // Simple validation
        guard !nickname.trimmingCharacters(in: .whitespaces).isEmpty,
              !address.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Nickname and Address cannot be empty."
            return
        }
        
        isLoading = true
        errorMessage = nil
        isSaveSuccess = false
        
        Task {
            do {
                // 1. Validate address with Etherscan API
                let response = try await etherscanService.getEthBalance(
                    for: address.trimmingCharacters(in: .whitespaces)
                )
                
                // 2. Check response
                if response.status == "1" {
                    // Address is valid, save to SwiftData database
                    let newWallet = WalletAddress(
                        nickname: nickname.trimmingCharacters(in: .whitespaces),
                        address: address.trimmingCharacters(in: .whitespaces)
                    )
                    
                    modelContext.insert(newWallet)
                    
                    // Trigger navigation back
                    isSaveSuccess = true
                    
                } else {
                    // API returned an error
                    errorMessage = "Invalid address or API error: \(response.message)"
                }
                
            } catch {
                // Network error or other exception
                errorMessage = "Error: \(error.localizedDescription)"
            }
            
            isLoading = false
        }
    }
    
    func resetSaveSuccess() {
        isSaveSuccess = false
    }
}
