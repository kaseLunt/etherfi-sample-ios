//
//  StakeWrapContainerView.swift
//  EtherFiTracker
//

import SwiftUI

struct StakeWrapContainerView: View {
    let address: String
    
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom Tab Selector
            Picker("Mode", selection: $selectedTab) {
                Text("Stake").tag(0)
                Text("Wrap").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()
            
            // Tab Content
            TabView(selection: $selectedTab) {
                StakingView(address: address)
                    .tag(0)
                
                WrapView(address: address)
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

#Preview {
    StakeWrapContainerView(address: "0x1234567890abcdef")
}
