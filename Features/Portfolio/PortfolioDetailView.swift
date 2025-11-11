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
        Group {
            if viewModel.isLoading {
                VStack {
                    ProgressView()
                    Text("Loading portfolio...")
                        .foregroundStyle(.secondary)
                        .padding(.top)
                }
            } else if let errorMessage = viewModel.errorMessage {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundStyle(.red)
                    Text("Error")
                        .font(.title2)
                        .bold()
                    Text(errorMessage)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
            } else {
                portfolioContent
            }
        }
        .task {
            await viewModel.loadPortfolio()
        }
    }
    
    private var portfolioContent: some View {
        List {
            // Total Value Section
            Section {
                VStack(spacing: 8) {
                    Text("Total Portfolio Value")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text(totalValue, format: .currency(code: "USD"))
                        .font(.system(size: 36, weight: .bold))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
            }
            
            // Holdings Section
            Section("Holdings") {
                ForEach(viewModel.portfolioState, id: \.symbol) { token in
                    TokenRow(token: token)
                }
            }
        }
    }
    
    private var totalValue: Double {
        viewModel.portfolioState.reduce(0) { $0 + $1.usdValue }
    }
}

// Token row component
private struct TokenRow: View {
    let token: TokenBalanceUiState
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(token.name)
                    .font(.headline)
                Text("\(token.balance, specifier: "%.4f") \(token.symbol)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(token.usdValue, format: .currency(code: "USD"))
                .font(.title3)
                .bold()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        PortfolioDetailView(address: "0x1234567890abcdef")
    }
}
