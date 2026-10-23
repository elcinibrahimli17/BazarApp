//
//  SplashView.swift
//  BazarApp
//
//  Created by Elchın on 22.10.26.
//

import SwiftUI

struct SplashView: View {
    @Environment(AppRouter.self) private var router
    @AppStorage(StorageKeys.hasSeenOnboarding) private var hasSeenOnboarding = false
    @State private var isLogoVisible = false

    var body: some View {
        ZStack {
            Color(.brandPrimary)
                .ignoresSafeArea()

            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 158, height: 44)
                .scaleEffect(isLogoVisible ? 1 : 0.6)
                .opacity(isLogoVisible ? 1 : 0)
        }
        .task {
            withAnimation(.spring(duration: 2, bounce: 0.5)) {
                isLogoVisible = true
            }

            try? await Task.sleep(for: .seconds(2))

            withAnimation {
                router.root = hasSeenOnboarding ? .auth : .onboarding
            }
        }
    }
}

#Preview {
    SplashView()
        .environment(AppRouter())
}
