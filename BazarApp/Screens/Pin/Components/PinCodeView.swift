//
//  PinCodeView.swift
//  BazarApp
//
//  Created by Elchın on 27.10.26.
//

import SwiftUI

struct PinCodeView: View {
    let pin: String
    let length: Int

    var body: some View {
        HStack(spacing: 16) {
            ForEach(0..<length, id: \.self) { index in
                box(at: index)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(pin.count) of \(length) digits entered")
    }

    private func box(at index: Int) -> some View {
        let isFilled = index < pin.count
        let isActive = index == pin.count

        return RoundedRectangle(cornerRadius: 8)
            .fill(Color(.gray50))
            .frame(width: 56, height: 56)
            .overlay {
                if isFilled {
                    Circle()
                        .fill(Color(.appTitle))
                        .frame(width: 12, height: 12)
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.brandPrimary), lineWidth: isActive ? 1 : 0)
            }
    }
}

#Preview {
    PinCodeView(pin: "12", length: 4)
}
