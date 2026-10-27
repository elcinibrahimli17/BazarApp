//
//  SplashViewModel.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//

import Foundation
import Observation

@MainActor
@Observable
final class SplashViewModel {
    private let authService: AuthServiceProtocol
    private let pinService: PinServiceProtocol

    init(
        authService: AuthServiceProtocol = FirebaseAuthService(),
        pinService: PinServiceProtocol = KeychainPinService()
    ) {
        self.authService = authService
        self.pinService = pinService
    }

    func initialRoot(hasSeenOnboarding: Bool) -> AppRoot {
        if authService.isLoggedIn {
            return pinService.hasPin ? .pin(.unlock) : .pin(.create)
        }
        return hasSeenOnboarding ? .auth : .onboarding
    }
}
