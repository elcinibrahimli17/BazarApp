//
//  SignUpView.swift
//  BazarApp
//
//  Created by Elchın on 22.10.26.
//

import SwiftUI

struct SignUpView: View {
    @Environment(AppRouter.self) private var router
    @State private var viewModel = SignUpViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                header
                formFields
                registerButton
                signInLink
            }
            .padding(24)
        }
        .scrollDismissesKeyboard(.interactively)
        .safeAreaInset(edge: .bottom) {
            termsText
        }
        .customBackButton()
        .loadingOverlay(isLoading: viewModel.isLoading)
        .errorAlert(message: $viewModel.errorMessage)
    }
}

private extension SignUpView {
    var header: some View {
        AuthHeaderView(
            title: Constants.title,
            subtitle: Constants.subtitle
        )
    }

    var formFields: some View {
        VStack(alignment: .leading, spacing: 16) {
            nameField
            emailField
            passwordField

            if viewModel.shouldShowPasswordRules {
                passwordRules
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.shouldShowPasswordRules)
    }

    var nameField: some View {
        AppTextField(
            label: "Name",
            placeholder: "Your name",
            text: $viewModel.name,
            contentType: .name,
            autocapitalization: .words
        )
    }

    var emailField: some View {
        AppTextField(
            label: "Email",
            placeholder: "Your email",
            text: $viewModel.email,
            keyboardType: .emailAddress,
            contentType: .emailAddress,
            autocapitalization: .never
        )
    }

    var passwordField: some View {
        AppSecureField(
            label: "Password",
            placeholder: "Your password",
            text: $viewModel.password,
            contentType: .newPassword
        )
    }

    var passwordRules: some View {
        VStack(alignment: .leading, spacing: 6) {
            PasswordRuleRow(text: "Minimum 8 characters", isSatisfied: viewModel.hasMinLength)
            PasswordRuleRow(text: "Atleast 1 number (1-9)", isSatisfied: viewModel.hasNumber)
            PasswordRuleRow(text: "Atleast lowercase or uppercase letters", isSatisfied: viewModel.hasLetter)
        }
    }

    var registerButton: some View {
        Button("Register") {
            Task { await register() }
        }
        .buttonStyle(.primaryButton(cornerRadius: 24))
        .disabled(!viewModel.canRegister)
    }

    var signInLink: some View {
        AuthFooterLink(
            question: "Have an account?",
            actionTitle: "Sign In",
            action: .goBack
        )
    }

    var termsText: some View {
        Text("By clicking Register, you agree to our \(Text("Terms, Data Policy.").foregroundStyle(Color(.brandPrimary)))")
            .font(.link)
            .foregroundStyle(Color(.appBody))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 66)
            .padding(.bottom, 8)
    }
}

private extension SignUpView {
    func register() async {
        let isSuccess = await viewModel.signUp()
        guard isSuccess else { return }

        router.authPath.append(.signUpSuccess)
    }
}

private extension SignUpView {
    enum Constants {
        static let title = "Sign Up"
        static let subtitle = "Create account and choose favorite menu"
    }
}

#Preview {
    NavigationStack {
        SignUpView()
    }
    .environment(AppRouter())
}
