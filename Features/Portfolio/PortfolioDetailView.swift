//
//  PortfolioDetailView.swift
//  EtherFiTracker
//

import SwiftUI

struct PortfolioDetailView: View {
    let address: String
    
    @State private var viewModel: PortfolioDetailViewModel
    
    init(address: String) {
        self.address = address
        _viewModel = State(initialValue: PortfolioDetailViewModel(
            address: address,
            etherscanService: EtherscanService(),
            coinGeckoService: CoinGeckoService()
        ))
    }
    
    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
            
            Group {
                if viewModel.isLoading {
                    loadingView
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(errorMessage)
                } else {
                    portfolioContent
                }
            }
        }
        .task {
            await viewModel.loadPortfolio()
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading portfolio...")
                .font(.system(size: 14))
                .foregroundColor(.textLavender.opacity(0.7))
        }
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundColor(.red)
            Text("Error")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.textLavender)
            Text(message)
                .font(.system(size: 14))
                .foregroundColor(.textLavender.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
    
    private var portfolioContent: some View {
        ScrollView {
            VStack(spacing: 8) {
                // Header Section - Address
                AddressHeaderCard(address: address)
                    .padding(.horizontal)
                    .padding(.top)
                
                // Total Value Section
                TotalValueCard(totalValue: totalValue)
                    .padding(.horizontal)
                
                // Holdings Header
                Text("Holdings")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.textLavender)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                
                // Token List
                VStack(spacing: 8) {
                    ForEach(viewModel.portfolioState, id: \.symbol) { token in
                        TokenCard(token: token)
                            .padding(.horizontal)
                    }
                }
                
                Spacer().frame(height: 16)
            }
        }
    }
    
    private var totalValue: Double {
        viewModel.portfolioState.reduce(0) { $0 + $1.usdValue }
    }
}

// MARK: - Address Header Card
private struct AddressHeaderCard: View {
    let address: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Wallet Address")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.textLavender)
            
            Text(address)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.textLavender)
                .lineLimit(1)
                .truncationMode(.middle)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.cardBackground)
        )
    }
}

// MARK: - Total Value Card
private struct TotalValueCard: View {
    let totalValue: Double
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Total Portfolio Value")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.textLavender)
            
            Text(totalValue, format: .currency(code: "USD"))
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.textLavender)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.cardBackgroundLight)
        )
    }
}

// MARK: - Token Card
private struct TokenCard: View {
    let token: TokenBalanceUiState
    
    var body: some View {
        HStack(spacing: 12) {
            // Token Icon
            TokenIcon(symbol: token.symbol, size: 40)
            
            // Token Info
            VStack(alignment: .leading, spacing: 4) {
                Text(token.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.textLavender)
                
                Text("\(token.balance, specifier: "%.4f") \(token.symbol)")
                    .font(.system(size: 14))
                    .foregroundColor(.textLavender.opacity(0.7))
            }
            
            Spacer()
            
            // USD Value
            Text(token.usdValue, format: .currency(code: "USD"))
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.textAccent)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.cardBackground)
        )
    }
}

#Preview {
    NavigationStack {
        PortfolioDetailView(address: "0x1234567890abcdef")
    }
}
