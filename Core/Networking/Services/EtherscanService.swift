//
//  EtherscanService.swift
//  EtherFiTracker
//
//  Created by Kase Lunt on 11/11/25.
//

import Foundation

// 1. Define the protocol (the "interface")
protocol EtherscanServiceProtocol {
    func getEthBalance(for address: String) async throws -> EtherscanBalanceResponse
    func getTokenBalance(for address: String, contractAddress: String) async throws -> EtherscanBalanceResponse
}

// Create the implementation (the "class")
final class EtherscanService: EtherscanServiceProtocol {
    
    // Read the API Key from the Info.plist
    private var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "ETHERSCAN_API_KEY") as? String else {
            fatalError("ETHERSCAN_API_KEY not found in Info.plist")
        }
        return key
    }
    
    private let baseURL = "https://api.etherscan.io/v2/api"
    
    func getEthBalance(for address: String) async throws -> EtherscanBalanceResponse {
        // Build URL components
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "chainid", value: "1"),
            URLQueryItem(name: "module", value: "account"),
            URLQueryItem(name: "action", value: "balance"),
            URLQueryItem(name: "address", value: address),
            URLQueryItem(name: "tag", value: "latest"),
            URLQueryItem(name: "apikey", value: apiKey)
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        
        return try await performRequest(url: url)
    }
    
    func getTokenBalance(for address: String, contractAddress: String) async throws -> EtherscanBalanceResponse {
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "chainid", value: "1"),
            URLQueryItem(name: "module", value: "account"),
            URLQueryItem(name: "action", value: "tokenbalance"),
            URLQueryItem(name: "contractaddress", value: contractAddress),
            URLQueryItem(name: "address", value: address),
            URLQueryItem(name: "tag", value: "latest"),
            URLQueryItem(name: "apikey", value: apiKey)
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        
        return try await performRequest(url: url)
    }
    
    // Create a shared, reusable function for making the web request
    private func performRequest(url: URL) async throws -> EtherscanBalanceResponse {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: "Invalid server response"])
        }
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(EtherscanBalanceResponse.self, from: data)
        } catch {
            // Provide more detail if decoding fails
            print("Failed to decode JSON: \(error)")
            print("Raw data: \(String(data: data, encoding: .utf8) ?? "No data")")
            throw error
        }
    }
}
