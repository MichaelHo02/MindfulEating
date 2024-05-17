//
//  MeditationView.swift
//
//
//  Created by Ho Le Minh Thach on 16/02/2024.
//

import SwiftUI

struct MeditationView: View {
    
    @State private var model: FaceData
    @State private var viewModel: MeditationViewModel

    @Binding var currentView: ContentView.DisplayView

    init(currentView: Binding<ContentView.DisplayView>) {
        let model = FaceData()
        self.model = model
        self.viewModel = MeditationViewModel(model)
        _currentView = currentView
    }

    var body: some View {
        ZStack {
            VStack {
                FaceTrackInstructionView(model: model, timeCount: $viewModel.timeCount)
                FaceTrackView(model: model)
            }
            .padding()

            MeditationBreathingView(viewModel: viewModel, currentView: $currentView)
        }
        .overlay(alignment: .bottomTrailing) { actionBarView }
    }

    /// Render the skip or continue button
    private var actionBarView: some View {
        Button {
            currentView = .activity
        } label: {
            Label(viewModel.continueButtonVisible ? "Continue" : "Skip", systemImage: "chevron.right.2")
                .labelStyle(.titleAndIcon)
        }
        .modifier(FaceTrackingButtonModifier())
    }

}

#Preview {
    MeditationView(currentView: .constant(.warmup))
}
