//
//  ActivityView.swift
//
//
//  Created by Ho Le Minh Thach on 24/02/2024.
//

import SwiftUI

struct ActivityView: View {

    @State private var model: FaceData
    @State private var viewModel: ActivityViewModel

    @Binding var currentView: ContentView.DisplayView

    init(currentView: Binding<ContentView.DisplayView>) {
        let model = FaceData()
        self.model = model
        self.viewModel = ActivityViewModel(model)
        _currentView = currentView
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 16) {
                if viewModel.showMeditationBreathingView {
                    HStack(spacing: 16) {
                        ActivityInstructionView(viewModel: viewModel)
                        InfoCard(viewModel: viewModel)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                } else {
                    FaceTrackInstructionView(model: model, timeCount: $viewModel.timeCount)
                }
                FaceTrackView(model: model)
            }
            .padding()
            .onReceive(viewModel.meditationBreathingViewTimer, perform: viewModel.handleDisplayMeditationBreathingView)
            .onReceive(viewModel.eatingTimer, perform: viewModel.handleEatingTimer)
            .onChange(of: viewModel.model.isChewing, viewModel.handleIsChewing)
            .onChange(of: viewModel.model.isMouthOpen, viewModel.handleMouthOpen)
            .onChange(of: viewModel.model.isFaceDetected, viewModel.handleFaceDetectedState)
            .animation(.smooth, value: viewModel.showMeditationBreathingView)
        }
        .overlay(alignment: .bottomTrailing) { actionBarView }
    }

    /// Render the skip or continue button
    private var actionBarView: some View {
        Button {
            viewModel.session.totalEatingTime = viewModel.eatTimeCounter
            currentView = .reflection(session: viewModel.session)
        } label: {
            Label(viewModel.showMeditationBreathingView ? "Finish Meal" : "Skip", systemImage: "chevron.right.2")
                .labelStyle(.titleAndIcon)
        }
        .modifier(FaceTrackingButtonModifier())
    }

}

#Preview {
    ActivityView(currentView: .constant(.activity))
}
