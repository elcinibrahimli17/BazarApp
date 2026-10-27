//
//  SignUpSuccessView.swift
//  BazarApp
//
//  Created by Elchın on 27.10.26.
//


import SwiftUI

struct SignUpSuccessView: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        VStack(spacing: 24) {
            illustration
            texts
            getStartedButton
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}

private extension SignUpSuccessView {
    var illustration: some View {
        Image(.successBox)
            .resizable()
            .scaledToFit()
            .frame(width: 160, height: 91)
    }

    var texts: some View {
        VStack(spacing: 8) {
            Text(Constants.title)
                .font(.appTitle)
                .foregroundStyle(Color(.appTitle))

            Text(Constants.message)
                .font(.appBody)
                .foregroundStyle(Color(.appBody))
                .multilineTextAlignment(.center)
        }
    }

    var getStartedButton: some View {
        Button("Get Started") {
            finish()
        }
        .buttonStyle(.primaryButton(cornerRadius: 24))
        .padding(.top, 8)
    }
}

private extension SignUpSuccessView {
    func finish() {
        router.authPath = []
        withAnimation {
            router.root = .pin(.create)
        }
    }
}

private extension SignUpSuccessView {
    enum Constants {
        static let title = "Congratulation!"
        static let message = "your account is complete, please enjoy the best menu from us."
    }
}

#Preview {
    NavigationStack {
        SignUpSuccessView()
    }
    .environment(AppRouter())
}
