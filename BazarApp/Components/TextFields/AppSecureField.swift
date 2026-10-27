//
//  AppSecureField.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//

import SwiftUI

struct AppSecureField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var contentType: UITextContentType = .password

    @State private var isTextVisible = false
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.fieldLabel)
                .foregroundStyle(Color(.appTitle))

            HStack(spacing: 8) {
                Group {
                    if isTextVisible {
                        TextField(placeholder, text: $text)
                    } else {
                        SecureField(placeholder, text: $text)
                    }
                }
                .focused($isFocused)
                .textContentType(contentType)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

                Button {
                    isTextVisible.toggle()
                } label: {
                    Image(systemName: isTextVisible ? "eye" : "eye.slash")
                        .foregroundStyle(Color(.appBody))
                }
                .accessibilityLabel(isTextVisible ? "Hide password" : "Show password")
            }
            .appFieldStyle(isFocused: isFocused)
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .onTapGesture {
                isFocused = true
            }
        }
    }
}

#Preview {
    AppSecureField(
        label: "Password",
        placeholder: "Your password",
        text: .constant("")
    )
    .padding()
}
