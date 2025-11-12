//
//  TokenIcons.swift
//  EtherFiTracker
//

import SwiftUI

// MARK: - ETH Icon
struct ETHIcon: View {
    var size: CGFloat = 30
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .fill(Color(hex: "627EEA").opacity(0.31))
                .frame(width: size * 1.2, height: size * 1.2)
            
            // ETH Diamond
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                let centerX = width / 2
                let centerY = height / 2
                
                ZStack {
                    // Top left
                    Path { path in
                        path.move(to: CGPoint(x: centerX, y: centerY * 0.25))
                        path.addLine(to: CGPoint(x: centerX * 0.5625, y: centerY * 1.0138))
                        path.addLine(to: CGPoint(x: centerX, y: centerY * 0.8042))
                        path.closeSubpath()
                    }
                    .fill(Color.white)
                    
                    // Top right
                    Path { path in
                        path.move(to: CGPoint(x: centerX, y: centerY * 0.25))
                        path.addLine(to: CGPoint(x: centerX, y: centerY * 0.8042))
                        path.addLine(to: CGPoint(x: centerX * 1.4988, y: centerY * 1.0138))
                        path.closeSubpath()
                    }
                    .fill(Color.white.opacity(0.602))
                    
                    // Middle left
                    Path { path in
                        path.move(to: CGPoint(x: centerX * 0.5625, y: centerY * 1.0138))
                        path.addLine(to: CGPoint(x: centerX, y: centerY * 1.2858))
                        path.addLine(to: CGPoint(x: centerX, y: centerY * 0.8042))
                        path.closeSubpath()
                    }
                    .fill(Color.white.opacity(0.602))
                    
                    // Middle right
                    Path { path in
                        path.move(to: CGPoint(x: centerX, y: centerY * 0.8042))
                        path.addLine(to: CGPoint(x: centerX, y: centerY * 1.2858))
                        path.addLine(to: CGPoint(x: centerX * 1.4988, y: centerY * 1.0138))
                        path.closeSubpath()
                    }
                    .fill(Color.white.opacity(0.2))
                    
                    // Bottom left
                    Path { path in
                        path.move(to: CGPoint(x: centerX, y: centerY * 1.7465))
                        path.addLine(to: CGPoint(x: centerX, y: centerY * 1.373))
                        path.addLine(to: CGPoint(x: centerX * 0.5625, y: centerY * 1.1009))
                        path.closeSubpath()
                    }
                    .fill(Color.white)
                    
                    // Bottom right
                    Path { path in
                        path.move(to: CGPoint(x: centerX, y: centerY * 1.373))
                        path.addLine(to: CGPoint(x: centerX, y: centerY * 1.7465))
                        path.addLine(to: CGPoint(x: centerX * 1.5, y: centerY * 1.101))
                        path.closeSubpath()
                    }
                    .fill(Color.white.opacity(0.602))
                }
            }
            .frame(width: size * 0.96, height: size * 0.96)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Ethereum Chain Icon (for headers)
struct EthereumChainIcon: View {
    var size: CGFloat = 24
    
