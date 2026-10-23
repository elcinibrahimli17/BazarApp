//
//  OnboardingPage.swift
//  BazarApp
//
//  Created by Elchın on 22.10.26.
//


import SwiftUI

struct OnboardingPage: Identifiable {
    let id = UUID()
    let image: ImageResource
    let title: String
    let description: String
}

extension OnboardingPage {
    static let pages: [OnboardingPage] = [
        OnboardingPage(
            image: .onboarding1,
            title: "Now reading books will be easier",
            description: "Discover new worlds, join a vibrant reading community. Start your reading adventure effortlessly with us."
        ),
        OnboardingPage(
            image: .onboarding2,
            title: "Your Bookish Soulmate Awaits",
            description: "Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience."
        ),
        OnboardingPage(
            image: .onboarding3,
            title: "Start Your Adventure",
            description: "Ready to embark on a quest for inspiration and knowledge? Your adventure begins now. Let's go!"
        )
    ]
}