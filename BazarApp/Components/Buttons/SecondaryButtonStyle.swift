//
//  SecondaryButtonStyle.swift
//  BazarApp
//
//  Created by Elchın on 23.10.26.
//


import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat = 12

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.button)
            .foregroundStyle(Color(.brandPrimary))
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(Color(.primary50), in: RoundedRectangle(cornerRadius: cornerRadius))
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}

extension ButtonStyle where Self == SecondaryButtonStyle {
    static func secondaryButton(cornerRadius: CGFloat = 12) -> SecondaryButtonStyle {
        SecondaryButtonStyle(cornerRadius: cornerRadius)
    }
}

//extension View {
//    func secondaryButtonStyle() -> some View {
//        buttonStyle(SecondaryButtonStyle())
//    }
//}
