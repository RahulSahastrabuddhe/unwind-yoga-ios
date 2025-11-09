//
//  ProgressTabView.swift
//  UnwindYoga
//
//  Progress tab with activity tracking and calendar
//

import SwiftUI

struct ProgressTabView: View {
    @State private var selectedTab = 0
    @State private var weeklyGoal = 5
    @State private var completedSessions = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.Colors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: Theme.Spacing.lg) {
                        // Header
                        HStack {
                            Text("Progress")
                                .font(Theme.Typography.title1)
                                .foregroundColor(Theme.Colors.textPrimary)
                            
                            Spacer()
                        }
                        .padding(.horizontal, Theme.Spacing.lg)
                        .padding(.top, Theme.Spacing.lg)
                        
                        // Tabs: Activity / Achievements
                        HStack(spacing: 0) {
                            TabButton(title: "Activity", isSelected: selectedTab == 0) {
                                selectedTab = 0
                            }
                            
                            TabButton(title: "Achievements", isSelected: selectedTab == 1) {
                                selectedTab = 1
                            }
                        }
                        .padding(.horizontal, Theme.Spacing.lg)
                        
                        if selectedTab == 0 {
                            // Activity Tab Content
                            VStack(spacing: Theme.Spacing.lg) {
                                // Weekly Goal Circle
                                VStack(spacing: Theme.Spacing.md) {
                                    ZStack {
                                        Circle()
                                            .stroke(Theme.Colors.primary.opacity(0.2), lineWidth: 12)
                                            .frame(width: 150, height: 150)
                                        
                                        Circle()
                                            .trim(from: 0, to: CGFloat(completedSessions) / CGFloat(weeklyGoal))
                                            .stroke(Theme.Colors.primary, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                                            .frame(width: 150, height: 150)
                                            .rotationEffect(.degrees(-90))
                                        
                                        VStack(spacing: 4) {
                                            Text("\(completedSessions)/\(weeklyGoal)")
                                                .font(.system(size: 32, weight: .bold))
                                                .foregroundColor(Theme.Colors.textPrimary)
                                            
                                            Text("Weekly Goal")
                                                .font(Theme.Typography.caption)
                                                .foregroundColor(Theme.Colors.textSecondary)
                                        }
                                    }
                                    .padding(.vertical, Theme.Spacing.lg)
                                }
                                
                                // Stats Grid
                                HStack(spacing: Theme.Spacing.md) {
                                    StatBox(icon: "figure.run", value: "0", label: "Lifetime exercise\nsessions", color: .green)
                                    StatBox(icon: "bolt.fill", value: "0", label: "Weekly goal\nstreak", color: .orange)
                                }
                                .padding(.horizontal, Theme.Spacing.lg)
                                
                                // Calendar Section
                                VStack(alignment: .leading, spacing: Theme.Spacing.md) {
                                    HStack {
                                        Button(action: {}) {
                                            Image(systemName: "chevron.left")
                                                .foregroundColor(Theme.Colors.textPrimary)
                                        }
                                        
                                        Spacer()
                                        
                                        Text("September 2025")
                                            .font(Theme.Typography.headline)
                                            .foregroundColor(Theme.Colors.textPrimary)
                                        
                                        Spacer()
                                        
                                        Button(action: {}) {
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Theme.Colors.textPrimary)
                                        }
                                    }
                                    
                                    // Week/Month Toggle
                                    HStack(spacing: Theme.Spacing.sm) {
                                        Text("Week")
                                            .font(Theme.Typography.subheadline)
                                            .foregroundColor(Theme.Colors.textSecondary)
                                            .padding(.horizontal, Theme.Spacing.md)
                                            .padding(.vertical, Theme.Spacing.xs)
                                            .background(Color.white)
                                            .cornerRadius(Theme.CornerRadius.small)
                                        
                                        Text("Month")
                                            .font(Theme.Typography.subheadline)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, Theme.Spacing.md)
                                            .padding(.vertical, Theme.Spacing.xs)
                                            .background(Theme.Colors.textPrimary)
                                            .cornerRadius(Theme.CornerRadius.small)
                                    }
                                    
                                    // Calendar Grid (simplified)
                                    CalendarView()
                                }
                                .padding(Theme.Spacing.lg)
                                .background(Color.white)
                                .cornerRadius(Theme.CornerRadius.large)
                                .padding(.horizontal, Theme.Spacing.lg)
                            }
                        } else {
                            // Achievements Tab Content
                            VStack(spacing: Theme.Spacing.md) {
                                Text("Achievements coming soon!")
                                    .font(Theme.Typography.body)
                                    .foregroundColor(Theme.Colors.textSecondary)
                                    .padding(.top, Theme.Spacing.xxl)
                            }
                        }
                        
                        Spacer(minLength: 100) // Extra space for tab bar
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Tab Button
struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(Theme.Typography.headline)
                    .foregroundColor(isSelected ? Theme.Colors.textPrimary : Theme.Colors.textSecondary)
                
                Rectangle()
                    .fill(isSelected ? Theme.Colors.primary : Color.clear)
                    .frame(height: 2)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Stat Box
struct StatBox: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: Theme.Spacing.sm) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
            }
            
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Theme.Colors.textPrimary)
            
            Text(label)
                .font(Theme.Typography.caption)
                .foregroundColor(Theme.Colors.textSecondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Theme.Spacing.lg)
        .background(Color.white)
        .cornerRadius(Theme.CornerRadius.medium)
    }
}

// MARK: - Calendar View
struct CalendarView: View {
    let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let days = Array(1...30)
    
    var body: some View {
        VStack(spacing: Theme.Spacing.sm) {
            // Days of week header
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(Theme.Typography.caption)
                        .foregroundColor(Theme.Colors.textSecondary)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Calendar grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: Theme.Spacing.sm) {
                ForEach(days, id: \.self) { day in
                    Text("\(day)")
                        .font(Theme.Typography.subheadline)
                        .foregroundColor(Theme.Colors.textPrimary)
                        .frame(width: 32, height: 32)
                        .background(day == 15 ? Theme.Colors.primary : Color.clear)
                        .foregroundColor(day == 15 ? .white : Theme.Colors.textPrimary)
                        .cornerRadius(16)
                }
            }
        }
    }
}

#Preview {
    ProgressTabView()
}
