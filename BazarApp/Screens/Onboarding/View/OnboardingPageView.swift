//
//  OnboardingPageView.swift
//  BazarApp
//
//  Created by Elchın on 22.10.26.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: 24) {
            Image(page.image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
                .padding(.horizontal, 24)

            Text(page.title)
                .font(.appTitle)
                .tracking(-0.72)
                .lineSpacing(8)
                .foregroundStyle(Color(.appTitle))
                .padding(.horizontal, 66)

            Text(page.description)
                .font(.appBody)
                .lineSpacing(8)
                .foregroundStyle(Color(.appBody))
                .padding(.horizontal, 41)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    OnboardingPageView(page: OnboardingPage.pages[0])
}
