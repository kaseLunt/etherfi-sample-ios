//
//  SwapComponents.swift
//  EtherFiTracker
//

import SwiftUI

// MARK: - Constants
struct SwapConstants {
    static let maxDigits = 16
    static let displayDigits = 12
    static let decimalPlaces = 4
}

struct SwapSpacing {
    static let small: CGFloat = 8
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
    static let cardPadding: CGFloat = 24
    static let inputHeight: CGFloat = 36
    static let buttonHeight: CGFloat = 52
    static let swapIconSize: CGFloat = 48
    static let iconSize: CGFloat = 24
}

// MARK: - Utility Functions
func limitToMaxDigits(_ value: String, maxDigits: Int = SwapConstants.maxDigits) -> String {
    let cleaned = value.filter { $0.isNumber || $0 == "." }
    let parts = cleaned.split(separator: ".")
    if parts.count > 2 { return String(value.dropLast()) }
    
    let totalDigits = cleaned.replacingOccurrences(of: ".", with: "").count
    return totalDigits <= maxDigits ? cleaned : String(value.dropLast())
}

func formatToMaxDigits(_ value: Double, maxDigits: Int = SwapConstants.maxDigits) -> String {
    let stringValue = String(value)
    let digitsOnly = stringValue.replacingOccurrences(of: ".", with: "")
    
    if digitsOnly.count <= maxDigits {
        return stringValue
    }
    
    let parts = stringValue.split(separator: ".")
    if parts.count == 1 {
        return String(parts[0].prefix(maxDigits))
    } else {
        let beforeDecimal = String(parts[0])
        let remainingDigits = maxDigits - beforeDecimal.count
        if remainingDigits > 0 {
            return beforeDecimal + "." + String(parts[1].prefix(remainingDigits))
        } else {
            return String(beforeDecimal.prefix(maxDigits))
        }
    }
}

func isValidAmount(_ amount: String, maxBalance: Double) -> Bool {
    guard !amount.isEmpty, amount != "0", amount != "." else { return false }
    guard let value = Double(amount) else { return false }
    return value > 0 && value <= maxBalance
}

// MARK: - Gradient Divider
struct GradientDivider: View {
    var body: some View {
        Rectangle()
            .fill(LinearGradient.dividerGradient)
            .frame(height: 1)
    }
}

// MARK: - Token Input Box
struct TokenInputBox: View {
    @Binding var value: String
    let tokenSymbol: String
    let balance: Double
    let price: Double
    let isLoading: Bool
    let onMaxClick: () -> Void
    
    private var usdValue: Double {
        (Double(value) ?? 0.0) * price
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Input Row
            HStack(alignment: .center) {
                TextField("0", text: $value)
                    .keyboardType(.decimalPad)
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.textLavender)
                    .onChange(of: value) { oldValue, newValue in
                        value = limitToMaxDigits(newValue)
                    }
                
                Spacer()
                
                Button("MAX") {
                    onMaxClick()
                }
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.textAccent)
                .padding(.horizontal, 4)
                
                HStack(spacing: 6) {
                    TokenIcon(symbol: tokenSymbol, size: 24)
                    
                    Text(tokenSymbol)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.textLavender)
                }
            }
            .frame(height: SwapSpacing.inputHeight)
            
            GradientDivider()
                .padding(.vertical, 12)
            
            // Balance Row
            HStack {
                Text(usdValue, format: .currency(code: "USD"))
                    .font(.system(size: 14))
                    .foregroundColor(.textLavender.opacity(0.5))
                
                Spacer()
                
                if isLoading {
                    ProgressView()
                        .scaleEffect(0.8)
                } else {
                    Text("Balance \(balance, specifier: "%.4f")")
                        .font(.system(size: 14))
                        .foregroundColor(.textLavender.opacity(0.5))
                }
            }
            .frame(height: SwapSpacing.inputHeight)
        }
        .padding(SwapSpacing.medium)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient.inputBoxGradient)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.cardBorder, lineWidth: 1)
        )
    }
}

// MARK: - Token Display Box
struct TokenDisplayBox: View {
    let value: String
    let tokenSymbol: String
    let balance: Double
    let price: Double
    
    private var usdValue: Double {
        (Double(value) ?? 0.0) * price
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Display Row
            HStack {
                Text(value.isEmpty ? "0" : value)
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.textLavender)
                
                Spacer()
                
                HStack(spacing: 6) {
                    TokenIcon(symbol: tokenSymbol, size: 24)
                    
                    Text(tokenSymbol)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.textLavender)
                }
            }
            .frame(height: SwapSpacing.inputHeight)
            
            GradientDivider()
                .padding(.vertical, 12)
            
            // Balance Row
            HStack {
                Text(usdValue, format: .currency(code: "USD"))
                    .font(.system(size: 14))
                    .foregroundColor(.textLavender.opacity(0.5))
                
                Spacer()
                
                Text("Balance \(balance, specifier: "%.4f")")
                    .font(.system(size: 14))
                    .foregroundColor(.textLavender.opacity(0.5))
            }
            .frame(height: SwapSpacing.inputHeight)
        }
        .padding(SwapSpacing.medium)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient.inputBoxGradient)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.cardBorder, lineWidth: 1)
        )
    }
}

// MARK: - Swap Icon Button
struct SwapIconButton: View {
    let action: () -> Void
    @State private var isHovered = false
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.up.arrow.down")
                .font(.system(size: SwapSpacing.iconSize))
                .foregroundColor(isHovered ? .textAccent : .textAccent.opacity(0.9))
                .frame(width: SwapSpacing.swapIconSize, height: SwapSpacing.swapIconSize)
                .background(Color.cardBackground)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(
                            isHovered ? Color.textAccent.opacity(0.7) : Color.textAccent.opacity(0.4),
                            lineWidth: 1.5
                        )
                )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Section Label
struct SectionLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.textLavender.opacity(0.7))
    }
}

// MARK: - Action Button
struct ActionButton: View {
    let text: String
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(isEnabled ? .white : .white.opacity(0.5))
                .frame(maxWidth: .infinity)
                .frame(height: SwapSpacing.buttonHeight)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            isEnabled ?
                            LinearGradient.primaryGradient :
                            LinearGradient(
                                colors: [
                                    .gradientStart.opacity(0.3),
                                    .gradientMiddle.opacity(0.3),
                                    .gradientEnd.opacity(0.3)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
        }
        .disabled(!isEnabled)
        .buttonStyle(.plain)
    }
}

// MARK: - Disclaimer Card
struct DisclaimerCard: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 14))
            .foregroundColor(.textLavender.opacity(0.6))
            .multilineTextAlignment(.center)
            .padding(SwapSpacing.medium)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.cardBackgroundLight.opacity(0.5))
            )
    }
}
