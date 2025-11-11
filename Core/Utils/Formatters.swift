//
//  Formatters.swift
//  EtherFiTracker
//
//  Created by Kase Lunt on 11/11/25.
//

import Foundation

/// Converts a Wei balance (or token smallest unit) to a decimal representation.
///
/// - Parameters:
///   - weiBalance: The balance as a string in the smallest unit (e.g., "1000000000000000000")
///   - decimals: The number of decimal places (18 for ETH, etc.)
/// - Returns: The balance as a Double.
func convertWeiToDecimal(weiBalance: String, decimals: Int) -> Double {
    guard let wei = Decimal(string: weiBalance) else {
        return 0.0
    }

    let divisor = pow(Decimal(10), decimals)
    let result = wei / divisor

    // Convert Decimal to Double for use in our UI
    return NSDecimalNumber(decimal: result).doubleValue
}