    var body: some View {
        Canvas { context, canvasSize in
            let scale = canvasSize.width / 81.0
            
            // Top left piece
            var topLeft = Path()
            topLeft.move(to: CGPoint(x: 40.3917 * scale, y: 3.36246 * scale))
            topLeft.addLine(to: CGPoint(x: 17.9042 * scale, y: 40.6791 * scale))
            topLeft.addLine(to: CGPoint(x: 40.3917 * scale, y: 30.4583 * scale))
            topLeft.closeSubpath()
            context.fill(topLeft, with: .color(Color(hex: "8A92B2")))
            
            // Bottom left piece
            var bottomLeft = Path()
            bottomLeft.move(to: CGPoint(x: 40.3917 * scale, y: 30.4583 * scale))
            bottomLeft.addLine(to: CGPoint(x: 17.9042 * scale, y: 40.6791 * scale))
            bottomLeft.addLine(to: CGPoint(x: 40.3917 * scale, y: 53.975 * scale))
            bottomLeft.closeSubpath()
            context.fill(bottomLeft, with: .color(Color(hex: "8A92B2")))
            
            // Top right piece
            var topRight = Path()
            topRight.move(to: CGPoint(x: 62.8833 * scale, y: 40.6791 * scale))
            topRight.addLine(to: CGPoint(x: 40.3917 * scale, y: 3.36246 * scale))
            topRight.addLine(to: CGPoint(x: 40.3917 * scale, y: 30.4583 * scale))
            topRight.closeSubpath()
            context.fill(topRight, with: .color(Color(hex: "62688F")))
            
            // Bottom right piece
            var bottomRight = Path()
            bottomRight.move(to: CGPoint(x: 40.3917 * scale, y: 53.975 * scale))
            bottomRight.addLine(to: CGPoint(x: 62.8834 * scale, y: 40.6791 * scale))
            bottomRight.addLine(to: CGPoint(x: 40.3917 * scale, y: 30.4583 * scale))
            bottomRight.closeSubpath()
            context.fill(bottomRight, with: .color(Color(hex: "454A75")))
            
            // Bottom left extension
            var bottomLeftExt = Path()
            bottomLeftExt.move(to: CGPoint(x: 17.9042 * scale, y: 44.9458 * scale))
            bottomLeftExt.addLine(to: CGPoint(x: 40.3917 * scale, y: 76.6375 * scale))
            bottomLeftExt.addLine(to: CGPoint(x: 40.3917 * scale, y: 58.2333 * scale))
            bottomLeftExt.closeSubpath()
            context.fill(bottomLeftExt, with: .color(Color(hex: "8A92B2")))
            
            // Bottom right extension
            var bottomRightExt = Path()
            bottomRightExt.move(to: CGPoint(x: 40.3917 * scale, y: 58.2333 * scale))
            bottomRightExt.addLine(to: CGPoint(x: 40.3917 * scale, y: 76.6375 * scale))
            bottomRightExt.addLine(to: CGPoint(x: 62.8959 * scale, y: 44.9458 * scale))
            bottomRightExt.closeSubpath()
            context.fill(bottomRightExt, with: .color(Color(hex: "62688F")))
        }
        .frame(width: size, height: size)
    }
}

// MARK: - eETH Icon
struct EETHIcon: View {
    var size: CGFloat = 30
    
