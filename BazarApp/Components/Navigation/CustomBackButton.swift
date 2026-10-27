//
//  CustomBackButton.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//

import SwiftUI

struct CustomBackButton: ViewModifier {
    @Environment(\.dismiss) private var dismiss

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(uiImage: .arrowback)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(Color(.appTitle))
                    }
                    .accessibilityLabel("Back")
                }
            }
    }
}

extension View {
    func customBackButton() -> some View {
        modifier(CustomBackButton())
    }
}
