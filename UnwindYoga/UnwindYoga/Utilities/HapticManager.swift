//
//  HapticManager.swift
//  UnwindYoga
//
//  Manages haptic feedback for better user experience
//

import UIKit
import SwiftUI

class HapticManager {
    static let shared = HapticManager()
    
    private init() {}
    
    // Light impact - for selections, taps
    func light() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    // Medium impact - for confirmations
    func medium() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    // Heavy impact - for important actions
    func heavy() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    // Success - for completed actions
    func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    // Warning - for caution
    func warning() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    // Error - for errors
    func error() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    // Selection - for picker/tab changes
    func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}

// MARK: - View Extension for Easy Access
extension View {
    func haptic(_ style: HapticStyle) -> some View {
        self.onTapGesture {
            switch style {
            case .light: HapticManager.shared.light()
            case .medium: HapticManager.shared.medium()
            case .heavy: HapticManager.shared.heavy()
            case .success: HapticManager.shared.success()
            case .warning: HapticManager.shared.warning()
            case .error: HapticManager.shared.error()
            case .selection: HapticManager.shared.selection()
            }
        }
    }
}

enum HapticStyle {
    case light, medium, heavy, success, warning, error, selection
}
