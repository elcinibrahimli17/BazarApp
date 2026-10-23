//
//  OnboardingView.swift
//  BazarApp
//
//  Created by Elchın on 22.10.26.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(AppRouter.self) private var router
    @AppStorage(StorageKeys.hasSeenOnboarding) private var hasSeenOnboarding = false
    @State private var currentPage = 0
    private let pages = OnboardingPage.pages

    private var isLastPage: Bool {
        currentPage == pages.count - 1
    }

    var body: some View {
        VStack(spacing: 0) {
            skipButton
            pagesView
            PageIndicator(count: pages.count, currentIndex: currentPage)
                .padding(.vertical, 24)
            actionButtons
        }
        .padding(.bottom, 16)
    }

    private var skipButton: some View {
        HStack {
            Button("Skip") {
                withAnimation {
                    currentPage = pages.count - 1
                }
            }
            .font(.link)
            .foregroundStyle(Color(.brandPrimary))
            .opacity(isLastPage ? 0 : 1)
            .disabled(isLastPage)

            Spacer()
        }
        .padding(.horizontal, 24)
        .frame(height: 44)
    }

    private var pagesView: some View {
        TabView(selection: $currentPage) {
            ForEach(pages.indices, id: \.self) { index in
                OnboardingPageView(page: pages[index])
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }

    private var actionButtons: some View {
        VStack(spacing: 8) {
            Button(isLastPage ? "Get Started" : "Continue") {
                primaryAction()
            }
            .primaryButtonStyle()

            Button("Sign in") {
                finishOnboarding()
            }
            .secondaryButtonStyle()
        }
        .padding(.horizontal, 24)
    }

    private func primaryAction() {
        if isLastPage {
            finishOnboarding()
        } else {
            withAnimation {
                currentPage += 1
            }
        }
    }

    private func finishOnboarding() {
        hasSeenOnboarding = true
        router.authPath = []
        withAnimation {
            router.root = .auth
        }
    }
}

#Preview {
    OnboardingView()
        .environment(AppRouter())
}

