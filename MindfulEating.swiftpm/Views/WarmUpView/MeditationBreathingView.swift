//
//  MeditationBreathingView.swift
//
//
//  Created by Ho Le Minh Thach on 20/02/2024.
//

import SwiftUI
import AVFoundation

struct MeditationBreathingView: View {

    var viewModel: MeditationViewModel

    @Binding var currentView: ContentView.DisplayView

    var body: some View {
        ZStack {
            circularBreathingView
            breathingSupportText
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
        .opacity(viewModel.showMeditationBreathingView ? 1 : 0)
        .animation(.smooth(duration: 0.5), value: viewModel.showMeditationBreathingView)
        .onAppear(perform: viewModel.handleOnAppear)
        .onReceive(viewModel.meditationBreathingViewTimer, perform: viewModel.handleDisplayMeditationBreathingView)
        .onReceive(viewModel.breathingAnimationTimer, perform: viewModel.handleBreathingAnimation)
        .onChange(of: viewModel.model.isFaceDetected, viewModel.handleFaceDetectedState)
        .onChange(of: viewModel.model.isExhale, viewModel.handleExhaleState)
    }

    /// Render the Circular Breathing Object
    private var circularBreathingView: some View {
        GeometryReader { proxy in
            Rectangle()
                .fill(viewModel.model.isExhale ? Color.purple.opacity(0.6) : Color.mint.opacity(0.6))
                .background(.ultraThinMaterial.opacity(0.6))
                .frame(width: 100 * viewModel.scale, height: 100 * viewModel.scale)
                .animation(.smooth(duration: 2), value: viewModel.model.isExhale)
                .overlay { circlePingView }
                .clipShape(RoundedRectangle(cornerRadius: viewModel.balloonState.cornerRadius))
                .shadow(color: .gray.opacity(0.4), radius: 8)
                .onChange(of: viewModel.scale) { _, newValue in
                    withAnimation {
                        viewModel.balloonState.validateAndUpdateBalloonState(newValue, proxy.size)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    /// Render the ping circle object inside the Circular Breathing Object
    private var circlePingView: some View {
        Circle()
            .phaseAnimator([false, true]) { content, value in
                content
                    .foregroundStyle(viewModel.model.isExhale ? Color.purple.opacity(0.2) : Color.accentColor.opacity(0.2))
                    .scaleEffect(value ? CGSize(width: 1, height: 1) : .zero)
            } animation: {
                $0 ? .linear(duration: 3.0) : .none
            }
    }

    /// Render the support text to guide the warnup phase
    private var breathingSupportText: some View {
        VStack(spacing: 16) {
            Text(viewModel.breathingStatus.capitalized)
                .font(.subheadline)
                .fontDesign(.rounded)
                .fontWeight(.semibold)

            Text(viewModel.supportText)
                .multilineTextAlignment(.center)
                .animation(.smooth, value: viewModel.supportText)
        }
        .frame(width: 450)
    }

}
