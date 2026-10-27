//
//  PasswordRuleRow.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//


import SwiftUI

struct PasswordRuleRow: View {
    let text: String
    let isSatisfied: Bool

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: isSatisfied ? "checkmark" : "xmark")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(isSatisfied ? Color(.brandPrimary) : Color(.appRed))
                .frame(width: 12)

            Text(text)
                .font(.appCaption)
                .foregroundStyle(Color(.appBody))
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 6) {
        PasswordRuleRow(text: "Minimum 8 characters", isSatisfied: false)
        PasswordRuleRow(text: "Atleast 1 number (1-9)", isSatisfied: true)
    }
    .padding()
}