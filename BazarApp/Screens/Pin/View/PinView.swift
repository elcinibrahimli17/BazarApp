//
//  PinView.swift
//  BazarApp
//
//  Created by Elchın on 27.10.26.
//


import SwiftUI

struct PinView: View {
    @Environment(AppRouter.self) private var router
    @State private var viewModel: PinViewModel
    @State private var isForgotPinDialogPresented = false

    init(mode: PinMode) {
        _viewModel = State(initialValue: PinViewModel(mode: mode))
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            pinSection
            Spacer()
            numberPad
        }
        .sensoryFeedback(.error, trigger: viewModel.shakeTrigger)
        .onChange(of: viewModel.pin) { _, newPin in
            pinDidChange(newPin)
        }
        .confirmationDialog(
            Constants.forgotPinTitle,
            isPresented: $isForgotPinDialogPresented,
            titleVisibility: .visible
        ) {
            forgotPinDialogActions
        } message: {
            Text(Constants.forgotPinMessage)
        }
    }
}

private extension PinView {
    var pinSection: some View {
        VStack(spacing: 0) {
            header
            pinCode
            errorText
            if viewModel.canShowForgotPin {
                forgotPinButton
            }
        }
    }

    var header: some View {
        VStack(spacing: 8) {
            Text(viewModel.title)
                .font(.appTitle)
                .foregroundStyle(Color(.appTitle))

            Text(viewModel.subtitle)
                .font(.appBody)
                .foregroundStyle(Color(.appBody))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 24)
        .animation(.easeInOut, value: viewModel.step)
    }

    var pinCode: some View {
        PinCodeView(pin: viewModel.pin, length: PinViewModel.pinLength)
            .shake(trigger: viewModel.shakeTrigger)
            .padding(.top, 32)
    }

    var errorText: some View {
        Text(viewModel.errorMessage ?? " ")
            .font(.appCaption)
            .foregroundStyle(Color(.appRed))
            .padding(.top, 16)
    }

    var forgotPinButton: some View {
        Button(Constants.forgotPinTitle) {
            isForgotPinDialogPresented = true
        }
        .buttonStyle(.plain)
        .font(.linkSemibold)
        .foregroundStyle(Color(.brandPrimary))
        .padding(.top, 8)
    }

    var numberPad: some View {
        NumberPadView(pin: $viewModel.pin, maxLength: PinViewModel.pinLength)
    }

    @ViewBuilder
    var forgotPinDialogActions: some View {
        Button("Log Out", role: .destructive) {
            handle(viewModel.forgotPin())
        }
        Button("Cancel", role: .cancel) {}
    }
}

private extension PinView {
    func pinDidChange(_ newPin: String) {
        guard newPin.count == PinViewModel.pinLength else { return }

        Task {
            try? await Task.sleep(for: .milliseconds(150))
            handle(viewModel.submit())
        }
    }

    func handle(_ result: PinResult) {
        switch result {
        case .success:
            withAnimation {
                router.root = .main
            }
        case .loggedOut:
            router.authPath = []
            withAnimation {
                router.root = .auth
            }
        case .incomplete:
            break
        }
    }
}

private extension PinView {
    enum Constants {
        static let forgotPinTitle = "Forgot PIN?"
        static let forgotPinMessage = "You will be logged out. Sign in with your email and password to create a new PIN."
    }
}

#Preview {
    PinView(mode: .unlock)
        .environment(AppRouter())
}
