//
//  PrimaryButton.swift
//  
//
//  Created by Ho Le Minh Thach on 11/02/2024.
//

import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    
    var trigger: Bool
    
    struct AnimationValues {
        var opacity = 0.0
        var verticalStretch = 1.0
        var angle = Angle.zero
    }
    
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .font(.system(.title, design: .monospaced))
            .controlSize(.extraLarge)
            .tint(.accentColor)
            .keyframeAnimator(initialValue: AnimationValues(), trigger: trigger) { content, value in
                content
                    .rotationEffect(value.angle)
                    .opacity(value.opacity)
                    .scaleEffect(y: value.verticalStretch)
            } keyframes: { _ in
                KeyframeTrack(\.angle) {
                    CubicKeyframe(.zero, duration: 0.58)
                    CubicKeyframe(.degrees(8), duration: 0.125)
                    CubicKeyframe(.degrees(-8), duration: 0.125)
                    CubicKeyframe(.degrees(8), duration: 0.125)
                    CubicKeyframe(.zero, duration: 0.125)
                }
                
                KeyframeTrack(\.verticalStretch) {
                    CubicKeyframe(1.0, duration: 0.1)
                    CubicKeyframe(0.6, duration: 0.15)
                    CubicKeyframe(1.5, duration: 0.1)
                    CubicKeyframe(1.05, duration: 0.15)
                    CubicKeyframe(1.0, duration: 0.88)
                }
                
                KeyframeTrack(\.opacity) {
                    LinearKeyframe(1.0, duration: 0.1)
                }
            }
    }
}
