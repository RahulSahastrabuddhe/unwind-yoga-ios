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
    @State private var showFilters = true
    
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
        
        // Sort by name alphabetically (default)
        return filtered.sorted { $0.name < $1.name }
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
                        
                        Button(action: {
                            withAnimation {
                                showFilters.toggle()
                            }
                        }) {
                            Image(systemName: showFilters ? "slider.horizontal.3" : "line.3.horizontal.decrease.circle")
                                .font(.title3)
                                .foregroundColor(showFilters ? Theme.Colors.primary : Theme.Colors.textPrimary)
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
                    
                    // Filters (toggleable)
                    if showFilters {
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
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    
                    // Poses Grid/List
                    if filteredPoses.isEmpty {
                        EmptyStateView(
                            icon: "figure.yoga",
                            title: "No Poses Found",
                            message: "Try adjusting your search or filters to find what you're looking for.",
                            actionTitle: "Clear Filters",
                            action: {
                                searchText = ""
                                selectedDifficulty = nil
                            }
                        )
                    } else {
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
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Library Pose Card (with play button like in Figma)
struct LibraryPoseCard: View {
    let pose: YogaPose
    
    var difficultyColor: Color {
        switch pose.difficulty {
        case .beginner: return .green
        case .intermediate: return .orange
        case .advanced: return .red
        }
    }
    
    var body: some View {
        HStack(spacing: Theme.Spacing.md) {
            // Pose Image/Icon with gradient
            ZStack {
                RoundedRectangle(cornerRadius: Theme.CornerRadius.medium)
                    .fill(
                        LinearGradient(
                            colors: [Theme.Colors.primary.opacity(0.1), Theme.Colors.primary.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 70, height: 70)
                
                Image(systemName: "figure.yoga")
                    .font(.title2)
                    .foregroundColor(Theme.Colors.primary)
            }
            
            // Pose Info
            VStack(alignment: .leading, spacing: 6) {
                Text(pose.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Theme.Colors.textPrimary)
                    .lineLimit(1)
                
                Text(pose.sanskritName)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Theme.Colors.textSecondary)
                    .lineLimit(1)
                
                HStack(spacing: 6) {
                    // Difficulty badge
                    HStack(spacing: 3) {
                        Circle()
                            .fill(difficultyColor)
                            .frame(width: 6, height: 6)
                        
                        Text(pose.difficulty.rawValue)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(difficultyColor)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(difficultyColor.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Duration
                    HStack(spacing: 3) {
                        Image(systemName: "clock")
                            .font(.system(size: 10))
                        Text("\(pose.duration)s")
                            .font(.system(size: 11, weight: .medium))
                    }
                    .foregroundColor(Theme.Colors.textSecondary)
                }
            }
            
            Spacer()
            
            // Play Button
            Button(action: {}) {
                ZStack {
                    Circle()
                        .fill(Theme.Colors.primary)
                        .frame(width: 36, height: 36)
                    
                    Image(systemName: "play.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .offset(x: 1)
                }
            }
        }
        .padding(Theme.Spacing.md)
        .background(Color.white)
        .cornerRadius(Theme.CornerRadius.medium)
        .shadow(
            color: Color.black.opacity(0.06),
            radius: 8,
            x: 0,
            y: 2
        )
    }
}

#Preview {
    LibraryTabView()
}
