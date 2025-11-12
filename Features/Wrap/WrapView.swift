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
            VStack(spacing: SwapSpacing.medium) {
                // Header
                WrapHeader()
                Spacer().frame(height: SwapSpacing.small)
                
                // Input Section
                Text(isWrapping ? "Wrap" : "Unwrap")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.textLavender)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TokenInputBox(
                    value: $amount,
                    tokenSymbol: isWrapping ? "eETH" : "weETH",
                    balance: isWrapping ? viewModel.eethBalance : viewModel.weethBalance,
                    price: isWrapping ? viewModel.eethPrice : viewModel.weethPrice,
                    isLoading: viewModel.isLoading,
                    onMaxClick: {
                        amount = formatToMaxDigits(isWrapping ? viewModel.eethBalance : viewModel.weethBalance)
                    }
                )
                
                // Swap Direction Button
                SwapIconButton {
                    isWrapping.toggle()
                }
                
                // Output Section
                Text("Receive")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.textLavender)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TokenDisplayBox(
                    value: amount,
                    tokenSymbol: isWrapping ? "weETH" : "eETH",
                    balance: isWrapping ? viewModel.weethBalance : viewModel.eethBalance,
                    price: isWrapping ? viewModel.weethPrice : viewModel.eethPrice
                )
                
                // Exchange Rate
                ExchangeRateRow(isWrapping: isWrapping)
                
                // Action Button
                ActionButton(
                    text: isValidAmount(amount, maxBalance: isWrapping ? viewModel.eethBalance : viewModel.weethBalance) ?
                        (isWrapping ? "Wrap" : "Unwrap") : "Enter an amount",
                    isEnabled: isValidAmount(amount, maxBalance: isWrapping ? viewModel.eethBalance : viewModel.weethBalance),
                    action: {}
                )
                
                Spacer().frame(height: SwapSpacing.medium)
                
                // Disclaimer
                DisclaimerCard(text: "⚠️ This is a demo screen showing real balances.\nNo actual wrapping will occur.")
                
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

// MARK: - Wrap Header
private struct WrapHeader: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("Wrap on ")
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
    let isWrapping: Bool
    
    var body: some View {
        HStack {
            Text("Exchange Rate")
                .font(.system(size: 14))
                .foregroundColor(.textLavender.opacity(0.6))
            
            Text(isWrapping ? "1 eETH = 1.0 weETH" : "1 weETH = 1.0 eETH")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.textLavender)
        }
        .padding(.horizontal, 4)
    }
}

#Preview {
    WrapView(address: "0x1234567890abcdef")
}
