//
//  SecondaryButtonStyle.swift
//  BazarApp
//
//  Created by Elchın on 23.10.26.
//


import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.button)
            .foregroundStyle(Color(.brandPrimary))
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color(.brandPrimary).opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}

extension View {
    func secondaryButtonStyle() -> some View {
        buttonStyle(SecondaryButtonStyle())
    }
}
