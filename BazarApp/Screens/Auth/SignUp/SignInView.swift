//
//  SignInView.swift
//  BazarApp
//
//  Created by Elchın on 22.10.26.
//


import SwiftUI

struct SignInView: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        VStack(spacing: 16) {
            Text("Sign In")

            Button("Sign Up") {
                router.authPath.append(.signUp)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SignInView()
    }
    .environment(AppRouter())
}
