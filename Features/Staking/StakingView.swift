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
            VStack(spacing: SwapSpacing.medium) {
                // Header
                StakingHeader(isStaking: isStaking)
                Spacer().frame(height: SwapSpacing.small)
                
                // Input Section
                Text(isStaking ? "Stake" : "Unstake")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.textLavender)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TokenInputBox(
                    value: $amount,
                    tokenSymbol: isStaking ? "ETH" : "eETH",
                    balance: isStaking ? viewModel.ethBalance : viewModel.eethBalance,
                    price: isStaking ? viewModel.ethPrice : viewModel.eethPrice,
                    isLoading: viewModel.isLoading,
                    onMaxClick: {
                        amount = formatToMaxDigits(isStaking ? viewModel.ethBalance : viewModel.eethBalance)
                    }
                )
                
                // Swap Direction Button
                SwapIconButton {
                    isStaking.toggle()
                }
                
                // Output Section
                Text("Receive")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.textLavender)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TokenDisplayBox(
                    value: amount,
                    tokenSymbol: isStaking ? "eETH" : "ETH",
                    balance: isStaking ? viewModel.eethBalance : viewModel.ethBalance,
                    price: isStaking ? viewModel.eethPrice : viewModel.ethPrice
                )
                
                // Exchange Rate
                ExchangeRateRow()
                
                // Action Button
                ActionButton(
                    text: isValidAmount(amount, maxBalance: isStaking ? viewModel.ethBalance : viewModel.eethBalance) ?
                        (isStaking ? "Stake" : "Unstake") : "Enter an amount",
                    isEnabled: isValidAmount(amount, maxBalance: isStaking ? viewModel.ethBalance : viewModel.eethBalance),
                    action: {}
                )
                
                Spacer().frame(height: SwapSpacing.medium)
                
                // Disclaimer
                DisclaimerCard(text: "⚠️ This is a demo screen showing real balances.\nNo actual staking will occur.")
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                        .padding(.top, SwapSpacing.small)
                }
            }
            .padding(SwapSpacing.medium)
        }
        .background(Color.appBackground)
        .task {
            await viewModel.loadBalances()
        }
    }
}

// MARK: - Staking Header
private struct StakingHeader: View {
    let isStaking: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            Text(isStaking ? "Stake on " : "Unstake on ")
                .font(.system(size: 16))
                .foregroundColor(.purpleArrow)
            
            EthereumChainIcon(size: 36)
                .padding(.horizontal, 4)
            
            Text("Ethereum")
                .font(.system(size: 16))
                .foregroundColor(.textLavender)
        }
        .frame(maxWidth: .infinity)
        .padding(SwapSpacing.small)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.cardBackground)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    LinearGradient.primaryGradient,
                    lineWidth: 0.5
                )
        )
    }
}

// MARK: - Exchange Rate Row
private struct ExchangeRateRow: View {
    var body: some View {
        HStack {
            Text("Exchange Rate")
                .font(.system(size: 14))
                .foregroundColor(.textLavender.opacity(0.6))
            
            Text("1 ETH = 1.0 eETH")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.textLavender)
        }
        .padding(.horizontal, 4)
    }
}

#Preview {
    StakingView(address: "0x1234567890abcdef")
}
