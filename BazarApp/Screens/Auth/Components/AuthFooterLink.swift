//
//  AuthFooterLink.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//

import SwiftUI

enum AuthFooterAction {
    case navigate(AuthRoute)
    case goBack
}

struct AuthFooterLink: View {
    let question: String
    let actionTitle: String
    let action: AuthFooterAction

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        HStack(spacing: 4) {
            Text(question)
                .foregroundStyle(Color(.appBody))

            actionView
                .buttonStyle(.plain)
                .foregroundStyle(Color(.brandPrimary))
        }
        .font(.footer)
    }

    @ViewBuilder
    private var actionView: some View {
        switch action {
        case .navigate(let route):
            NavigationLink(actionTitle, value: route)
        case .goBack:
            Button(actionTitle) {
                dismiss()
            }
        }
    }
}

#Preview {
    NavigationStack {
        AuthFooterLink(
            question: "Don't have an account?",
            actionTitle: "Sign Up",
            action: .navigate(.signUp)
        )
    }
}
