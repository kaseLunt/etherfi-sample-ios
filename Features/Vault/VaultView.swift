//
//  VaultView.swift
//  EtherFiTracker
//

import SwiftUI

struct VaultView: View {
    let address: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "lock.shield")
                .font(.system(size: 60))
                .foregroundStyle(.blue)
            
            Text("Vault")
                .font(.title)
                .bold()
            
            Text("Coming Soon")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Text("Secure vault functionality will be available in a future update.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    VaultView(address: "0x1234567890abcdef")
}
