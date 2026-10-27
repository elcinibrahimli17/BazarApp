//
//  MainView.swift
//  BazarApp
//
//  Created by Elchın on 22.10.26.
//

import SwiftUI

struct MainView: View {
    @Environment(AppRouter.self) private var router

    var body: some View {
        VStack(spacing: 24) {
            Text("Main")

            Button("Logout") {
                try? SessionService().logout()
                withAnimation {
                    router.root = .auth
                }
            }
            .buttonStyle(.primaryButton())
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    MainView()
        .environment(AppRouter())
}
