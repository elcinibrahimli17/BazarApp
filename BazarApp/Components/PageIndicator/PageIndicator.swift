//
//  PageIndicator.swift
//  BazarApp
//
//  Created by Elchın on 23.10.26.
//


import SwiftUI

struct PageIndicator: View {
    let count: Int
    let currentIndex: Int

    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<count, id: \.self) { index in
                let isActive = index == currentIndex
                let size: CGFloat = isActive ? 8 : 4

                Circle()
                    .fill(isActive ? Color(.brandPrimary) : Color(.appBody))
                    .frame(width: size, height: size)
            }
        }
        .animation(.easeInOut, value: currentIndex)
    }
}

#Preview {
    PageIndicator(count: 3, currentIndex: 0)
}
