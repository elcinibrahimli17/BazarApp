//
//  OrDivider.swift
//  BazarApp
//
//  Created by Elchın on 26.10.26.
//


import SwiftUI

struct OrDivider: View {
    var body: some View {
        HStack(spacing: 12) {
            line
            Text("Or with")
                .font(.appCaption)
                .foregroundStyle(Color(.appBody))
            line
        }
    }

    private var line: some View {
        Rectangle()
            .fill(Color(.gray200))
            .frame(height: 1)
    }
}

#Preview {
    OrDivider()
        .padding()
}
