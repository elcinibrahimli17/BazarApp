//
//  SocialButtonStyle.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//

import SwiftUI

struct SocialButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.link)
            .foregroundStyle(Color(.appTitle))
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .overlay {
                Capsule()
                    .stroke(Color(.gray200), lineWidth: 1)
            }
            .contentShape(Capsule())
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}

extension ButtonStyle where Self == SocialButtonStyle {
    static var socialMedia: SocialButtonStyle {
        SocialButtonStyle()
    }
}
