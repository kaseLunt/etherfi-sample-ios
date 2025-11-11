//
//  NetworkModels.swift
//  EtherFiTracker
//
//  Created by Kase Lunt on 11/11/25.
//

import Foundation

struct EtherscanBalanceResponse: Codable {
    let status: String
    let message: String
    let result: String
}

typealias CoinGeckoPriceResponse = [String: [String: Double]]
