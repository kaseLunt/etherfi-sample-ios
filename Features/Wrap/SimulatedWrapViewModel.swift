//
//  SimulatedWrapViewModel.swift
//  EtherFiTracker
//

import Foundation

@Observable
final class SimulatedWrapViewModel {
    var eethBalance = 0.0
    var weethBalance = 0.0
    var eethPrice = 0.0
    var weethPrice = 0.0
    var isLoading = false
    var errorMessage: String?
    
    private let address: String
    private let etherscanService: EtherscanServiceProtocol
    private let coinGeckoService: CoinGeckoServiceProtocol
    
    private let eethContractAddress = "0x35fA164735182de50811E8e2E824cFb9B6118ac2"
    private let weethContractAddress = "0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee"
    
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
    func loadBalances() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Fetch balances and prices in parallel
            async let eethResponse = etherscanService.getTokenBalance(
                for: address,
                contractAddress: eethContractAddress
            )
            async let weethResponse = etherscanService.getTokenBalance(
                for: address,
                contractAddress: weethContractAddress
            )
            async let prices = coinGeckoService.getPrices(
                ids: ["ether-fi-staked-eth", "wrapped-eeth"],
                vsCurrencies: ["usd"]
            )
            
            let (eeth, weeth, priceData) = try await (eethResponse, weethResponse, prices)
            
            // Update balances
            if eeth.status == "1" {
                eethBalance = convertWeiToDecimal(weiBalance: eeth.result, decimals: 18)
            }
            
            if weeth.status == "1" {
                weethBalance = convertWeiToDecimal(weiBalance: weeth.result, decimals: 18)
            }
            
            // Update prices
            eethPrice = priceData["ether-fi-staked-eth"]?["usd"] ?? 0.0
            weethPrice = priceData["wrapped-eeth"]?["usd"] ?? 0.0
            
        } catch {
            errorMessage = "Error loading balances: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
