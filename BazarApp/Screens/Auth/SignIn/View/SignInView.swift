//
//  SignInView.swift
//  BazarApp
//
//  Created by Elchın on 22.10.26.
//


import SwiftUI

struct SignInView: View {
    @Environment(AppRouter.self) private var router
    @State private var viewModel = SignInViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                header
                formFields
                forgotPasswordButton
                loginButton
                signUpLink
                OrDivider()
                socialButtons
            }
            .padding(24)
        }
        .scrollDismissesKeyboard(.interactively)
        .loadingOverlay(isLoading: viewModel.isLoading)
        .errorAlert(message: $viewModel.errorMessage)
    }
}

private extension SignInView {
    var header: some View {
        AuthHeaderView(
            title: Constants.title,
            subtitle: Constants.subtitle
        )
    }

    var formFields: some View {
        VStack(spacing: 16) {
            AppTextField(
                label: "Email",
                placeholder: "Your email",
                text: $viewModel.email,
                keyboardType: .emailAddress,
                contentType: .emailAddress,
                autocapitalization: .never
            )

            AppSecureField(
                label: "Password",
                placeholder: "Your password",
                text: $viewModel.password
            )
        }
    }

    var forgotPasswordButton: some View {
        Button("Forgot Password?") {
            
        }
        .buttonStyle(.plain)
        .font(.linkSemibold)
        .foregroundStyle(Color(.brandPrimary))
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var loginButton: some View {
        Button("Login") {
            Task { await login() }
        }
        .buttonStyle(.primaryButton(cornerRadius: 24))
        .disabled(!viewModel.canLogin)
    }

    var signUpLink: some View {
        AuthFooterLink(
            question: "Don't have an account?",
            actionTitle: "Sign Up",
            action: .navigate(.signUp)
        )
    }

    var socialButtons: some View {
        VStack(spacing: 12) {
            Button {
                
            } label: {
                Label("Sign in with Google", image: .googleLogo)
            }
            .buttonStyle(.socialMedia)

            Button {
                
            } label: {
                Label("Sign in with Apple", image: .appleLogo)
            }
            .buttonStyle(.socialMedia)
        }
    }
}

private extension SignInView {
    func login() async {
        let isSuccess = await viewModel.signIn()
        guard isSuccess else { return }

        router.authPath = []
        withAnimation {
            router.root = .pin(.create)
        }
    }
}

private extension SignInView {
    enum Constants {
        static let title = "Welcome Back 👋"
        static let subtitle = "Sign to your account"
    }
}

#Preview {
    NavigationStack {
        SignInView()
    }
    .environment(AppRouter())
}
