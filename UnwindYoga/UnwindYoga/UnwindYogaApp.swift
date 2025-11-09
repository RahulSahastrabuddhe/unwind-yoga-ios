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
    
    var body: some Scene {
        WindowGroup {
            if authService.isAuthenticated {
                HomeView()
                    .environmentObject(authService)
            } else {
                WelcomeView()
            }
        }
    }
}
