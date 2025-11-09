//
//  PoseListView.swift
//  UnwindYoga
//
//  Full-screen pose list (navigated from Home's "Browse More Poses")
//

import SwiftUI

struct PoseListView: View {
    @State private var poses = YogaPose.samplePoses
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss
    
    var filteredPoses: [YogaPose] {
        if searchText.isEmpty {
            return poses
        }
        return poses.filter { pose in
            pose.name.localizedCaseInsensitiveContains(searchText) ||
            pose.sanskritName.localizedCaseInsensitiveContains(searchText)
        }
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
                    
                    Text("All Poses")
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

#Preview {
    NavigationStack {
        PoseListView()
    }
}
