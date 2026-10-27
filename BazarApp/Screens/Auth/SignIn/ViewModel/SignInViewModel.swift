//
//  SignInViewModel.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//

import Foundation
import Observation

@MainActor
@Observable
final class SignInViewModel {
    var email = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol = FirebaseAuthService()) {
        self.authService = authService
    }

    var isFormValid: Bool {
        !trimmedEmail.isEmpty && !password.isEmpty
    }
    
    var canLogin: Bool {
        isFormValid && !isLoading
    }

    private var trimmedEmail: String {
        email.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func signIn() async -> Bool {
        guard isFormValid else { return false }

        isLoading = true
        defer { isLoading = false }

        do {
            try await authService.signIn(email: trimmedEmail, password: password)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
