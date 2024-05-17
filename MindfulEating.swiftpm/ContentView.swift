//
//  ContentView.swift
//
//
//  Created by Ho Le Minh Thach on 10/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    enum DisplayView {
        case onboard
        case introduction
        case benefits
        case warmup
        case activity
        case reflection(session: EatingSessionData)
        case journal
    }

    @State var currentView: DisplayView = DisplayView.onboard
    
    var body: some View {
        switch currentView {
        case .onboard:
            OnboardView(currentView: $currentView)
                .modifier(ViewTransitionModifier())
        case .introduction:
            IntroductionView(currentView: $currentView)
                .modifier(ViewTransitionModifier())
        case .benefits:
            BenefitsView(currentView: $currentView)
                .modifier(ViewTransitionModifier())
        case .warmup:
            WarmUpView(currentView: $currentView)
                .modifier(ViewTransitionModifier())
        case .activity:
            ActivityView(currentView: $currentView)
                .modifier(ViewTransitionModifier())
        case .reflection(let session):
            ReflectionView(session: session, currentView: $currentView)
                .modifier(ViewTransitionModifier())
        case .journal:
            JournalView(currentView: $currentView)
                .modifier(ViewTransitionModifier())
        }
    }

}

struct ViewTransitionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .transition(.push(from: .trailing))
            .transition(.opacity)
    }
}
