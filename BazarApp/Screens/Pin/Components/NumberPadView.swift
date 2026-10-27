//
//  NumberPadView.swift
//  BazarApp
//
//  Created by Elchın on 27.10.26.
//


import SwiftUI

struct NumberPadView: View {
    @Binding var pin: String
    let maxLength: Int

    private enum Key: Hashable {
        case digit(Int)
        case delete
        case empty
    }

    private let rows: [[Key]] = [
        [.digit(1), .digit(2), .digit(3)],
        [.digit(4), .digit(5), .digit(6)],
        [.digit(7), .digit(8), .digit(9)],
        [.empty, .digit(0), .delete]
    ]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(row, id: \.self) { key in
                        keyButton(key)
                    }
                }
            }
        }
        .padding(.vertical, 16)
        .background(Color(.brandPrimary).ignoresSafeArea(edges: .bottom))
        .sensoryFeedback(.impact(weight: .light), trigger: pin)
    }

    @ViewBuilder
    private func keyButton(_ key: Key) -> some View {
        switch key {
        case .digit(let number):
            Button {
                handle(key)
            } label: {
                Text("\(number)")
                    .font(.appTitle)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 72)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

        case .delete:
            Button {
                handle(key)
            } label: {
                Image(systemName: "delete.left")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 72)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Delete")

        case .empty:
            Color.clear
                .frame(maxWidth: .infinity)
                .frame(height: 72)
        }
    }

    private func handle(_ key: Key) {
        switch key {
        case .digit(let number):
            guard pin.count < maxLength else { return }
            pin.append(String(number))
        case .delete:
            guard !pin.isEmpty else { return }
            pin.removeLast()
        case .empty:
            break
        }
    }
}

#Preview {
    NumberPadView(pin: .constant(""), maxLength: 4)
}
