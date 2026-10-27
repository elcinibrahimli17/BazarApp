//
//  View+AuthDestinations.swift
//  BazarApp
//
//  Created by Elchın on 22.10.26.
//

import SwiftUI

extension View {
    func authDestinations() -> some View {
        navigationDestination(for: AuthRoute.self) { route in
            switch route {
            case .signUp:
                SignUpView()
            case .signUpSuccess:
                SignUpSuccessView()
            }
        }
    }
}
