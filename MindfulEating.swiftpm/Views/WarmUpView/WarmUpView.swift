//
//  WarmUpView.swift
//
//
//  Created by Ho Le Minh Thach on 13/02/2024.
//

import SwiftUI
import Charts

struct WarmUpView: View {
    
    @Binding var currentView: ContentView.DisplayView
    
    @State private var startMeditationView: Bool = false
    
    var body: some View {
        if startMeditationView {
            MeditationView(currentView: $currentView)
        } else {
            InstructionsView(startMeditationView: $startMeditationView)
        }
    }
}

#Preview {
    WarmUpView(currentView: .constant(.warmup))
}
