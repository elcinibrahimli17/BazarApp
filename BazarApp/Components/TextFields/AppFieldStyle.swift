//
//  AppFieldStyle.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//


import SwiftUI

struct AppFieldStyle: ViewModifier {
    let isFocused: Bool

    func body(content: Content) -> some View {
        content
            .font(.appBody)
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(Color(.gray50))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                if isFocused {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.brandPrimary), lineWidth: 1)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}

extension View {
    func appFieldStyle(isFocused: Bool) -> some View {
        modifier(AppFieldStyle(isFocused: isFocused))
    }
}
