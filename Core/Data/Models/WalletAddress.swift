//
//  WalletAddress.swift
//  EtherFiTracker
//
//  Created by Kase Lunt on 11/11/25.
//

import Foundation
import SwiftData

@Model
final class WalletAddress {
    // @PrimaryKey(autoGenerate = true) -> SwiftData handles this automatically.
    
    var nickname: String
    var address: String
    
    init(nickname: String, address: String) {
        self.nickname = nickname
        self.address = address
    }
}
