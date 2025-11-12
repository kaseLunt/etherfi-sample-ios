//
//  DemoCardView.swift
//  EtherFiTracker
//

import SwiftUI

struct DemoCardView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header Section
                CardHeaderSection()
                
                Divider()
                    .background(Color.cardScreenDivider)
                    .padding(.vertical)
                
                // Feature Cards
                VStack(spacing: 16) {
                    FeatureCard(
                        title: "Use Your Crypto",
                        description: "Use your ether.fi crypto balance with Cash to spend with your card. Repay anytime, no monthly minimums."
                    )
                    
                    FeatureCard(
                        title: "Non-custodial & secure",
                        description: "Stay in control with on-chain features. Your crypto remains in your control."
                    )
                    
                    FeatureCard(
                        title: "Load your account from fiat or any non-custodial wallet",
                        description: "Use your traditional bank accounts and exchanges to send and receive assets with your ether.fi Cash account."
                    )
                    
                    FeatureCard(
                        title: "Cash Back on all purchases",
                        description: "Earn cash back instantly, anywhere you spend with your card—automatically added to your account!"
                    )
                    
                    FeatureCard(
                        title: "Exclusive members-only rewards with Cash",
                        description: "Travel and DeFi rewards, conference passes and additional 1% Cash Back on every purchase made by your referrals."
                    )
                    
                    FeatureCard(
                        title: "Credit card flexibility",
                        description: "Virtual and physical cards you can use for groceries, gas, hotels—whatever you need."
                    )
                }
                
                // Disclaimer
                DisclaimerCard(text: "⚠️ This is a non-functional demo screen.\nNo actual card application will be processed.")
            }
            .padding(16)
        }
        .background(Color.cardScreenBackground)
    }
}

// MARK: - Card Header Section
private struct CardHeaderSection: View {
    var body: some View {
        VStack(spacing: 16) {
            // Card Image - Replace with actual card_gold image
            Image(systemName: "creditcard.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.etherFiGold, .etherFiGold.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            // Main Headline
            Text("Your DeFi-native credit card is finally here")
                .font(.system(size: 28))
                .foregroundColor(Color(hex: "C8AB7A"))
                .multilineTextAlignment(.center)
            
            // Subtitle
            Text("The non-custodial, cashback credit card you've been waiting for.")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.textLavender)
                .multilineTextAlignment(.center)
            
            // CTA Button
            Button(action: {}) {
                Text("Get the Card")
                    .font(.system(size: 14, weight: .medium))
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(LinearGradient.primaryGradient)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
    }
}

// MARK: - Feature Card
private struct FeatureCard: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 28))
                .foregroundColor(Color(hex: "C8AB7A"))
            
            Text(description)
                .font(.system(size: 14))
                .foregroundColor(.textLavender)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(Color.cardScreenBackground)
        .cornerRadius(12)
    }
}

#Preview {
    DemoCardView()
}
