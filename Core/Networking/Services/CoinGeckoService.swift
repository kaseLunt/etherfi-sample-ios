//
//  CoinGeckoService.swift
//  EtherFiTracker
//
//  Created by Kase Lunt on 11/11/25.
//

import Foundation

// 1. Define the protocol
protocol CoinGeckoServiceProtocol {
    func getPrices(ids: [String], vsCurrencies: [String]) async throws -> CoinGeckoPriceResponse
}

// 2. Create the implementation
final class CoinGeckoService: CoinGeckoServiceProtocol {
    
    private let baseURL = "https://api.coingecko.com/api/v3/simple/price"
    
    func getPrices(ids: [String], vsCurrencies: [String]) async throws -> CoinGeckoPriceResponse {
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            // Convert arrays to comma-separated strings
            URLQueryItem(name: "ids", value: ids.joined(separator: ",")),
            URLQueryItem(name: "vs_currencies", value: vsCurrencies.joined(separator: ","))
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL, userInfo: [NSLocalizedDescriptionKey: "Invalid URL for CoinGecko"])
        }
        
        // 3. Make the request
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: "Invalid server response from CoinGecko"])
        }
        
        // 4. Decode the response
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(CoinGeckoPriceResponse.self, from: data)
        } catch {
            print("Failed to decode CoinGecko JSON: \(error)")
            print("Raw data: \(String(data: data, encoding: .utf8) ?? "No data")")
            throw error
        }
    }
    
}
