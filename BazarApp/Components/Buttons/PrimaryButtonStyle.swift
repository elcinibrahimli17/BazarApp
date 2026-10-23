//
//  PrimaryButtonStyle.swift
//  BazarApp
//
//  Created by Elchın on 23.10.26.
//


import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.button)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color(.brandPrimary))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

extension View {
    func primaryButtonStyle() -> some View {
        buttonStyle(PrimaryButtonStyle())
    }
}


