//
//  UnwindYogaApp.swift
//  UnwindYoga
//
//  Created by Rahul Sahastrabuddhe on 11/9/25.
//

import SwiftUI

@main
struct UnwindYogaApp: App {
    @StateObject private var authService = AuthService()
    @StateObject private var progressService = ProgressService()
    
    var body: some Scene {
        WindowGroup {
            if authService.isAuthenticated {
                MainTabView()
                    .environmentObject(authService)
                    .environmentObject(progressService)
                    .onAppear {
                        // Mark daily activity when user opens the app
                        progressService.markDailyActivity()
                    }
            } else {
                WelcomeView()
                    .environmentObject(authService)
                    .environmentObject(progressService)
            }
        }
    }
}
