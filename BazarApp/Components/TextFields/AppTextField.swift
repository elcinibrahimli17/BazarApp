//
//  AppTextField.swift
//  BazarApp
//
//  Created by Elchın on 25.10.26.
//

import SwiftUI

struct AppTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var contentType: UITextContentType? = nil
    var autocapitalization: TextInputAutocapitalization = .sentences

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.fieldLabel)
                .foregroundStyle(Color(.appTitle))

            TextField(placeholder, text: $text)
                .focused($isFocused)
                .keyboardType(keyboardType)
                .textContentType(contentType)
                .textInputAutocapitalization(autocapitalization)
                .autocorrectionDisabled()
                .appFieldStyle(isFocused: isFocused)
                .contentShape(RoundedRectangle(cornerRadius: 8))
                .onTapGesture {
                    isFocused = true
                }
        }
    }
}

#Preview {
    AppTextField(
        label: "Email",
        placeholder: "Your email",
        text: .constant(""),
        keyboardType: .emailAddress
    )
    .padding()
}
