//
//  LibraryView.swift
//  UnwindYoga
//
//  Library view showing all yoga poses
//

import SwiftUI

struct LibraryView: View {
    @State private var poses = YogaPose.samplePoses
    @State private var searchText = ""
    @State private var selectedDifficulty: YogaPose.Difficulty?
    @State private var selectedCategory: YogaPose.Category?
    @Environment(\.dismiss) var dismiss
    
    var filteredPoses: [YogaPose] {
        var filtered = poses
        
        if !searchText.isEmpty {
            filtered = filtered.filter { pose in
                pose.name.localizedCaseInsensitiveContains(searchText) ||
                pose.sanskritName.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        if let difficulty = selectedDifficulty {
            filtered = filtered.filter { $0.difficulty == difficulty }
        }
        
        if let category = selectedCategory {
            filtered = filtered.filter { $0.category == category }
        }
        
        return filtered
    }
    
    var body: some View {
        ZStack {
            Theme.Colors.background
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Theme.Colors.textPrimary)
                    }
                    
                    Spacer()
                    
                    Text("Library")
                        .font(Theme.Typography.title2)
                        .foregroundColor(Theme.Colors.textPrimary)
                    
                    Spacer()
                    
                    // Placeholder for symmetry
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .opacity(0)
                }
                .padding(.horizontal, Theme.Spacing.lg)
                .padding(.vertical, Theme.Spacing.md)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Theme.Colors.textSecondary)
                    
                    TextField("Search poses...", text: $searchText)
                        .font(Theme.Typography.body)
                        .foregroundColor(Theme.Colors.textPrimary)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(Theme.CornerRadius.medium)
                .padding(.horizontal, Theme.Spacing.lg)
                .padding(.bottom, Theme.Spacing.md)
                
                // Filters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Theme.Spacing.sm) {
                        FilterChip(
                            title: "All",
                            isSelected: selectedDifficulty == nil && selectedCategory == nil,
                            action: {
                                selectedDifficulty = nil
                                selectedCategory = nil
                            }
                        )
                        
                        ForEach(YogaPose.Difficulty.allCases, id: \.self) { difficulty in
                            FilterChip(
                                title: difficulty.rawValue,
                                isSelected: selectedDifficulty == difficulty,
                                action: {
                                    selectedDifficulty = selectedDifficulty == difficulty ? nil : difficulty
                                    selectedCategory = nil
                                }
                            )
                        }
                    }
                    .padding(.horizontal, Theme.Spacing.lg)
                }
                .padding(.bottom, Theme.Spacing.md)
                
                // Poses List
                ScrollView {
                    LazyVStack(spacing: Theme.Spacing.md) {
                        ForEach(filteredPoses) { pose in
                            NavigationLink(destination: PoseDetailView(pose: pose)) {
                                PoseCard(pose: pose)
                            }
                        }
                    }
                    .padding(.horizontal, Theme.Spacing.lg)
                    .padding(.bottom, Theme.Spacing.xl)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Filter Chip
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Theme.Typography.subheadline)
                .foregroundColor(isSelected ? .white : Theme.Colors.textPrimary)
                .padding(.horizontal, Theme.Spacing.md)
                .padding(.vertical, Theme.Spacing.sm)
                .background(isSelected ? Theme.Colors.primary : Color.white)
                .cornerRadius(Theme.CornerRadius.large)
        }
    }
}

// MARK: - Pose Card
struct PoseCard: View {
    let pose: YogaPose
    
    var body: some View {
        HStack(spacing: Theme.Spacing.md) {
            // Pose Icon/Image
            ZStack {
                Circle()
                    .fill(Theme.Colors.primary.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: "figure.yoga")
                    .font(.title2)
                    .foregroundColor(Theme.Colors.primary)
            }
            
            // Pose Info
            VStack(alignment: .leading, spacing: 4) {
                Text(pose.name)
                    .font(Theme.Typography.headline)
                    .foregroundColor(Theme.Colors.textPrimary)
                
                Text(pose.sanskritName)
                    .font(Theme.Typography.subheadline)
                    .foregroundColor(Theme.Colors.textSecondary)
                
                HStack(spacing: Theme.Spacing.sm) {
                    DifficultyBadge(difficulty: pose.difficulty)
                    
                    Text("•")
                        .foregroundColor(Theme.Colors.textSecondary)
                    
                    Text("\(pose.duration)s")
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(Theme.Colors.textSecondary)
        }
        .padding(Theme.Spacing.md)
        .background(Color.white)
        .cornerRadius(Theme.CornerRadius.medium)
        .shadow(
            color: Theme.Shadow.small.color,
            radius: Theme.Shadow.small.radius,
            x: Theme.Shadow.small.x,
            y: Theme.Shadow.small.y
        )
    }
}

// MARK: - Difficulty Badge
struct DifficultyBadge: View {
    let difficulty: YogaPose.Difficulty
    
    var color: Color {
        switch difficulty {
        case .beginner:
            return .green
        case .intermediate:
            return .orange
        case .advanced:
            return .red
        }
    }
    
    var body: some View {
        Text(difficulty.rawValue)
            .font(Theme.Typography.caption)
            .foregroundColor(color)
            .padding(.horizontal, Theme.Spacing.sm)
            .padding(.vertical, 2)
            .background(color.opacity(0.1))
            .cornerRadius(4)
    }
}

#Preview {
    NavigationStack {
        LibraryView()
    }
}
