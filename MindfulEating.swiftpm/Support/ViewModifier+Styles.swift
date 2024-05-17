//
//  ViewModifier+Styles.swift
//  
//
//  Created by Ho Le Minh Thach on 17/02/2024.
//

import SwiftUI

struct CardModifier: ViewModifier {
    
    var cornerRadius: CGFloat = 4
    var grayOpacity: Double = 0.4
    var shadowRadius: CGFloat = 8
    
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: .gray.opacity(grayOpacity), radius: shadowRadius)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.gray.opacity(0.1), lineWidth: 1)
            }
    }
    
}

struct QuoteModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .fontWeight(.semibold)
            .padding(.bottom, 8)
    }
    
}

struct QuoteAuthorModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.callout)
            .italic()
    }
    
}

struct FaceTrackingButtonModifier: ViewModifier {

    func body(content: Content) -> some View {
        ZStack {
            content
                .tint(.primary)
                .buttonStyle(.borderless)
                .controlSize(.extraLarge)
                .padding()
        }
        .background(.bar)
        .clipShape(Capsule())
        .shadow(color: .gray.opacity(0.4), radius: 8)
        .overlay {
            Capsule().stroke(.gray.opacity(0.1), lineWidth: 1)
        }
        .padding(32)
    }
}
