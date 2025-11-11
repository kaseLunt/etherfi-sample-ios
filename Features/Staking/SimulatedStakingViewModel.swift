//
//  SimulatedStakingViewModel.swift
//  EtherFiTracker
//

import Foundation

@Observable
final class SimulatedStakingViewModel {
    var ethBalance = 0.0
    var eethBalance = 0.0
    var ethPrice = 0.0
    var eethPrice = 0.0
    var isLoading = false
    var errorMessage: String?
    
    private let address: String
    private let etherscanService: EtherscanServiceProtocol
    private let coinGeckoService: CoinGeckoServiceProtocol
    
    private let eethContractAddress = "0x35fa164735182de50811e8e2e824cfb9b6118ac2"
    
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
            async let ethResponse = etherscanService.getEthBalance(for: address)
            async let eethResponse = etherscanService.getTokenBalance(
                for: address,
                contractAddress: eethContractAddress
            )
            async let prices = coinGeckoService.getPrices(
                ids: ["ethereum", "ether-fi-staked-eth"],
                vsCurrencies: ["usd"]
            )
            
            let (eth, eeth, priceData) = try await (ethResponse, eethResponse, prices)
            
            // Update balances
            if eth.status == "1" {
                ethBalance = convertWeiToDecimal(weiBalance: eth.result, decimals: 18)
            }
            
            if eeth.status == "1" {
                eethBalance = convertWeiToDecimal(weiBalance: eeth.result, decimals: 18)
            }
            
            // Update prices
            ethPrice = priceData["ethereum"]?["usd"] ?? 0.0
            eethPrice = priceData["ether-fi-staked-eth"]?["usd"] ?? 0.0
            
        } catch {
            errorMessage = "Error loading balances: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
