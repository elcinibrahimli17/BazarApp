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
    @State private var viewModel = SplashViewModel()
    @State private var isLogoVisible = false

    var body: some View {
        ZStack {
            background
            logo
        }
        .task {
            await start()
        }
    }
}

private extension SplashView {
    var background: some View {
        Color(.brandPrimary)
            .ignoresSafeArea()
    }

    var logo: some View {
        Image(.logo)
            .resizable()
            .scaledToFit()
            .frame(width: 158, height: 44)
            .scaleEffect(isLogoVisible ? 1 : 0.6)
            .opacity(isLogoVisible ? 1 : 0)
    }
}

private extension SplashView {
    func start() async {
        withAnimation(.spring(duration: 2, bounce: 0.5)) {
            isLogoVisible = true
        }

        try? await Task.sleep(for: .seconds(2))

        withAnimation {
            router.root = viewModel.initialRoot(hasSeenOnboarding: hasSeenOnboarding)
        }
    }
}

#Preview {
    SplashView()
        .environment(AppRouter())
}
