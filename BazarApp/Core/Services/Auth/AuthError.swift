//
//  AuthError.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//


import Foundation
import FirebaseAuth

enum AuthError: LocalizedError {
    case invalidEmail
    case wrongCredentials
    case emailAlreadyInUse
    case weakPassword
    case network
    case tooManyRequests
    case unknown

    init(_ error: Error) {
        let code = AuthErrorCode(rawValue: (error as NSError).code)

        switch code {
        case .invalidEmail:
            self = .invalidEmail
        case .wrongPassword, .userNotFound, .invalidCredential:
            self = .wrongCredentials
        case .emailAlreadyInUse:
            self = .emailAlreadyInUse
        case .weakPassword:
            self = .weakPassword
        case .networkError:
            self = .network
        case .tooManyRequests:
            self = .tooManyRequests
        default:
            self = .unknown
        }
    }

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            "Please enter a valid email address."
        case .wrongCredentials:
            "Email or password is incorrect."
        case .emailAlreadyInUse:
            "This email is already registered."
        case .weakPassword:
            "Password is too weak."
        case .network:
            "Please check your internet connection."
        case .tooManyRequests:
            "Too many attempts. Please try again later."
        case .unknown:
            "Something went wrong. Please try again."
        }
    }
}