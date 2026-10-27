//
//  ErrorAlert.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//


import SwiftUI

struct ErrorAlert: ViewModifier {
    @Binding var message: String?

    private var isPresented: Binding<Bool> {
        Binding(
            get: { message != nil },
            set: { isShowing in
                if !isShowing { message = nil }
            }
        )
    }

    func body(content: Content) -> some View {
        content
            .alert("Error", isPresented: isPresented) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(message ?? "")
            }
    }
}

extension View {
    func errorAlert(message: Binding<String?>) -> some View {
        modifier(ErrorAlert(message: message))
    }
}