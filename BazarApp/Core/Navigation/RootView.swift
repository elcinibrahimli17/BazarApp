//
//  RootView.swift
//  BazarApp
//
//  Created by Elchın on 22.10.26.
//

import SwiftUI

struct RootView: View {
    @State private var router = AppRouter()

    var body: some View {
        Group {
            switch router.root {
            case .splash:
                SplashView()
            case .onboarding:
                OnboardingView()
            case .auth:
                NavigationStack(path: $router.authPath) {
                    SignInView()
                        .authDestinations()
                }
            case .main:
                MainView()
            }
        }
        .environment(router)
    }
}

#Preview {
    RootView()
}
