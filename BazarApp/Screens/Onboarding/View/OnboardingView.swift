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

    var body: some View {
        VStack(spacing: 0) {
            skipButton
            pagesView
            pageIndicator
            actionButtons
        }
        .padding(.bottom, 16)
    }
}

private extension OnboardingView {
    var skipButton: some View {
        HStack {
            Button("Skip") {
                skip()
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

    var pagesView: some View {
        TabView(selection: $currentPage) {
            ForEach(pages.indices, id: \.self) { index in
                OnboardingPageView(page: pages[index])
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }

    var pageIndicator: some View {
        PageIndicator(count: pages.count, currentIndex: currentPage)
            .padding(.vertical, 24)
    }

    var actionButtons: some View {
        VStack(spacing: 8) {
            Button(primaryButtonTitle) {
                primaryAction()
            }
            .buttonStyle(.primaryButton())

            Button("Sign in") {
                finishOnboarding()
            }
            .buttonStyle(.secondaryButton())
        }
        .padding(.horizontal, 24)
    }
}

private extension OnboardingView {
    var isLastPage: Bool {
        currentPage == pages.count - 1
    }

    var primaryButtonTitle: String {
        isLastPage ? "Get Started" : "Continue"
    }
}

private extension OnboardingView {
    func skip() {
        withAnimation {
            currentPage = pages.count - 1
        }
    }

    func primaryAction() {
        if isLastPage {
            finishOnboarding()
        } else {
            withAnimation {
                currentPage += 1
            }
        }
    }

    func finishOnboarding() {
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