    var body: some View {
        ZStack {
            // Background circle with gradient
            Circle()
                .fill(
                    LinearGradient(
                        stops: [
                            .init(color: Color(hex: "211D60"), location: 0),
                            .init(color: Color(hex: "1D1534"), location: 1)
                        ],
                        startPoint: .init(x: 0.633, y: -0.05),
                        endPoint: .init(x: 0.37, y: 1.023)
                    )
                )
                .frame(width: size * 1.5, height: size * 1.5)
            
            // eETH icon path
            Canvas { context, canvasSize in
                let scale = canvasSize.width / 32.0
                
                // Create the main path with gradient
                var path = Path()
                
                // Main shape outline (simplified but accurate representation)
                // Top section
                path.move(to: CGPoint(x: 22.792 * scale, y: 22.53 * scale))
                path.addLine(to: CGPoint(x: 22.795 * scale, y: 22.567 * scale))
                path.addCurve(
                    to: CGPoint(x: 22.664 * scale, y: 22.802 * scale),
                    control1: CGPoint(x: 22.795 * scale, y: 22.698 * scale),
                    control2: CGPoint(x: 22.73 * scale, y: 22.76 * scale)
                )
                path.addLine(to: CGPoint(x: 16.108 * scale, y: 26.845 * scale))
                path.addCurve(
                    to: CGPoint(x: 15.819 * scale, y: 26.845 * scale),
                    control1: CGPoint(x: 15.997 * scale, y: 26.918 * scale),
                    control2: CGPoint(x: 15.93 * scale, y: 26.918 * scale)
                )
                path.addLine(to: CGPoint(x: 9.316 * scale, y: 22.853 * scale))
                path.addCurve(
                    to: CGPoint(x: 9.186 * scale, y: 22.593 * scale),
                    control1: CGPoint(x: 9.186 * scale, y: 22.78 * scale),
                    control2: CGPoint(x: 9.186 * scale, y: 22.69 * scale)
                )
                path.addLine(to: CGPoint(x: 9.185 * scale, y: 17.561 * scale))
                path.addCurve(
                    to: CGPoint(x: 9.598 * scale, y: 17.305 * scale),
                    control1: CGPoint(x: 9.185 * scale, y: 17.378 * scale),
                    control2: CGPoint(x: 9.3 * scale, y: 17.32 * scale)
                )
                path.addLine(to: CGPoint(x: 15.988 * scale, y: 21.014 * scale))
                path.addLine(to: CGPoint(x: 22.319 * scale, y: 17.341 * scale))
                path.addLine(to: CGPoint(x: 22.351 * scale, y: 17.324 * scale))
                path.addCurve(
                    to: CGPoint(x: 22.794 * scale, y: 17.542 * scale),
                    control1: CGPoint(x: 22.794 * scale, y: 17.277 * scale),
                    control2: CGPoint(x: 22.794 * scale, y: 17.4 * scale)
                )
                path.addLine(to: CGPoint(x: 22.794 * scale, y: 22.492 * scale))
                path.closeSubpath()
                
                // Bottom left triangle
                path.move(to: CGPoint(x: 9.735 * scale, y: 22.13 * scale))
                path.addLine(to: CGPoint(x: 11.625 * scale, y: 20.99 * scale))
                path.addLine(to: CGPoint(x: 9.735 * scale, y: 18.39 * scale))
                path.closeSubpath()
                
                // Bottom section
                path.move(to: CGPoint(x: 11.949 * scale, y: 21.437 * scale))
                path.addLine(to: CGPoint(x: 9.989 * scale, y: 22.62 * scale))
                path.addLine(to: CGPoint(x: 15.079 * scale, y: 25.745 * scale))
                path.addLine(to: CGPoint(x: 15.079 * scale, y: 21.437 * scale))
                path.closeSubpath()
                
                // Right bottom section
                path.move(to: CGPoint(x: 16.936 * scale, y: 25.687 * scale))
                path.addLine(to: CGPoint(x: 21.99 * scale, y: 22.571 * scale))
                path.addLine(to: CGPoint(x: 20.038 * scale, y: 21.397 * scale))
                path.closeSubpath()
                
                // Right triangle
                path.move(to: CGPoint(x: 20.361 * scale, y: 20.949 * scale))
                path.addLine(to: CGPoint(x: 22.244 * scale, y: 22.081 * scale))
                path.addLine(to: CGPoint(x: 22.244 * scale, y: 18.344 * scale))
                path.closeSubpath()
                
                // Middle section
                path.move(to: CGPoint(x: 15.85 * scale, y: 21.569 * scale))
                path.addLine(to: CGPoint(x: 10.448 * scale, y: 18.434 * scale))
                path.addLine(to: CGPoint(x: 15.988 * scale, y: 26.06 * scale))
                path.addLine(to: CGPoint(x: 21.477 * scale, y: 18.466 * scale))
                path.addLine(to: CGPoint(x: 16.127 * scale, y: 21.57 * scale))
                path.closeSubpath()
                
                // Top section - main body
                path.move(to: CGPoint(x: 9.184 * scale, y: 15.964 * scale))
                path.addLine(to: CGPoint(x: 9.184 * scale, y: 9.482 * scale))
                path.addCurve(
                    to: CGPoint(x: 9.188 * scale, y: 9.435 * scale),
                    control1: CGPoint(x: 9.184 * scale, y: 9.458 * scale),
                    control2: CGPoint(x: 9.186 * scale, y: 9.446 * scale)
                )
                path.addCurve(
                    to: CGPoint(x: 9.315 * scale, y: 9.154 * scale),
                    control1: CGPoint(x: 9.204 * scale, y: 9.325 * scale),
                    control2: CGPoint(x: 9.25 * scale, y: 9.23 * scale)
                )
                path.addLine(to: CGPoint(x: 15.872 * scale, y: 5.133 * scale))
                path.addCurve(
                    to: CGPoint(x: 16.159 * scale, y: 5.133 * scale),
                    control1: CGPoint(x: 15.943 * scale, y: 5.09 * scale),
                    control2: CGPoint(x: 16.05 * scale, y: 5.09 * scale)
                )
                path.addLine(to: CGPoint(x: 22.662 * scale, y: 9.103 * scale))
                path.addCurve(
                    to: CGPoint(x: 22.794 * scale, y: 9.338 * scale),
                    control1: CGPoint(x: 22.794 * scale, y: 9.178 * scale),
                    control2: CGPoint(x: 22.794 * scale, y: 9.26 * scale)
                )
                path.addLine(to: CGPoint(x: 22.794 * scale, y: 15.932 * scale))
                path.addCurve(
                    to: CGPoint(x: 22.62 * scale, y: 16.187 * scale),
                    control1: CGPoint(x: 22.794 * scale, y: 16.083 * scale),
                    control2: CGPoint(x: 22.72 * scale, y: 16.15 * scale)
                )
                path.addLine(to: CGPoint(x: 16.12 * scale, y: 19.763 * scale))
                path.addCurve(
                    to: CGPoint(x: 15.855 * scale, y: 19.763 * scale),
                    control1: CGPoint(x: 16.038 * scale, y: 19.813 * scale),
                    control2: CGPoint(x: 15.94 * scale, y: 19.813 * scale)
                )
                path.addLine(to: CGPoint(x: 9.45 * scale, y: 16.239 * scale))
                path.closeSubpath()
                
                // Upper triangles
                path.move(to: CGPoint(x: 9.734 * scale, y: 9.874 * scale))
                path.addLine(to: CGPoint(x: 9.734 * scale, y: 15.091 * scale))
                path.addLine(to: CGPoint(x: 12.073 * scale, y: 11.28 * scale))
                path.closeSubpath()
                
                path.move(to: CGPoint(x: 22.244 * scale, y: 9.824 * scale))
                path.addLine(to: CGPoint(x: 19.884 * scale, y: 11.25 * scale))
                path.addLine(to: CGPoint(x: 22.244 * scale, y: 15.097 * scale))
                path.closeSubpath()
                
                path.move(to: CGPoint(x: 19.595 * scale, y: 11.781 * scale))
                path.addLine(to: CGPoint(x: 21.988 * scale, y: 10.335 * scale))
                path.addLine(to: CGPoint(x: 16.744 * scale, y: 7.133 * scale))
                path.closeSubpath()
                
                path.move(to: CGPoint(x: 15.193 * scale, y: 6.193 * scale))
                path.addLine(to: CGPoint(x: 9.99 * scale, y: 9.385 * scale))
                path.addLine(to: CGPoint(x: 12.362 * scale, y: 10.811 * scale))
                path.closeSubpath()
                
                // Center diamond
                path.move(to: CGPoint(x: 9.907 * scale, y: 15.863 * scale))
                path.addLine(to: CGPoint(x: 15.987 * scale, y: 19.207 * scale))
                path.addLine(to: CGPoint(x: 22.067 * scale, y: 15.862 * scale))
                path.addLine(to: CGPoint(x: 16.047 * scale, y: 5.952 * scale))
                path.closeSubpath()
                
                // Apply gradient
                let gradient = Gradient(stops: [
                    .init(color: Color(hex: "29BCFA"), location: 0),
                    .init(color: Color(hex: "6464E4"), location: 0.43),
                    .init(color: Color(hex: "B45AFA"), location: 1)
                ])
                
                let startPoint = CGPoint(x: 15.888 * scale, y: 26.506 * scale)
                let endPoint = CGPoint(x: 22.669 * scale, y: 9.476 * scale)
                
                context.fill(
                    path,
                    with: .linearGradient(
                        gradient,
                        startPoint: startPoint,
                        endPoint: endPoint
                    )
                )
            }
            .frame(width: size * 1.14, height: size * 1.14)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - weETH Icon
struct WEETHIcon: View {
    var size: CGFloat = 30
    
    var body: some View {
        ZStack {
            // Background gradient circle
            Circle()
                .fill(
                    LinearGradient(
                        stops: [
                            .init(color: Color(hex: "29BCFA"), location: 0),
                            .init(color: Color(hex: "6464E4"), location: 0.43),
                            .init(color: Color(hex: "B45AFA"), location: 1)
                        ],
                        startPoint: UnitPoint(x: 0.069, y: 0.656),
                        endPoint: UnitPoint(x: 0.935, y: 0.342)
                    )
                )
                .frame(width: size * 1.2, height: size * 1.2)
            
            // Overlay gradient with opacity
            Circle()
                .fill(
                    LinearGradient(
                        stops: [
                            .init(color: Color(hex: "33117B").opacity(0), location: 0),
                            .init(color: Color(hex: "33117B"), location: 0.827)
                        ],
                        startPoint: UnitPoint(x: 0.531, y: -0.0625),
                        endPoint: UnitPoint(x: 0.5, y: 1.0)
                    )
                )
                .opacity(0.66)
                .frame(width: size * 1.2, height: size * 1.2)
            
            // Main weETH icon path
            Canvas { context, canvasSize in
                let scale = canvasSize.width / 32.0
                let offsetX = 8.531 * scale
                let offsetY = 4.047 * scale
                
                var path = Path()
                
                // Main shape (translated by group offset)
                path.move(to: CGPoint(x: 14.912 * scale + offsetX, y: 19.109 * scale + offsetY))
                path.addLine(to: CGPoint(x: 14.915 * scale + offsetX, y: 19.149 * scale + offsetY))
                path.addCurve(
                    to: CGPoint(x: 14.772 * scale + offsetX, y: 19.409 * scale + offsetY),
                    control1: CGPoint(x: 14.915 * scale + offsetX, y: 19.258 * scale + offsetY),
                    control2: CGPoint(x: 14.858 * scale + offsetX, y: 19.359 * scale + offsetY)
                )
                path.addLine(to: CGPoint(x: 7.588 * scale + offsetX, y: 23.838 * scale + offsetY))
                path.addCurve(
                    to: CGPoint(x: 7.272 * scale + offsetX, y: 23.838 * scale + offsetY),
                    control1: CGPoint(x: 7.49 * scale + offsetX, y: 23.898 * scale + offsetY),
                    control2: CGPoint(x: 7.37 * scale + offsetX, y: 23.898 * scale + offsetY)
                )
                path.addLine(to: CGPoint(x: 0.146 * scale + offsetX, y: 19.464 * scale + offsetY))
                path.addCurve(
                    to: CGPoint(x: 0.003 * scale + offsetX, y: 19.178 * scale + offsetY),
                    control1: CGPoint(x: 0.057 * scale + offsetX, y: 19.409 * scale + offsetY),
                    control2: CGPoint(x: 0.003 * scale + offsetX, y: 19.331 * scale + offsetY)
                )
                path.addLine(to: CGPoint(x: 0.002 * scale + offsetX, y: 19.149 * scale + offsetY))
                path.addLine(to: CGPoint(x: 0.002 * scale + offsetX, y: 13.664 * scale + offsetY))
                path.addCurve(
                    to: CGPoint(x: 0.454 * scale + offsetX, y: 13.384 * scale + offsetY),
                    control1: CGPoint(x: 0.002 * scale + offsetX, y: 13.462 * scale + offsetY),
                    control2: CGPoint(x: 0.218 * scale + offsetX, y: 13.334 * scale + offsetY)
                )
                path.addLine(to: CGPoint(x: 7.457 * scale + offsetX, y: 17.448 * scale + offsetY))
                path.addLine(to: CGPoint(x: 14.394 * scale + offsetX, y: 13.423 * scale + offsetY))
                path.addLine(to: CGPoint(x: 14.429 * scale + offsetX, y: 13.405 * scale + offsetY))
                path.addCurve(
                    to: CGPoint(x: 14.914 * scale + offsetX, y: 13.644 * scale + offsetY),
                    control1: CGPoint(x: 14.664 * scale + offsetX, y: 13.359 * scale + offsetY),
                    control2: CGPoint(x: 14.914 * scale + offsetX, y: 13.491 * scale + offsetY)
                )
                path.addLine(to: CGPoint(x: 14.915 * scale + offsetX, y: 19.067 * scale + offsetY))
                path.closeSubpath()
                
                // Left triangle
                path.move(to: CGPoint(x: 0.605 * scale + offsetX, y: 18.673 * scale + offsetY))
                path.addLine(to: CGPoint(x: 2.675 * scale + offsetX, y: 17.423 * scale + offsetY))
                path.addLine(to: CGPoint(x: 0.605 * scale + offsetX, y: 14.573 * scale + offsetY))
                path.closeSubpath()
                
                // Bottom left section
                path.move(to: CGPoint(x: 3.03 * scale + offsetX, y: 17.913 * scale + offsetY))
                path.addLine(to: CGPoint(x: 0.883 * scale + offsetX, y: 19.21 * scale + offsetY))
                path.addLine(to: CGPoint(x: 6.46 * scale + offsetX, y: 22.634 * scale + offsetY))
                path.closeSubpath()
                
                // Bottom right section
                path.move(to: CGPoint(x: 8.496 * scale + offsetX, y: 22.571 * scale + offsetY))
                path.addLine(to: CGPoint(x: 14.034 * scale + offsetX, y: 19.155 * scale + offsetY))
                path.addLine(to: CGPoint(x: 11.894 * scale + offsetX, y: 17.869 * scale + offsetY))
                path.closeSubpath()
                
                // Right triangle
                path.move(to: CGPoint(x: 12.248 * scale + offsetX, y: 17.378 * scale + offsetY))
                path.addLine(to: CGPoint(x: 14.312 * scale + offsetX, y: 18.619 * scale + offsetY))
                path.addLine(to: CGPoint(x: 14.312 * scale + offsetX, y: 14.523 * scale + offsetY))
                path.closeSubpath()
                
                // Center diamond
                path.move(to: CGPoint(x: 7.305 * scale + offsetX, y: 18.058 * scale + offsetY))
                path.addLine(to: CGPoint(x: 1.385 * scale + offsetX, y: 14.622 * scale + offsetY))
                path.addLine(to: CGPoint(x: 7.456 * scale + offsetX, y: 22.979 * scale + offsetY))
                path.addLine(to: CGPoint(x: 13.471 * scale + offsetX, y: 14.657 * scale + offsetY))
                path.addLine(to: CGPoint(x: 7.608 * scale + offsetX, y: 18.058 * scale + offsetY))
                path.closeSubpath()
                
                // Top section
                path.move(to: CGPoint(x: 0.293 * scale + offsetX, y: 12.218 * scale + offsetY))
                path.addCurve(
                    to: CGPoint(x: 0.585 * scale + offsetX, y: 11.916 * scale + offsetY),
                    control1: CGPoint(x: 0.293 * scale + offsetX, y: 12.088 * scale + offsetY),
                    control2: CGPoint(x: 0.38 * scale + offsetX, y: 11.974 * scale + offsetY)
                )
                path.addLine(to: CGPoint(x: 0.585 * scale + offsetX, y: 4.811 * scale + offsetY))
                path.addCurve(
                    to: CGPoint(x: 0.589 * scale + offsetX, y: 4.759 * scale + offsetY),
                    control1: CGPoint(x: 0.585 * scale + offsetX, y: 4.793 * scale + offsetY),
                    control2: CGPoint(x: 0.587 * scale + offsetX, y: 4.775 * scale + offsetY)
                )
                path.addCurve(
                    to: CGPoint(x: 0.729 * scale + offsetX, y: 4.451 * scale + offsetY),
                    control1: CGPoint(x: 0.609 * scale + offsetX, y: 4.629 * scale + offsetY),
                    control2: CGPoint(x: 0.696 * scale + offsetX, y: 4.519 * scale + offsetY)
                )
                path.addLine(to: CGPoint(x: 7.913 * scale + offsetX, y: 0.043 * scale + offsetY))
                path.addCurve(
                    to: CGPoint(x: 8.227 * scale + offsetX, y: 0.043 * scale + offsetY),
                    control1: CGPoint(x: 8.01 * scale + offsetX, y: -0.014 * scale + offsetY),
                    control2: CGPoint(x: 8.13 * scale + offsetX, y: -0.014 * scale + offsetY)
                )
                path.addLine(to: CGPoint(x: 15.354 * scale + offsetX, y: 4.393 * scale + offsetY))
                path.addCurve(
                    to: CGPoint(x: 15.498 * scale + offsetX, y: 4.652 * scale + offsetY),
                    control1: CGPoint(x: 15.444 * scale + offsetX, y: 4.449 * scale + offsetY),
                    control2: CGPoint(x: 15.498 * scale + offsetX, y: 4.547 * scale + offsetY)
                )
                path.addLine(to: CGPoint(x: 15.498 * scale + offsetX, y: 11.877 * scale + offsetY))
                path.addCurve(
                    to: CGPoint(x: 15.308 * scale + offsetX, y: 12.157 * scale + offsetY),
                    control1: CGPoint(x: 15.498 * scale + offsetX, y: 12.004 * scale + offsetY),
                    control2: CGPoint(x: 15.42 * scale + offsetX, y: 12.113 * scale + offsetY)
                )
                path.addLine(to: CGPoint(x: 8.186 * scale + offsetX, y: 16.075 * scale + offsetY))
                path.addCurve(
                    to: CGPoint(x: 7.896 * scale + offsetX, y: 16.075 * scale + offsetY),
                    control1: CGPoint(x: 8.096 * scale + offsetX, y: 16.125 * scale + offsetY),
                    control2: CGPoint(x: 7.986 * scale + offsetX, y: 16.125 * scale + offsetY)
                )
                path.addLine(to: CGPoint(x: 0.774 * scale + offsetX, y: 12.157 * scale + offsetY))
                path.closeSubpath()
                
                // Upper left triangle
                path.move(to: CGPoint(x: 0.603 * scale + offsetX, y: 5.242 * scale + offsetY))
                path.addLine(to: CGPoint(x: 0.604 * scale + offsetX, y: 10.958 * scale + offsetY))
                path.addLine(to: CGPoint(x: 3.166 * scale + offsetX, y: 6.783 * scale + offsetY))
                path.closeSubpath()
                
                // Upper right triangle
                path.move(to: CGPoint(x: 14.311 * scale + offsetX, y: 5.188 * scale + offsetY))
                path.addLine(to: CGPoint(x: 11.725 * scale + offsetX, y: 6.75 * scale + offsetY))
                path.addLine(to: CGPoint(x: 14.312 * scale + offsetX, y: 10.966 * scale + offsetY))
                path.closeSubpath()
                
                // Upper right section
                path.move(to: CGPoint(x: 11.41 * scale + offsetX, y: 6.236 * scale + offsetY))
                path.addLine(to: CGPoint(x: 14.032 * scale + offsetX, y: 4.652 * scale + offsetY))
                path.addLine(to: CGPoint(x: 8.284 * scale + offsetX, y: 1.142 * scale + offsetY))
                path.closeSubpath()
                
                // Upper left section
                path.move(to: CGPoint(x: 6.586 * scale + offsetX, y: 1.208 * scale + offsetY))
                path.addLine(to: CGPoint(x: 0.883 * scale + offsetX, y: 4.705 * scale + offsetY))
                path.addLine(to: CGPoint(x: 3.482 * scale + offsetX, y: 6.268 * scale + offsetY))
                path.closeSubpath()
                
                // Center top diamond
                path.move(to: CGPoint(x: 0.793 * scale + offsetX, y: 11.803 * scale + offsetY))
                path.addLine(to: CGPoint(x: 7.456 * scale + offsetX, y: 15.468 * scale + offsetY))
                path.addLine(to: CGPoint(x: 14.119 * scale + offsetX, y: 11.803 * scale + offsetY))
                path.addLine(to: CGPoint(x: 7.455 * scale + offsetX, y: 0.943 * scale + offsetY))
                path.closeSubpath()
                
                context.fill(path, with: .color(Color(hex: "D7CDFF")))
            }
            .frame(width: size * 1.14, height: size * 1.14)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Token Icon Selector
struct TokenIcon: View {
    let symbol: String
    var size: CGFloat = 50
    
    var body: some View {
        switch symbol.uppercased() {
        case "ETH":
            ETHIcon(size: size)
        case "EETH":
            EETHIcon(size: size)
        case "WEETH":
            WEETHIcon(size: size)
        default:
            Image(systemName: "questionmark.circle.fill")
                .resizable()
                .frame(width: size, height: size)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Preview
#Preview("All Icons") {
    VStack(spacing: 20) {
        Text("Token Icons")
            .font(.title)
        
        HStack(spacing: 30) {
            VStack {
                ETHIcon(size: 60)
                Text("ETH")
            }
            
            VStack {
                EETHIcon(size: 60)
                Text("eETH")
            }
            
            VStack {
                WEETHIcon(size: 60)
                Text("weETH")
            }
        }
        
        Divider()
        
        Text("Small Size")
            .font(.headline)
        
        HStack(spacing: 20) {
            TokenIcon(symbol: "ETH", size: 24)
            TokenIcon(symbol: "eETH", size: 24)
            TokenIcon(symbol: "weETH", size: 24)
        }
    }
    .padding()
    .background(Color.appBackground)
}
