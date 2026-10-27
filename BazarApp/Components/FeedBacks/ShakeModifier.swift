//
//  ShakeModifier.swift
//  BazarApp
//
//  Created by Elchın on 27.10.26.
//


import SwiftUI

struct ShakeModifier: ViewModifier {
    let trigger: Int

    func body(content: Content) -> some View {
        content
            .keyframeAnimator(initialValue: 0.0, trigger: trigger) { view, offset in
                view.offset(x: offset)
            } keyframes: { _ in
                KeyframeTrack {
                    LinearKeyframe(-12, duration: 0.06)
                    LinearKeyframe(12, duration: 0.06)
                    LinearKeyframe(-8, duration: 0.06)
                    LinearKeyframe(8, duration: 0.06)
                    LinearKeyframe(0, duration: 0.06)
                }
            }
    }
}

extension View {
    func shake(trigger: Int) -> some View {
        modifier(ShakeModifier(trigger: trigger))
    }
}