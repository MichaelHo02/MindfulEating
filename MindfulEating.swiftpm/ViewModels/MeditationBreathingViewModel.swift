//
//  MeditationBreathingViewModel.swift
//  
//
//  Created by Ho Le Minh Thach on 24/02/2024.
//

import SwiftUI

@Observable class MeditationViewModel {

    var model: FaceData

    init(_ model: FaceData) {
        self.model = model
    }

    let contemplationsAudio: [String] = [
        "contemplation1",
        "contemplation2",
        "contemplation3",
        "contemplation4",
        "contemplation5",
    ]

    var supportTextList: [String] = [
        "Breathing out with mouths open\nin a circle shape 😮",
        "Feel free to choose your own pace",
        "Just breathe naturally 😌",
        "This food is the gift of the whole universe, the earth, the sun, the sky, the stars and the hard and loving work of numerous beings.",
        "May we eat with mindfulness and gratitude\nso as to enjoy every bite.",
        "May we transform our unwholesome mental formations,\nespecially those that cause us harm,\nas they indirectly harm all we touch.",
        "May we keep our compassion alive by eating in such a way that we reduce the suffering of living beings, and preserve our precious planet.",
        "We accept this food so that we may realize the path of understanding and love.",
    ]

    var supportText: String           = "Breathing in through your nose\nand close your mouth 👃"
    var contemplationIndex: Int       = 0
    var numberOfRemovedText: Int      = 1
    var continueButtonVisible: Bool   = false
    var instructionCanBeUpdated: Bool = true

    var meditationBreathingViewTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var breathingAnimationTimer      = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    var scale: Double                     = 1
    var breathingCount: Double            = 0
    var balloonState: BalloonState        = .neutralState
    var showMeditationBreathingView: Bool = false

    var timeCount: Int  = 5
    
    var breathingStatus: String { model.isExhale ? "Breathing Out" : "Breathing In" }

    var breathingCountRoundedUp: Int { Int(breathingCount.rounded(.towardZero)) }

    // MARK: Logic

    /// Handle onAppear of the view
    func handleOnAppear() {
        stopMeditationBreathingViewTimer()
        stopBreathingAnimationTimer()
        Sound.storeSounds(sounds: self.contemplationsAudio)
    }

    /// Handle interval update of the Display meditation breathing view timer
    func handleDisplayMeditationBreathingView(date: Date) {
        if timeCount <= 0 && showMeditationBreathingView == false {
            stopMeditationBreathingViewTimer()
            showMeditationBreathingView = true
            startBreathingAnimationTimer()
            return
        }

        timeCount -= 1
    }

    /// Handle interval update of the breathing animation timer
    func handleBreathingAnimation(date: Date) {
        if showMeditationBreathingView == false { return }
        breathingCount += 0.01

        withAnimation { // update the support text after 3 seconds
            if breathingCountRoundedUp == 3 && instructionCanBeUpdated {
                supportText = supportTextList.removeFirst()
                numberOfRemovedText += 1
                instructionCanBeUpdated = false
            }
        }

        // scale up or down the Circular Breathing Object based on breathing
        withAnimation(.smooth(duration: 2)) {
            if model.isExhale {
                if self.balloonState == .minimumState { return }
                self.scale -= 0.01
            } else {
                if self.balloonState == .maximumState { return }
                self.scale += 0.01
            }
        }
    }

    func handleFaceDetectedState(oldValue: Bool, newValue: Bool) {
        if newValue { // face detected == true
            startMeditationBreathingViewTimer()
        } else {
            timeCount = 5
            showMeditationBreathingView = false
            stopMeditationBreathingViewTimer()
        }
    }

    func handleExhaleState(oldValue: Bool, newValue: Bool) {
        breathingCount = 0
        if numberOfRemovedText < 4 { // first 4 guiding instructions will render based on the timer
            instructionCanBeUpdated = true
            return
        }
        if newValue == false { // the remains instructions will be render by changing the breathing state
            // check if this is the first contemplation or not -> if so then play the audio and render support text
            // else check if the previous audio is finished -> if so then play the audio and render the next support text
            if contemplationIndex == 0 || Sound.soundEffects[contemplationIndex - 1].isPlaying == false {
                if supportTextList.isEmpty { // if the support text list is empty then the process is completed
                    supportText = "Well Done! Let's eat!"
                    continueButtonVisible = true
                    stopBreathingAnimationTimer()
                    return
                }
                supportText = supportTextList.removeFirst()
                DispatchQueue.global(qos: .background).async {
                    Sound.play(index: self.contemplationIndex)
                    self.contemplationIndex += 1
                }
            }
        }
    }

    /// This function will start the meditationBreathingViewTimer
    func startMeditationBreathingViewTimer() {
        self.meditationBreathingViewTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }

    /// This function will stop the meditationBreathingViewTimer
    func stopMeditationBreathingViewTimer() {
        self.meditationBreathingViewTimer.upstream.connect().cancel()
    }

    /// This function will start the breathingAnimationTimer
    func startBreathingAnimationTimer() {
        self.breathingAnimationTimer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }

    /// This function will stop the breathingAnimationTimer
    func stopBreathingAnimationTimer() {
        self.breathingAnimationTimer.upstream.connect().cancel()
    }

}

extension MeditationViewModel {

    enum BalloonState {
        case minimumState
        case neutralState
        case maximumState

        mutating func validateAndUpdateBalloonState(_ scale: CGFloat, _ size: CGSize) {
            let currentShapeSize = scale * 100
            if currentShapeSize <= 100 { self = .minimumState }
            else if currentShapeSize >= min(size.width, size.height) { self = .maximumState }
            else { self = .neutralState }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .minimumState, .neutralState: 100
            case .maximumState: 4
            }
        }
    }

}
