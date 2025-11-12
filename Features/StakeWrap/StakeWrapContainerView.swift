//
//  StakeWrapContainerView.swift
//  EtherFiTracker
//

import SwiftUI

struct StakeWrapContainerView: View {
    let address: String
    
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            // Background
            Color.appBackground
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Custom Tab Bar
                HStack(spacing: 0) {
                    TabButton(title: "Stake", isSelected: selectedTab == 0) {
                        withAnimation {
                            selectedTab = 0
                        }
                    }
                    
                    TabButton(title: "Wrap", isSelected: selectedTab == 1) {
                        withAnimation {
                            selectedTab = 1
                        }
                    }
                }
                .background(Color.appBackground)
                
                // Content
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
}

// MARK: - Tab Button
private struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                Text(title)
                    .font(.system(size: 16, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? .textAccent : .textLavender)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                
                // Underline indicator
                Rectangle()
                    .fill(isSelected ? Color.textAccent : Color.clear)
                    .frame(height: 2)
            }
        }
        .background(Color.appBackground)
    }
}

#Preview {
    StakeWrapContainerView(address: "0x1234567890abcdef")
}
