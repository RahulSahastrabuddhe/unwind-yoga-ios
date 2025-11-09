//
//  LibraryTabView.swift
//  UnwindYoga
//
//  Library tab content with pose cards
//

import SwiftUI

struct LibraryTabView: View {
    @State private var poses = YogaPose.samplePoses
    @State private var searchText = ""
    @State private var selectedDifficulty: YogaPose.Difficulty?
    
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
        
        return filtered
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.Colors.background
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Library")
                            .font(Theme.Typography.title1)
                            .foregroundColor(Theme.Colors.textPrimary)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "slider.horizontal.3")
                                .font(.title3)
                                .foregroundColor(Theme.Colors.textPrimary)
                        }
                    }
                    .padding(.horizontal, Theme.Spacing.lg)
                    .padding(.top, Theme.Spacing.lg)
                    .padding(.bottom, Theme.Spacing.md)
                    
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
                                isSelected: selectedDifficulty == nil,
                                action: {
                                    selectedDifficulty = nil
                                }
                            )
                            
                            ForEach(YogaPose.Difficulty.allCases, id: \.self) { difficulty in
                                FilterChip(
                                    title: difficulty.rawValue,
                                    isSelected: selectedDifficulty == difficulty,
                                    action: {
                                        selectedDifficulty = selectedDifficulty == difficulty ? nil : difficulty
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, Theme.Spacing.lg)
                    }
                    .padding(.bottom, Theme.Spacing.md)
                    
                    // Poses Grid/List
                    ScrollView {
                        LazyVStack(spacing: Theme.Spacing.md) {
                            ForEach(filteredPoses) { pose in
                                NavigationLink(destination: PoseDetailView(pose: pose)) {
                                    LibraryPoseCard(pose: pose)
                                }
                            }
                        }
                        .padding(.horizontal, Theme.Spacing.lg)
                        .padding(.bottom, 100) // Extra padding for tab bar
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Library Pose Card (with play button like in Figma)
struct LibraryPoseCard: View {
    let pose: YogaPose
    
    var body: some View {
        HStack(spacing: Theme.Spacing.md) {
            // Pose Image/Icon
            ZStack {
                RoundedRectangle(cornerRadius: Theme.CornerRadius.medium)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 80, height: 80)
                
                Image(systemName: "figure.yoga")
                    .font(.title)
                    .foregroundColor(Theme.Colors.textSecondary)
            }
            
            // Pose Info
            VStack(alignment: .leading, spacing: 6) {
                Text(pose.name)
                    .font(Theme.Typography.headline)
                    .foregroundColor(Theme.Colors.textPrimary)
                
                Text(pose.sanskritName)
                    .font(Theme.Typography.subheadline)
                    .foregroundColor(Theme.Colors.textSecondary)
                
                HStack(spacing: Theme.Spacing.sm) {
                    Text(pose.difficulty.rawValue)
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                    
                    Text("•")
                        .foregroundColor(Theme.Colors.textSecondary)
                    
                    Text("\(pose.duration)s")
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                }
            }
            
            Spacer()
            
            // Play Button
            Button(action: {}) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    
                    Image(systemName: "play.fill")
                        .font(.system(size: 14))
                        .foregroundColor(Theme.Colors.textPrimary)
                }
            }
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

#Preview {
    LibraryTabView()
}
