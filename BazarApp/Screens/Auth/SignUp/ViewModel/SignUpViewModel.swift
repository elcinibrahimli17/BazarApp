//
//  SignUpViewModel.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//

import Foundation
import Observation

@MainActor
@Observable
final class SignUpViewModel {
    var name = ""
    var email = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol = FirebaseAuthService()) {
        self.authService = authService
    }

    var hasMinLength: Bool {
        password.count >= 8
    }
    
    var hasNumber: Bool {
        password.contains(where: \.isNumber)
    }
    
    var hasLetter: Bool {
        password.contains(where: \.isLetter)
    }

    var isPasswordValid: Bool {
        hasMinLength && hasNumber && hasLetter
    }

    var shouldShowPasswordRules: Bool {
        !password.isEmpty && !isPasswordValid
    }

    private var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var trimmedEmail: String {
        email.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isFormValid: Bool {
        !trimmedName.isEmpty && !trimmedEmail.isEmpty && isPasswordValid
    }
    
    var canRegister: Bool {
        isFormValid && !isLoading
    }

    func signUp() async -> Bool {
        guard isFormValid else { return false }

        isLoading = true
        defer {
            isLoading = false
        }

        do {
            try await authService.signUp(
                name: trimmedName,
                email: trimmedEmail,
                password: password
            )
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
