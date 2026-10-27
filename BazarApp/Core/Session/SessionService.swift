//
//  SessionService.swift
//  BazarApp
//
//  Created by Elchın on 27.10.26.
//


import Foundation

final class SessionService: SessionServiceProtocol {
    private let authService: AuthServiceProtocol
    private let pinService: PinServiceProtocol

    init(
        authService: AuthServiceProtocol = FirebaseAuthService(),
        pinService: PinServiceProtocol = KeychainPinService()
    ) {
        self.authService = authService
        self.pinService = pinService
    }

    func logout() throws {
        try authService.signOut()
        pinService.deletePin()
    }
}
