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
    
    // Calendar state
    @State private var selectedDate = Date()
    @State private var currentMonth = 0
    @State private var showWeekView = false
    
    // Sample completed sessions data
    private let completedDates: [Date] = [
        Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
        Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
        Calendar.current.date(byAdding: .day, value: -5, to: Date())!
    ]
    
    // Get current month dates
    private func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else { return Date() }
        return currentMonth
    }
    
    // Extract date
    private func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        // Add offset to get the correct weekday (0 = Sunday, 1 = Monday, etc.)
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        let offset = firstWeekday - 1
        
        for _ in 0..<offset {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
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
                                        // Background circle
                                        Circle()
                                            .stroke(Theme.Colors.primary.opacity(0.15), lineWidth: 14)
                                            .frame(width: 160, height: 160)
                                        
                                        // Progress circle
                                        Circle()
                                            .trim(from: 0, to: CGFloat(completedSessions) / CGFloat(weeklyGoal))
                                            .stroke(
                                                LinearGradient(
                                                    colors: [Theme.Colors.primary.opacity(0.8), Theme.Colors.primary],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                style: StrokeStyle(lineWidth: 14, lineCap: .round)
                                            )
                                            .frame(width: 160, height: 160)
                                            .rotationEffect(.degrees(-90))
                                            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: completedSessions)
                                        
                                        VStack(spacing: 6) {
                                            Text("\(completedSessions)/\(weeklyGoal)")
                                                .font(.system(size: 36, weight: .bold))
                                                .foregroundColor(Theme.Colors.textPrimary)
                                            
                                            Text("Weekly Goal")
                                                .font(.system(size: 13, weight: .medium))
                                                .foregroundColor(Theme.Colors.textSecondary)
                                        }
                                    }
                                    .padding(.vertical, Theme.Spacing.xl)
                                }
                                
                                // Stats Grid
                                HStack(spacing: Theme.Spacing.md) {
                                    StatBox(icon: "figure.run", value: "0", label: "Lifetime exercise\nsessions", color: .green)
                                    StatBox(icon: "bolt.fill", value: "0", label: "Weekly goal\nstreak", color: .orange)
                                }
                                .padding(.horizontal, Theme.Spacing.lg)
                                
                                // Calendar Section
                                VStack(spacing: Theme.Spacing.md) {
                                    // Header with month and navigation
                                    HStack {
                                        Text(getCurrentMonth().toString("MMMM yyyy"))
                                            .font(Theme.Typography.title3)
                                            .fontWeight(.semibold)
                                        
                                        Spacer()
                                        
                                        HStack(spacing: 16) {
                                            Button(action: { withAnimation { currentMonth -= 1 } }) {
                                                Image(systemName: "chevron.left")
                                                    .font(.subheadline)
                                                    .foregroundColor(Theme.Colors.textPrimary)
                                            }
                                            
                                            Button("Today") {
                                                withAnimation { currentMonth = 0 }
                                            }
                                            .font(.caption)
                                            .foregroundColor(Theme.Colors.primary)
                                            
                                            Button(action: { withAnimation { currentMonth += 1 } }) {
                                                Image(systemName: "chevron.right")
                                                    .font(.subheadline)
                                                    .foregroundColor(Theme.Colors.textPrimary)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, Theme.Spacing.lg)
                                    
                                    // Weekday Header
                                    HStack(spacing: 0) {
                                        ForEach(["S", "M", "T", "W", "T", "F", "S"], id: \.self) { day in
                                            Text(day)
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(Theme.Colors.textSecondary)
                                                .frame(maxWidth: .infinity)
                                                .padding(.vertical, 8)
                                        }
                                    }
                                    .padding(.horizontal, Theme.Spacing.lg)
                                    
                                    // Calendar Grid
                                    VStack(spacing: 8) {
                                        let columns = Array(repeating: GridItem(.flexible()), count: 7)
                                        LazyVGrid(columns: columns, spacing: 8) {
                                            ForEach(extractDate(), id: \.self) { value in
                                                if value.day != -1 {
                                                    let isToday = Calendar.current.isDateInToday(value.date)
                                                    let isCompleted = completedDates.contains { Calendar.current.isDate($0, inSameDayAs: value.date) }
                                                    let isCurrentMonth = Calendar.current.isDate(value.date, equalTo: getCurrentMonth(), toGranularity: .month)
                                                    
                                                    VStack(spacing: 4) {
                                                        Text("\(value.day)")
                                                            .font(.system(size: 14, weight: isToday ? .bold : .regular))
                                                            .foregroundColor(
                                                                isToday ? .white : 
                                                                (isCompleted ? Theme.Colors.primary : 
                                                                    (isCurrentMonth ? Theme.Colors.textPrimary : Theme.Colors.textSecondary))
                                                            )
                                                            .frame(width: 28, height: 28)
                                                            .background(
                                                                isToday ? 
                                                                Circle().fill(Theme.Colors.primary) : 
                                                                (isCompleted ? 
                                                                    Circle().fill(Theme.Colors.primary.opacity(0.1)) : 
                                                                    nil)
                                                            )
                                                            .opacity(isCurrentMonth ? 1 : 0.5)
                                                        
                                                        if isCompleted {
                                                            Circle()
                                                                .fill(Theme.Colors.primary)
                                                                .frame(width: 4, height: 4)
                                                        } else {
                                                            Spacer().frame(height: 4)
                                                        }
                                                    }
                                                    .frame(height: 40)
                                                    .onTapGesture { selectedDate = value.date }
                                                } else {
                                                    Spacer().frame(height: 40)
                                                }
                                            }
                                        }
                                        .padding(.horizontal, Theme.Spacing.lg)
                                    }
                                }
                                .padding(.vertical, Theme.Spacing.lg)
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
