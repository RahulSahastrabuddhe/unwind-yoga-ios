//
//  PoseDetailView.swift
//  UnwindYoga
//
//  Detailed view for individual yoga pose
//

import SwiftUI

struct PoseDetailView: View {
    let pose: YogaPose
    @Environment(\.dismiss) var dismiss
    @State private var isFavorite = false
    
    var body: some View {
        ZStack {
            Theme.Colors.background
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Header Image
                    ZStack(alignment: .topLeading) {
                        // Placeholder image with gradient
                        LinearGradient(
                            colors: [Theme.Colors.primary.opacity(0.3), Theme.Colors.primary.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: 300)
                        
                        // Yoga icon overlay
                        Image(systemName: "figure.yoga")
                            .font(.system(size: 100))
                            .foregroundColor(.white.opacity(0.5))
                            .frame(maxWidth: .infinity, maxHeight: 300)
                        
                        // Back button
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(Theme.Spacing.sm)
                                .background(Color.black.opacity(0.3))
                                .clipShape(Circle())
                        }
                        .padding(Theme.Spacing.lg)
                    }
                    
                    // Content
                    VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                        // Title and Info
                        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(pose.name)
                                        .font(Theme.Typography.title1)
                                        .foregroundColor(Theme.Colors.textPrimary)
                                    
                                    Text(pose.sanskritName)
                                        .font(Theme.Typography.title3)
                                        .foregroundColor(Theme.Colors.textSecondary)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    isFavorite.toggle()
                                }) {
                                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                                        .font(.title2)
                                        .foregroundColor(isFavorite ? .red : Theme.Colors.textSecondary)
                                }
                            }
                            
                            HStack(spacing: Theme.Spacing.md) {
                                InfoPill(icon: "clock", text: "\(pose.duration)s")
                                InfoPill(icon: "chart.bar", text: pose.difficulty.rawValue)
                                InfoPill(icon: "tag", text: pose.category.rawValue)
                            }
                        }
                        
                        Divider()
                        
                        // Description
                        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                            Text("Description")
                                .font(Theme.Typography.title3)
                                .foregroundColor(Theme.Colors.textPrimary)
                            
                            Text(pose.description)
                                .font(Theme.Typography.body)
                                .foregroundColor(Theme.Colors.textSecondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        Divider()
                        
                        // Benefits
                        VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                            Text("Benefits")
                                .font(Theme.Typography.title3)
                                .foregroundColor(Theme.Colors.textPrimary)
                            
                            VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                                ForEach(pose.benefits, id: \.self) { benefit in
                                    HStack(alignment: .top, spacing: Theme.Spacing.sm) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(Theme.Colors.primary)
                                            .font(.body)
                                        
                                        Text(benefit)
                                            .font(Theme.Typography.body)
                                            .foregroundColor(Theme.Colors.textSecondary)
                                    }
                                }
                            }
                        }
                        
                        // Action Button
                        CustomButton(title: "Try This Pose") {
                            // Handle start pose
                        }
                        .padding(.top, Theme.Spacing.md)
                    }
                    .padding(Theme.Spacing.lg)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Info Pill
struct InfoPill: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
            
            Text(text)
                .font(Theme.Typography.caption)
        }
        .foregroundColor(Theme.Colors.textSecondary)
        .padding(.horizontal, Theme.Spacing.sm)
        .padding(.vertical, 6)
        .background(Color.white)
        .cornerRadius(Theme.CornerRadius.small)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.CornerRadius.small)
                .stroke(Theme.Colors.textSecondary.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    NavigationStack {
        PoseDetailView(pose: YogaPose.samplePoses[0])
    }
}
