//
//  MainTabView.swift
//  UnwindYoga
//
//  Main tab bar navigation with Home, Library, Progress, Profile
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authService: AuthService
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            HomeTabView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                            .font(.system(size: 24))
                        Text("Home")
                            .font(.system(size: 10))
                    }
                }
                .tag(0)
            
            // Library Tab
            LibraryTabView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 1 ? "books.vertical.fill" : "books.vertical")
                            .font(.system(size: 24))
                        Text("Library")
                            .font(.system(size: 10))
                    }
                }
                .tag(1)
            
            // Progress Tab
            ProgressTabView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 2 ? "chart.line.uptrend.xyaxis" : "chart.line.uptrend.xyaxis")
                            .font(.system(size: 24))
                        Text("Progress")
                            .font(.system(size: 10))
                    }
                }
                .tag(2)
            
            // Profile Tab
            ProfileTabView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 3 ? "person.fill" : "person")
                            .font(.system(size: 24))
                        Text("Profile")
                            .font(.system(size: 10))
                    }
                }
                .tag(3)
        }
        .accentColor(Theme.Colors.primary)
    }
}

#Preview {
    MainTabView()
        .environmentObject(AuthService())
}
