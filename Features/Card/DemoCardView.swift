//
//  DemoCardView.swift
//  EtherFiTracker
//

import SwiftUI

struct DemoCardView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Hero Section
                VStack(spacing: 16) {
                    Image(systemName: "creditcard.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("Your DeFi-native credit card is finally here")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    Text("The non-custodial, cashback credit card you've been waiting for.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {}) {
                        Text("Get the Card")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 32)
                
                Divider()
                    .padding(.vertical)
                
                // Features
                VStack(spacing: 20) {
                    FeatureCard(
                        title: "Use Your Crypto",
                        description: "Use your ether.fi crypto balance with Cash to spend with your card. Repay anytime, no monthly minimums."
                    )
                    
                    FeatureCard(
                        title: "Non-custodial & secure",
                        description: "Stay in control with on-chain features. Your crypto remains in your control."
                    )
                    
                    FeatureCard(
                        title: "Load from fiat or any wallet",
                        description: "Use your traditional bank accounts and exchanges to send and receive assets with your ether.fi Cash account."
                    )
                    
                    FeatureCard(
                        title: "Cash Back on all purchases",
                        description: "Earn cash back instantly, anywhere you spend with your card—automatically added to your account!"
                    )
                    
                    FeatureCard(
                        title: "Exclusive members-only rewards",
                        description: "Travel and DeFi rewards, conference passes and additional 1% Cash Back on every purchase made by your referrals."
                    )
                    
                    FeatureCard(
                        title: "Credit card flexibility",
                        description: "Virtual and physical cards you can use for groceries, gas, hotels—whatever you need."
                    )
                }
                .padding(.horizontal)
                
                // Disclaimer
                VStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.orange)
                    
                    Text("⚠️ This is a non-functional demo screen.")
                        .font(.caption)
                        .bold()
                    
                    Text("No actual card application will be processed.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
        }
    }
}

// Feature Card Component
private struct FeatureCard: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    DemoCardView()
}
