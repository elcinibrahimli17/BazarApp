//
//  AuthServiceProtocol.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//


import Foundation
import FirebaseAuth

@MainActor
protocol AuthServiceProtocol {
    var isLoggedIn: Bool { get }
    func signIn(email: String, password: String) async throws
    func signUp(name: String, email: String, password: String) async throws
    func signOut() throws
}

final class FirebaseAuthService: AuthServiceProtocol {
    
    nonisolated init() {}

    var isLoggedIn: Bool {
        Auth.auth().currentUser != nil
    }

    func signIn(email: String, password: String) async throws {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            throw AuthError(error)
        }
    }

    func signUp(name: String, email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)

            let changeRequest = result.user.createProfileChangeRequest()
            changeRequest.displayName = name
            try await changeRequest.commitChanges()
        } catch {
            throw AuthError(error)
        }
    }

    func signOut() throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw AuthError(error)
        }
    }
}
