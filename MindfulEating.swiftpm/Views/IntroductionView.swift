//
//  IntroductionView.swift
//
//
//  Created by Ho Le Minh Thach on 10/02/2024.
//

import SwiftUI

struct IntroductionView: View {
    
    static private let title: String = "Why Choose Mindful Eating?"
    
    private var isTitleCompleteAnimate: Bool { title == Self.title }

    private var contentOpacity: Double { isTitleCompleteAnimate ? 1 : 0 }

    @State private var title: String       = ""
    @State private var content: String     = """
Have you ever rushed through a meal, missing the joy in each bite due to our fast-paced lives? When did you last truly enjoy the flavors on your plate, free from distractions like YouTube, TV, or social media? 

As we encourage you to embrace this simple yet powerful shift — being truly present with your food — we welcome you to Mindful Eating.
"""
    @State private var quote: String       = "\"Eating is not only nourishing for the body, but also for the mind.\""
    @State private var quoteAuthor: String = "- Thich Nhat Hanh, How to Eat"
    
    @Binding var currentView: ContentView.DisplayView
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack(spacing: 32) {
                    mainTextView
                    quoteTextView
                    primaryButtonView
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, proxy.size.width / 6)
        }
        .onAppear(perform: animateTypingTitle)
    }
    
    var mainTextView: some View {
        TitleAndContentView(
            title: $title,
            content: $content,
            contentHeight: 200,
            contentOpacity: contentOpacity,
            contentAnimationTrigger: isTitleCompleteAnimate
        )
    }
    
    var quoteTextView: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                Text(quote).modifier(QuoteModifier())
                Text(quoteAuthor).modifier(QuoteAuthorModifier())
            }
        }
        .padding(.bottom, 32)
        .opacity(title == Self.title ? 1 : 0)
        .animation(.easeInOut(duration: 1), value: title == Self.title)
    }
    
    var primaryButtonView: some View {
        Button {
            withAnimation { currentView = .benefits }
        } label: {
            Label("Continue", systemImage: "heart.fill")
        }
        .modifier(PrimaryButtonModifier(trigger: title == Self.title))
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
    IntroductionView(currentView: .constant(.introduction))
}
