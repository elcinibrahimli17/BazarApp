//
//  AuthHeaderView.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//

import SwiftUI

struct AuthHeaderView: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.appTitle)
                .foregroundStyle(Color(.appTitle))

            Text(subtitle)
                .font(.appSubtitle)
                .foregroundStyle(Color(.appBody))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    AuthHeaderView(
        title: "Welcome Back 👋",
        subtitle: "Sign to your account"
    )
    .padding()
}
