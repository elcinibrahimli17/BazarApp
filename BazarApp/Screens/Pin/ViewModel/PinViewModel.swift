//
//  PinViewModel.swift
//  BazarApp
//
//  Created by Elchın on 27.10.26.
//


import Foundation
import Observation

@MainActor
@Observable
final class PinViewModel {

    enum Step {
        case enter
        case confirm
    }

    static let pinLength = 4
    static let maxAttempts = 5

    var pin = ""
    private(set) var step: Step = .enter
    private(set) var errorMessage: String?
    private(set) var shakeTrigger = 0
    private var failedAttempts = 0

    let mode: PinMode
    private var firstPin = ""
    private let pinService: PinServiceProtocol
    private let sessionService: SessionServiceProtocol

    init(
        mode: PinMode,
        pinService: PinServiceProtocol = KeychainPinService(),
        sessionService: SessionServiceProtocol? = nil
    ) {
        self.mode = mode
        self.pinService = pinService
        self.sessionService = sessionService ?? SessionService()
    }

    var title: String {
        switch (mode, step) {
        case (.unlock, _):
            "Enter PIN"
        case (.create, .enter):
            "Create PIN"
        case (.create, .confirm):
            "Confirm PIN"
        }
    }

    var subtitle: String {
        switch (mode, step) {
        case (.unlock, _):
            "Enter your 4-digit PIN to continue"
        case (.create, .enter):
            "Create a 4-digit PIN to secure your account"
        case (.create, .confirm):
            "Re-enter your PIN to confirm"
        }
    }

    var canShowForgotPin: Bool {
        mode == .unlock
    }

    var isPinComplete: Bool {
        pin.count == Self.pinLength
    }

    func submit() -> PinResult {
        guard isPinComplete else { return .incomplete }
        errorMessage = nil

        switch mode {
        case .unlock:
            return handleUnlock()
        case .create:
            return handleCreate()
        }
    }

    func forgotPin() -> PinResult {
        logout()
    }

    private func handleUnlock() -> PinResult {
        if pinService.verifyPin(pin) {
            failedAttempts = 0
            return .success
        }

        failedAttempts += 1
        let remaining = Self.maxAttempts - failedAttempts

        guard remaining > 0 else {
            return logout()
        }

        let word = remaining == 1 ? "attempt" : "attempts"
        fail(with: "Wrong PIN. \(remaining) \(word) left.")
        return .incomplete
    }

    private func handleCreate() -> PinResult {
        switch step {
        case .enter:
            firstPin = pin
            pin = ""
            step = .confirm
            return .incomplete

        case .confirm:
            guard pin == firstPin else {
                firstPin = ""
                step = .enter
                fail(with: "PINs don't match. Please try again.")
                return .incomplete
            }

            do {
                try pinService.savePin(pin)
                return .success
            } catch {
                fail(with: error.localizedDescription)
                return .incomplete
            }
        }
    }

    private func logout() -> PinResult {
        do {
            try sessionService.logout()
            return .loggedOut
        } catch {
            fail(with: error.localizedDescription)
            return .incomplete
        }
    }

    private func fail(with message: String) {
        errorMessage = message
        pin = ""
        shakeTrigger += 1
    }
}
