//
//  PortfolioDetailViewModel.swift
//  EtherFiTracker
//

import Foundation

// UI state for a single token balance
struct TokenBalanceUiState {
    let name: String
    let symbol: String
    let balance: Double
    let usdValue: Double
}

@Observable
final class PortfolioDetailViewModel {
    var isLoading = false
    var errorMessage: String?
    var portfolioState: [TokenBalanceUiState] = []
    
    private let etherscanService: EtherscanServiceProtocol
    private let coinGeckoService: CoinGeckoServiceProtocol
    private let address: String
    
    // Token configurations
    private let tokensToTrack = [
        TokenInfo(
            name: "Ethereum",
            symbol: "ETH",
            contractAddress: nil,
            coingeckoId: "ethereum",
            decimals: 18
        ),
        TokenInfo(
            name: "weETH (Wrapped Ether.fi)",
            symbol: "weETH",
            contractAddress: "0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee",
            coingeckoId: "wrapped-eeth",
            decimals: 18
        ),
        TokenInfo(
            name: "eETH (Ether.fi ETH)",
            symbol: "eETH",
            contractAddress: "0x35fA164735182de50811E8e2E824cFb9B6118ac2",
            coingeckoId: "ether-fi-staked-eth",
            decimals: 18
        )
    ]
    
    init(
        address: String,
        etherscanService: EtherscanServiceProtocol,
        coinGeckoService: CoinGeckoServiceProtocol
    ) {
        self.address = address
        self.etherscanService = etherscanService
        self.coinGeckoService = coinGeckoService
    }
    
    @MainActor
    func loadPortfolio() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Fetch prices
            let ids = tokensToTrack.map { $0.coingeckoId }
            let prices = try await coinGeckoService.getPrices(
                ids: ids,
                vsCurrencies: ["usd"]
            )
            
            // Fetch balances in parallel
            let balances = try await withThrowingTaskGroup(
                of: (Int, EtherscanBalanceResponse).self
            ) { group in
                for (index, token) in tokensToTrack.enumerated() {
                    group.addTask {
                        let response: EtherscanBalanceResponse
                        if token.contractAddress == nil {
                            response = try await self.etherscanService.getEthBalance(for: self.address)
                        } else {
                            response = try await self.etherscanService.getTokenBalance(
                                for: self.address,
                                contractAddress: token.contractAddress!
                            )
                        }
                        return (index, response)
                    }
                }
                
                var results: [(Int, EtherscanBalanceResponse)] = []
                for try await result in group {
                    results.append(result)
                }
                return results.sorted { $0.0 < $1.0 }
            }
            
            // Combine data
            portfolioState = tokensToTrack.enumerated().map { index, token in
                let balanceResponse = balances[index].1
                
                guard balanceResponse.status == "1" else {
                    return TokenBalanceUiState(
                        name: token.name,
                        symbol: token.symbol,
                        balance: 0.0,
                        usdValue: 0.0
                    )
                }
                
                let balanceDecimal = convertWeiToDecimal(
                    weiBalance: balanceResponse.result,
                    decimals: token.decimals
                )
                
                let price = prices[token.coingeckoId]?["usd"] ?? 0.0
                let usdValue = balanceDecimal * price
                
                return TokenBalanceUiState(
                    name: token.name,
                    symbol: token.symbol,
                    balance: balanceDecimal,
                    usdValue: usdValue
                )
            }
            
        } catch {
            errorMessage = "Error loading portfolio: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}

// Private helper struct
private struct TokenInfo {
    let name: String
    let symbol: String
    let contractAddress: String?
    let coingeckoId: String
    let decimals: Int
}
