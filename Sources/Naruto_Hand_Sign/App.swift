//
//  App.swift
//  Naruto_Hand_Sign
//
//  Created by Muhammadjon on 19/02/25.
//

import SwiftUI

@main
struct NarutoHandSignApp: App {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                NavigationStack {
                    HomeView()
                }
                
            } else {
                OnboardingView()
            }
        }
    }
}
