//
//  WrapView.swift
//  EtherFiTracker
//

import SwiftUI

struct WrapView: View {
    let address: String
    
    @State private var viewModel: SimulatedWrapViewModel
    @State private var isWrapping = true
    @State private var amount = ""
    
    init(address: String) {
        self.address = address
        _viewModel = State(initialValue: SimulatedWrapViewModel(
            address: address,
            etherscanService: EtherscanService(),
            coinGeckoService: CoinGeckoService()
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                Text(isWrapping ? "Wrap eETH" : "Unwrap weETH")
                    .font(.title2)
                    .bold()
                
                // Input Section
                VStack(alignment: .leading, spacing: 8) {
                    Text(isWrapping ? "From: eETH" : "From: weETH")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        TextField("0.0", text: $amount)
                            .keyboardType(.decimalPad)
                            .font(.title)
                        
                        Button("MAX") {
                            amount = String(format: "%.4f", isWrapping ? viewModel.eethBalance : viewModel.weethBalance)
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    HStack {
                        Text(usdValue, format: .currency(code: "USD"))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text("Balance: \(isWrapping ? viewModel.eethBalance : viewModel.weethBalance, specifier: "%.4f")")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Swap Direction Button
                Button(action: { isWrapping.toggle() }) {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title2)
                }
                .buttonStyle(.bordered)
                
                // Output Section
                VStack(alignment: .leading, spacing: 8) {
                    Text(isWrapping ? "To: weETH" : "To: eETH")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text(amount.isEmpty ? "0.0" : amount)
                        .font(.title)
                    
                    Text("1:1 exchange rate")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Action Button
                Button(action: {}) {
                    Text(isWrapping ? "Wrap" : "Unwrap")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isValidAmount ? Color.blue : Color.gray)
                        .foregroundStyle(.white)
                        .cornerRadius(12)
                }
                .disabled(!isValidAmount)
                
                // Disclaimer
                Text("⚠️ This is a demo screen showing real balances.\nNo actual wrapping will occur.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .padding()
        }
        .task {
            await viewModel.loadBalances()
        }
    }
    
    private var usdValue: Double {
        let numericAmount = Double(amount) ?? 0
        let price = isWrapping ? viewModel.eethPrice : viewModel.weethPrice
        return numericAmount * price
    }
    
    private var isValidAmount: Bool {
        guard let numericAmount = Double(amount), numericAmount > 0 else { return false }
        let maxBalance = isWrapping ? viewModel.eethBalance : viewModel.weethBalance
        return numericAmount <= maxBalance
    }
}

#Preview {
    WrapView(address: "0x1234567890abcdef")
}
