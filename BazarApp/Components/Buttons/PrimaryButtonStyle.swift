//
//  PrimaryButtonStyle.swift
//  BazarApp
//
//  Created by Elchın on 23.10.26.
//


import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat = 12
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.button)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(Color(.brandPrimary), in: RoundedRectangle(cornerRadius: cornerRadius))
            .opacity(isEnabled ? (configuration.isPressed ? 0.8 : 1) : 0.5)
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static func primaryButton(cornerRadius: CGFloat = 12) -> PrimaryButtonStyle {
        PrimaryButtonStyle(cornerRadius: cornerRadius)
    }
}


