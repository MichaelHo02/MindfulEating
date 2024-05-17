//
//  OnboardView.swift
//
//
//  Created by Ho Le Minh Thach on 11/02/2024.
//

import SwiftUI

struct OnboardView: View {

    static private let title    = "Mindful Eating"
    static private let subtitle = "Transform your relationship with food\nSavor every bite, nourish every moment"
    static private let footer   = "WWDC Swift Student Challenge developed by Thach Ho"

    @Binding var currentView: ContentView.DisplayView

    @State private var title: String    = ""
    @State private var subtitle: String = Self.subtitle

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 32) {
                    titleView
                    subtitleView
                    primaryButtonView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottomLeading) { footerView }
            .overlay(alignment: .bottomTrailing) { authorImageView(width: proxy.size.height) }
        }
        .padding()
        .onAppear(perform: animateTypingTitle)
    }

    var titleView: some View {
        Text(title)
            .foregroundStyle(Color.accentColor)
            .font(.system(size: 64, design: .monospaced))
    }

    var subtitleView: some View {
        Text(subtitle)
            .font(.system(.title, design: .monospaced))
            .multilineTextAlignment(.center)
            .lineSpacing(16)
            .padding(.bottom, 32)
            .opacity(title == Self.title ? 1 : 0)
            .animation(.easeInOut(duration: 1), value: title == Self.title)
    }

    var primaryButtonView: some View {
        Button {
            withAnimation { currentView = .introduction }
        } label: {
            Label("Continue", systemImage: "heart.fill")
        }
        .modifier(PrimaryButtonModifier(trigger: title == Self.title))
    }

    var footerView: some View {
        Text(Self.footer)
            .font(.system(.body, design: .monospaced))
            .padding()
    }

    @ViewBuilder
    func authorImageView(width: Double) -> some View {
        Image("OnboardAuthor")
            .resizable()
            .scaledToFit()
            .frame(width: width / 6)
    }

    func animateTypingTitle() {
        withAnimation(.linear(duration: 0.01)) {
            Self.title.enumerated().forEach { index, character in
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.15) {
                    title += String(character)
                }
            }
        }
    }

}

#Preview {
    OnboardView(currentView: .constant(.onboard))
}
