//
//  CustomButton.swift
//  UnwindYoga
//
//  Reusable custom button component
//

import SwiftUI

struct CustomButton: View {
    let title: String
    let action: () -> Void
    var style: ButtonStyle = .primary
    var isFullWidth: Bool = true
    
    enum ButtonStyle {
        case primary
        case secondary
        case outline
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Theme.Typography.headline)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: isFullWidth ? .infinity : nil)
                .frame(height: 56)
                .background(backgroundColor)
                .cornerRadius(Theme.CornerRadius.medium)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.CornerRadius.medium)
                        .stroke(borderColor, lineWidth: style == .outline ? 2 : 0)
                )
        }
    }
    
    private var backgroundColor: Color {
        switch style {
        case .primary:
            return Theme.Colors.primary
        case .secondary:
            return Theme.Colors.primary.opacity(0.1)
        case .outline:
            return Color.clear
        }
    }
    
    private var foregroundColor: Color {
        switch style {
        case .primary:
            return .white
        case .secondary, .outline:
            return Theme.Colors.primary
        }
    }
    
    private var borderColor: Color {
        style == .outline ? Theme.Colors.primary : Color.clear
    }
}

#Preview {
    VStack(spacing: 16) {
        CustomButton(title: "Primary Button", action: {})
        CustomButton(title: "Secondary Button", action: {}, style: .secondary)
        CustomButton(title: "Outline Button", action: {}, style: .outline)
    }
    .padding()
    .background(Theme.Colors.background)
}
