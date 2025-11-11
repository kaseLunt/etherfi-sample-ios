//
//  StakingView.swift
//  EtherFiTracker
//

import SwiftUI

struct StakingView: View {
    let address: String
    
    @State private var viewModel: SimulatedStakingViewModel
    @State private var isStaking = true
    @State private var amount = ""
    
    init(address: String) {
        self.address = address
        _viewModel = State(initialValue: SimulatedStakingViewModel(
            address: address,
            etherscanService: EtherscanService(),
            coinGeckoService: CoinGeckoService()
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                Text(isStaking ? "Stake ETH" : "Unstake eETH")
                    .font(.title2)
                    .bold()
                
                // Input Section
                VStack(alignment: .leading, spacing: 8) {
                    Text(isStaking ? "From: ETH" : "From: eETH")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        TextField("0.0", text: $amount)
                            .keyboardType(.decimalPad)
                            .font(.title)
                        
                        Button("MAX") {
                            amount = String(format: "%.4f", isStaking ? viewModel.ethBalance : viewModel.eethBalance)
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    HStack {
                        Text(usdValue, format: .currency(code: "USD"))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Spacer()
                        
                        Text("Balance: \(isStaking ? viewModel.ethBalance : viewModel.eethBalance, specifier: "%.4f")")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Swap Direction Button
                Button(action: { isStaking.toggle() }) {
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.title2)
                }
                .buttonStyle(.bordered)
                
                // Output Section
                VStack(alignment: .leading, spacing: 8) {
                    Text(isStaking ? "To: eETH" : "To: ETH")
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
                    Text(isStaking ? "Stake" : "Unstake")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isValidAmount ? Color.blue : Color.gray)
                        .foregroundStyle(.white)
                        .cornerRadius(12)
                }
                .disabled(!isValidAmount)
                
                // Disclaimer
                Text("⚠️ This is a demo screen showing real balances.\nNo actual staking will occur.")
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
        let price = isStaking ? viewModel.ethPrice : viewModel.eethPrice
        return numericAmount * price
    }
    
    private var isValidAmount: Bool {
        guard let numericAmount = Double(amount), numericAmount > 0 else { return false }
        let maxBalance = isStaking ? viewModel.ethBalance : viewModel.eethBalance
        return numericAmount <= maxBalance
    }
}

#Preview {
    StakingView(address: "0x1234567890abcdef")
}
